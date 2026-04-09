import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF7E57C2);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // لون خلفية هادئ
      appBar: AppBar(
        title: Text(
          "$categoryName Causes",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // جزء علوي يعرض عدد النتائج
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Text(
              "Found 12 organizations for $categoryName",
              style: TextStyle(color: Colors.grey[600], fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),

          // قائمة النتائج
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildEnhancedOrgCard(context, index, primaryPurple);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedOrgCard(BuildContext context, int index, Color themeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // الانتقال لصفحة تفاصيل المؤسسة
        },
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // صورة المؤسسة مع شكل دائري مميز
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=200'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),

              // بيانات المؤسسة
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$categoryName Charity ${index + 1}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.verified, color: Colors.blue, size: 16),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Helping families in Cairo since 2010",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange[400], size: 14),
                        const SizedBox(width: 4),
                        const Text("4.9", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Icon(Icons.location_on, color: themeColor.withOpacity(0.6), size: 14),
                        const SizedBox(width: 4),
                        const Text("2.5 km", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),

              // سهم الانتقال
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}