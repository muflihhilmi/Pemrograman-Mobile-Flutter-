import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/profile_page.dart';

class OutletLocationPage extends StatelessWidget {
  const OutletLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Outlet Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade200, Colors.grey.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Outlet',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tab Filters (All, BiteBox)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'All',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('BiteBox'),
                    onSelected: (bool selected) {},
                    selected: false,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Outlets List
              Expanded(
                child: ListView(
                  children: const [
                    // Jakarta Barat Section
                    AreaSection(
                      areaName: 'Jakarta Barat',
                      outlets: [
                        OutletCard(
                          name: 'BiteBox Grogol',
                          address:
                              'Jl. Grogol Petamburan, No 07, Kec. Administrasi Jakarta Barat',
                          distance: '4.7 km',
                        ),
                        OutletCard(
                          name: 'BiteBox Tj. Duren',
                          address:
                              'Jl. Tanjung Duren Raya, No 74, Kec. Grogol Petamburan',
                          distance: '0.0 km',
                        ),
                      ],
                    ),

                    // Jakarta Utara Section
                    AreaSection(
                      areaName: 'Jakarta Utara',
                      outlets: [
                        OutletCard(
                          name: 'BiteBox Sedayu Kelapa Gading',
                          address:
                              'Ruko Sedayu City SCBD 01 & SCBD 02, Jln. Sedayu Boulevard Timur, Sedayu City',
                          distance: '20.4 km',
                        ),
                        OutletCard(
                          name: 'BiteBox Pula Gebang Raya',
                          address:
                              'Jl. Keramat Jaya NO. BD, Tugu Utara, Koja, Jakarta Utara',
                          distance: '24.7 km',
                        ),
                      ],
                    ),

                    // Jakarta Selatan Section
                    AreaSection(
                      areaName: 'Jakarta Selatan',
                      outlets: [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AreaSection extends StatefulWidget {
  final String areaName;
  final List<OutletCard> outlets;

  const AreaSection({super.key, required this.areaName, required this.outlets});

  @override
  // ignore: library_private_types_in_public_api
  _AreaSectionState createState() => _AreaSectionState();
}

class _AreaSectionState extends State<AreaSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.areaName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_right,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Column(
              children: widget.outlets,
            ),
        ],
      ),
    );
  }
}

class OutletCard extends StatelessWidget {
  final String name;
  final String address;
  final String distance;

  const OutletCard({
    super.key,
    required this.name,
    required this.address,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png',
                width: 50,
                height: 50,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(distance),
            ),
          ],
        ),
      ),
    );
  }
}
