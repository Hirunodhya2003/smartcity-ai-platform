import 'package:flutter/material.dart';

class SmartCityApp extends StatelessWidget {
  const SmartCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart City AI Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart City AI Platform'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_city,
              size: 80,
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Smart City!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manage your city in one place.',
            ),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildModule(Icons.traffic, 'Traffic'),
                _buildModule(Icons.delete_outline, 'Waste'),
                _buildModule(Icons.bolt, 'Energy'),
                _buildModule(Icons.water_drop, 'Water'),
                _buildModule(Icons.air, 'Air Quality'),
                _buildModule(Icons.analytics, 'AI Analytics'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModule(IconData icon, String title) {
    return Card(
      child: SizedBox(
        width: 140,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.teal),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
