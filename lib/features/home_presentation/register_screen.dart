import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF7E57C2))
      ),
      body: SingleChildScrollView( // عشان الكيبورد ميعملش Error
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF7E57C2))
            ),
            const SizedBox(height: 10),
            const Text("Join our community today", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),

            // حقول الإدخال
            _buildTextField("Full Name", Icons.person_outline),
            const SizedBox(height: 20),
            _buildTextField("Email", Icons.mail_outline), // أو Icons.email
            const SizedBox(height: 20),
            _buildTextField("Password", Icons.lock_outline, isPassword: true),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF7E57C2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF7E57C2), width: 2),
        ),
      ),
    );
  }
}