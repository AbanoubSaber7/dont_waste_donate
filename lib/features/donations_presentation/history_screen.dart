import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryPink = Color(0xFFF77D8A); // اللون البامبي المميز بتاعك

    return Scaffold(
      backgroundColor: primaryPink,
      body: SafeArea(
        bottom: false, // عشان الحاوية البيضاء تنزل لآخر الشاشة
        child: Column(
          children: [
            // --- الجزء العلوي: العنوان والأيقونة ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.history_rounded, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Track all of your gifts\nin one place",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // --- الجزء السفلي: قائمة التبرعات ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9), // أبيض مطفي شوية أريح للعين
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(25, 35, 25, 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 8, // عدد افتراضي للعرض
                    itemBuilder: (context, index) {
                      return _buildHistoryItem(index);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(int index) {
    // بيانات تجريبية للتوضيح
    List<String> orgs = ["Magdi Yacoub", "Resala Association", "Egyptian Food Bank", "57357 Hospital"];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // أيقونة تعبيرية لكل تبرع
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFF77D8A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.volunteer_activism, color: Color(0xFFF77D8A)),
          ),
          const SizedBox(width: 15),

          // تفاصيل التبرع
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orgs[index % orgs.length],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3142)),
                ),
                const SizedBox(height: 4),
                Text(
                  "April ${10 - index}, 2026",
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),

          // المبلغ وحالة التبرع
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "\$50.00",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFFF77D8A)),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Sent",
                  style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}