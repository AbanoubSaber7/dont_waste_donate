import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF4FC3F7); // اللون اللبني الأساسي

    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- الجزء العلوي: العنوان ---
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Text(
                "Find causes that\nmatter to you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),

            // --- الحاوية البيضاء الرئيسية ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFBFBFB), // أبيض هادئ
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 25),
                      _buildSectionHeader("Recent Searches"),
                      _buildRecentChips(),
                      const SizedBox(height: 30),
                      _buildSectionHeader("Suggested for you"),
                      _buildSuggestionList(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت شريط البحث
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 30, 25, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search charities, causes, or locations",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Color(0xFF4FC3F7)),
          suffixIcon: Icon(Icons.tune, color: Colors.grey, size: 20), // أيقونة الفلتر
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
      ),
    );
  }

  // ويدجت البحث الأخير (Chips)
  Widget _buildRecentChips() {
    List<String> recent = ["Education", "Food Bank", "Children", "Environment"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        children: recent.map((item) {
          return Chip(
            label: Text(item, style: const TextStyle(color: Color(0xFF2D3142))),
            backgroundColor: const Color(0xFFE3F2FD),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          );
        }).toList(),
      ),
    );
  }

  // قائمة النتائج المقترحة
  Widget _buildSuggestionList() {
    return ListView.builder(
      shrinkWrap: true, // مهم جداً داخل SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 50, width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF4FC3F7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.location_on_outlined, color: Color(0xFF4FC3F7)),
            ),
            title: Text("Nearby Cause ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Cairo, Egypt • 3km away"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ),
        );
      },
    );
  }
}