import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدام تدرج لوني للخلفية لإعطاء طابع عصري
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(context),
              const SizedBox(height: 25),

              // الجزء الأبيض السفلي مع زوايا دائرية أكبر
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildSectionTitle("Personal Settings"),
                        _buildProfileItem(Icons.person_outline, "Account Information", () {}),
                        _buildProfileItem(Icons.history, "Donation History", () => context.push('/history')),
                        _buildProfileItem(Icons.favorite_border, "Favorite Charities", () {}),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(thickness: 0.8, color: Color(0xFFEEEEEE)),
                        ),

                        _buildSectionTitle("App Settings"),
                        _buildProfileItem(Icons.notifications_none, "Notifications", () {}),
                        _buildProfileItem(Icons.security, "Privacy & Security", () {}),
                        _buildProfileItem(Icons.help_outline, "Help & Support", () {}),

                        const SizedBox(height: 20),
                        _buildProfileItem(Icons.logout, "Sign Out", () {}, isLogout: true),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // صورة المستخدم مع تحديد (Border)
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 4),
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white24,
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Join Our Mission",
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        const SizedBox(height: 5),
        Text(
          "Donate easily, help everyone",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(height: 25),

        // كارت أزرار تسجيل الدخول
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7E57C2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: () => context.push('/register'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 15, top: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isLogout ? Colors.red.withOpacity(0.05) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF7E57C2)),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}