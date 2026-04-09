import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // أضفنا الـ Riverpod
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';

// نفترض إن عندك Provider بيخزن اسم المستخدم، لو مش عندك ده مثال بسيط:
final userNameProvider = StateProvider<String>((ref) => "User");

class HomeScreen extends ConsumerWidget { // تغيير من StatelessWidget إلى ConsumerWidget
  const HomeScreen({super.key});

  @override
  // أضفنا WidgetRef ref هنا
  Widget build(BuildContext context, WidgetRef ref) {
    // هنا بنقرأ الاسم من الـ Provider
    final userName = ref.watch(userNameProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.givelifyPink, Color(0xFFD81B60)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildAppBar(userName), // نمرر الاسم للـ AppBar
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildSectionHeader(context, "Quick Categories"),
                        _buildCategories(context),
                        const SizedBox(height: 30),
                        _buildSectionHeader(context, "Featured Organizations"),
                        _buildFeaturedSlider(context),
                        const SizedBox(height: 30),
                        _buildSectionHeader(context, "Nearby You"),
                        _buildNearbyList(context),
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

  // تحديث الـ AppBar ليستقبل الاسم ديناميكياً
  Widget _buildAppBar(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // هنا بنستخدم الاسم المتغير
                  Text("Hello, $name 👋", style: const TextStyle(color: Colors.white70, fontSize: 16)),
                  const Text("Discover Causes", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                ],
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white24,
                child: IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _searchBar(),
        ],
      ),
    );
  }

  // ... باقي الـ Widgets (Search بصيغتها القديمة) ...
  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search organizations...",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: AppTheme.givelifyPink),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
          TextButton(
              onPressed: () => context.push('/search'),
              child: const Text("View all", style: TextStyle(color: AppTheme.givelifyPink))
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    List<Map<String, dynamic>> cats = [
      {"name": "Food", "icon": Icons.fastfood, "color": Colors.orange},
      {"name": "Health", "icon": Icons.favorite, "color": Colors.red},
      {"name": "Education", "icon": Icons.school, "color": Colors.blue},
      {"name": "Orphans", "icon": Icons.child_care, "color": Colors.purple},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: cats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => context.push('/select-category/${cats[index]['name']}'),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: cats[index]['color'].withOpacity(0.1),
                    child: Icon(cats[index]['icon'], color: cats[index]['color']),
                  ),
                  const SizedBox(height: 8),
                  Text(cats[index]['name'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSlider(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.push('/add-donation'),
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=400'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent]),
                ),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Help Children in Need", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Magdi Yacoub Foundation", style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNearbyList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildOrgCard(context, "جمعية رسالة", "مدينة نصر - 2 كم", Icons.volunteer_activism),
          _buildOrgCard(context, "بنك الطعام المصري", "التجمع الخامس - 5 كم", Icons.flatware),
        ],
      ),
    );
  }

  Widget _buildOrgCard(BuildContext context, String title, String sub, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: ListTile(
        onTap: () => context.push('/add-donation'),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppTheme.givelifyPink.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
          child: Icon(icon, color: AppTheme.givelifyPink),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }
}