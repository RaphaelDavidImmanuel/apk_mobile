import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthService authService = AuthService();

  bool isHidePassword = true;
  bool isHideConfirmPassword = true;

  Future<void> register() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua data harus diisi"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Konfirmasi password tidak sesuai"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await authService.register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Registrasi berhasil"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  Widget inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isConfirmPassword = false,
  }) {
    bool hide = isConfirmPassword ? isHideConfirmPassword : isHidePassword;

    return TextField(
      controller: controller,
      obscureText: isPassword ? hide : false,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  hide ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirmPassword) {
                      isHideConfirmPassword = !isHideConfirmPassword;
                    } else {
                      isHidePassword = !isHidePassword;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/splash_logo.png",
                width: 120,
              ),
              const SizedBox(height: 15),
              const Text(
                "Daftar Akun",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Buat akun untuk mulai memesan tiket wisata",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 35),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      inputField(
                        controller: emailController,
                        label: "Email",
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 20),
                      inputField(
                        controller: passwordController,
                        label: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      inputField(
                        controller: confirmPasswordController,
                        label: "Konfirmasi Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        isConfirmPassword: true,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "DAFTAR",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
