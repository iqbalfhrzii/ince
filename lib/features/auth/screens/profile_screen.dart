import 'package:flutter/material.dart';
import '../../../app/widgets/custom_app_bar.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  const ProfileScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final String username = email.split('@')[0];
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profil Saya'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.deepOrange, child: Icon(Icons.person, size: 50, color: Colors.white))),
            const SizedBox(height: 16),
            Center(child: Text(username, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            Center(child: Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey))),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}