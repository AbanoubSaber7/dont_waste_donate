import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Provider بسيط لتخزين اسم المستخدم (يمكنك تحديثه عند التسجيل)
final userNameProvider = StateProvider<String?>((ref) => null);

class ProfileScreen extends ConsumerWidget { // حولناها لـ ConsumerWidget
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userNameProvider);

    return Scaffold(
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
              // الهيدر يتغير بناءً على وجود اسم المستخدم
              userName == null ? _buildAuthPrompt(context) : _buildUserInfo(context, userName),

              const SizedBox(height: 20),
              _buildImpactCard(),
              const SizedBox(height: 25),

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
                        _buildSectionTitle("My Impact"),
                        _buildProfileItem(Icons.workspace_premium, "My Badges & Rewards", () {}),
                        _buildProfileItem(Icons.history, "Donation History", () => context.push('/history')),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(thickness: 0.8, color: Color(0xFFEEEEEE)),
                        ),

                        _buildSectionTitle("Personal Settings"),
                        _buildProfileItem(Icons.person_outline, "Account Information", () {}),

                        _buildSectionTitle("App Settings"),
                        _buildProfileItem(Icons.security, "Privacy & Security", () {}),

                        const SizedBox(height: 20),
                        // زر تسجيل الخروج يظهر فقط لو فيه مستخدم مسجل
                        if (userName != null)
                          _buildProfileItem(Icons.logout, "Sign Out", () {
                            ref.read(userNameProvider.notifier).state = null;
                          }, isLogout: true),
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

  // الجزء الخاص بالمستخدم المسجل
  Widget _buildUserInfo(BuildContext context, String name) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 4),
          ),
          child: const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white24,
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          "Top Supporter since 2025",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
        ),
      ],
    );
  }

  // الجزء الخاص بسؤال المستخدم تسجيل الدخول (لو الاسم null)
  Widget _buildAuthPrompt(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.account_circle, size: 80, color: Colors.white24),
        const SizedBox(height: 15),
        const Text(
          "Join Our Mission",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7E57C2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/register'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImpactCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("12", "Donations"),
          Container(width: 1, height: 30, color: Colors.white24),
          _statItem("45", "Lives Helped"),
          Container(width: 1, height: 30, color: Colors.white24),
          _statItem("Gold", "Badge"),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 15, top: 10),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey[800], fontSize: 17, fontWeight: FontWeight.bold),
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
          style: TextStyle(fontWeight: FontWeight.w500, color: isLogout ? Colors.red : Colors.black87),
        ),
        trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      ),
    );
  }
}