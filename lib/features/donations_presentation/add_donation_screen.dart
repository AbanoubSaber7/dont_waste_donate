import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';

class AddDonationScreen extends StatelessWidget {
  const AddDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customOrange = Color(0xFFFF5722); // لون زر الـ GIVE

    return Scaffold(
      // استخدام تدرج لوني خفيف في الخلفية الزرقاء
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // الـ AppBar المخصص
              _buildSimpleAppBar(context),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Do more\ngood.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // الحاوية البيضاء الرئيسية
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildOrgProfile(),
                        const SizedBox(height: 30),
                        _buildImpactStats(),
                        const SizedBox(height: 40),
                        _buildDescription(),
                        const SizedBox(height: 50),
                        _buildGiveButton(context, customOrange),
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

  Widget _buildSimpleAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrgProfile() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1593113598332-cd288d649433?q=80&w=200'),
              ),
            ),
            const CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(Icons.check, color: Colors.white, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          "جمعية رسالة",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
        ),
        const SizedBox(height: 5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.grey, size: 16),
            SizedBox(width: 5),
            Text("مدينة نصر، القاهرة", style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildImpactStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _infoItem("12k", "Donors"),
        Container(width: 1, height: 30, color: Colors.grey[200]),
        _infoItem("4.8", "Rating"),
        Container(width: 1, height: 30, color: Colors.grey[200]),
        _infoItem("Verified", "Status"),
      ],
    );
  }

  Widget _infoItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF7E57C2))),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      "Your donation helps provide food, shelter, and education to those in need. Every small contribution makes a big difference in someone's life.",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 15, height: 1.5),
    );
  }

  Widget _buildGiveButton(BuildContext context, Color color) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.push('/amount-picker'),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        child: const Text(
          "GIVE",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
    );
  }
}