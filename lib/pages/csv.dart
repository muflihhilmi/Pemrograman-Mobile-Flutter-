import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializer {
  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: 'https://xzhwnttqotcnycohoznl.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6aHdudHRxb3Rjbnljb2hvem5sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUzMzUwMzQsImV4cCI6MjA1MDkxMTAzNH0.s722_iG0aJgp3c2aYOh2h0MYCWVdcda-5YHQ_k7A-68',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CsvUploader(),
    );
  }
}

class CsvUploader extends StatefulWidget {
  @override
  _CsvUploaderState createState() => _CsvUploaderState();
}

class _CsvUploaderState extends State<CsvUploader> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<String> _createCsvFile() async {
    // Data untuk CSV
    List<List<dynamic>> rows = [
      ["id", "email", "name"],
      ["user-id-1", "user1@example.com", "User One"],
      ["user-id-2", "user2@example.com", "User Two"],
      ["user-id-3", "user3@example.com", "User Three"],
    ];

    // Konversi data ke format CSV
    String csvData = const ListToCsvConverter().convert(rows);

    // Simpan file di direktori lokal
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.csv');
    await file.writeAsString(csvData);

    return file.path;
  }

  Future<void> _uploadCsvFile() async {
    try {
      // Buat file CSV
      String filePath = await _createCsvFile();
      File csvFile = File(filePath);

      // Upload file ke bucket Supabase
      final response = await _supabaseClient.storage
          .from('your-bucket-name')
          .upload('users/users.csv', csvFile);

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File berhasil diupload ke Supabase!')),
        );
      } else {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupload file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload CSV ke Supabase'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadCsvFile,
          child: Text('Buat dan Upload CSV'),
        ),
      ),
    );
  }
}

extension on String {
  get error => null;
}

// Menjalankan aplikasi tanpa void main
Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseInitializer.initializeSupabase();
  runApp(const MyApp());
}
