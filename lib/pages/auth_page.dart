import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pizza_delivery/pages/discover_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  bool isPasswordVisible = false;
  String password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  // Initialize Supabase
  final _supabaseClient = Supabase.instance.client;

  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get hasMinLength => password.length >= 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [Colors.red, Colors.white],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _TabSwitch(
                      isSignIn: isSignIn,
                      onSwitch: (bool value) {
                        setState(() {
                          isSignIn = value;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    // Sign In Form
                    if (isSignIn) _buildSignInForm(),
                    // Sign Up Form
                    if (!isSignIn) _buildSignUpForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            try {
              final response = await _supabaseClient.auth.signInWithPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );

              if (response.user != null) {
                // Berhasil masuk, pindah ke halaman berikutnya
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DiscoverPage()),
                );
              } else {
                _showError("Login failed: Unknown error.");
              }
            } catch (e) {
              _showError("Error: ${e.toString()}");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 224, 52, 40),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Password checklist
        _PasswordChecklist(
          hasUppercase: hasUppercase,
          hasLowercase: hasLowercase,
          hasNumber: hasNumber,
          hasSpecialChar: hasSpecialChar,
          hasMinLength: hasMinLength,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            hintText: "Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            if (_isFormValid()) {
              try {
                final response = await _supabaseClient.auth.signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                if (response.user != null) {
                  // Kirim notifikasi snackbar untuk meminta konfirmasi email
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Confirm your signup in email'),
                      duration: Duration(seconds: 5),
                    ),
                  );

                  // Informasikan pengguna untuk memeriksa email mereka
                  _showError("Please check your email for a confirmation link.");

                  // Jika pendaftaran berhasil, Anda bisa mengarahkan pengguna kembali ke halaman login atau tetap di halaman ini.
                  // Jangan langsung ke halaman utama sebelum email dikonfirmasi.
                  // Misalnya, menunggu pengguna mengonfirmasi melalui email dan kembali ke halaman login atau dashboard.
                  
                } else {
                  _showError("Sign up failed: Unknown error.");
                }
              } catch (e) {
                _showError("Error: ${e.toString()}");
              }
            } else {
              _showError("Please fill out all fields correctly.");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 224, 52, 40),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
              ],
            );
          }

  bool _isFormValid() {
    if (emailController.text.isEmpty ||
        password.isEmpty ||
        nameController.text.isEmpty ||
        !hasUppercase ||
        !hasLowercase ||
        !hasNumber ||
        !hasSpecialChar ||
        !hasMinLength) {
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

extension on AuthResponse {
}

// Tab Switch for SignIn/SignUp
class _TabSwitch extends StatelessWidget {
  final bool isSignIn;
  final ValueChanged<bool> onSwitch;

  const _TabSwitch({
    required this.isSignIn,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onSwitch(true),
          child: Column(
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSignIn ? Colors.black : Colors.grey,
                ),
              ),
              if (isSignIn)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 2,
                  width: 60,
                  color: Colors.red,
                ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () => onSwitch(false),
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: !isSignIn ? Colors.black : Colors.grey,
                ),
              ),
              if (!isSignIn)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 2,
                  width: 60,
                  color: Colors.red,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// Password Checklist for validation
class _PasswordChecklist extends StatelessWidget {
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool hasMinLength;

  const _PasswordChecklist({
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChecklistItem("1 uppercase", hasUppercase),
        _buildChecklistItem("1 lowercase", hasLowercase),
        _buildChecklistItem("1 number", hasNumber),
        _buildChecklistItem("1 special character", hasSpecialChar),
        _buildChecklistItem("8 minimum characters", hasMinLength),
      ],
    );
  }

  Widget _buildChecklistItem(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
