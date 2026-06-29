import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService authService = AuthService();

  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    String? data = await authService.getEmail();

    setState(() {
      email = data ?? "user@email.com";
    });
  }

  void logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text(
          "Apakah Anda yakin ingin keluar?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Widget menuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget infoCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 55,
              backgroundImage: const AssetImage("assets/images/avatar.png"),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 15),
            const Text(
              "Pengguna WisataGo",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 25),
            infoCard(
              Icons.email,
              "Email",
              email,
            ),
            const SizedBox(height: 10),
            infoCard(
              Icons.phone_android,
              "Versi Aplikasi",
              "1.0.0",
            ),
            const SizedBox(height: 30),
            menuItem(
              Icons.person,
              "Edit Profil",
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Fitur akan hadir pada versi berikutnya.",
                    ),
                  ),
                );
              },
            ),

            // menuItem(
            //   Icons.confirmation_num,
            //   "Riwayat Pesanan",
            //   () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text(
            //           "Silakan buka tab Pesanan di bawah.",
            //         ),
            //       ),
            //     );
            //   },
            // ),

            menuItem(
              Icons.info,
              "Tentang Aplikasi",
              () {
                showAboutDialog(
                  context: context,
                  applicationName: "WisataGo",
                  applicationVersion: "1.0.0",
                  applicationLegalese:
                      "Aplikasi Pemesanan Tiket Wisata\nFlutter Project",
                );
              },
            ),
            menuItem(
              Icons.logout,
              "Logout",
              logout,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
