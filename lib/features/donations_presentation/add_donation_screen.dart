import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// --- Providers لإدارة حالة الواجهة ---

// لتخزين ملف الصورة الملتقطة
final donationImageProvider = StateProvider<File?>((ref) => null);

// لتخزين حالة المنتج التي يتوقعها الـ AI أو يختارها المستخدم
final itemConditionProvider = StateProvider<String>((ref) => "Good");

// لإظهار مؤشر التحليل (محاكاة لمعالجة الصور بالـ AI)
final isAnalyzingProvider = StateProvider<bool>((ref) => false);

class AddDonationScreen extends ConsumerWidget {
  const AddDonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color customOrange = Color(0xFFFF5722);
    final donationImage = ref.watch(donationImageProvider);
    final isAnalyzing = ref.watch(isAnalyzingProvider);

    return Scaffold(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOrgProfile(),
                        const SizedBox(height: 25),
                        _buildImpactStats(),
                        const SizedBox(height: 30),

                        // 1. قسم التقاط الصورة والتحليل الذكي
                        _buildPhotoSection(ref, donationImage, isAnalyzing),

                        // 2. قسم نتائج تحليل الـ AI (يظهر فقط بعد التقاط الصورة)
                        if (donationImage != null && !isAnalyzing) ...[
                          const SizedBox(height: 25),
                          _buildConditionSection(ref),
                        ],

                        const SizedBox(height: 30),
                        _buildDescription(),
                        const SizedBox(height: 40),

                        // 3. زر الانتقال للخطوة التالية
                        _buildGiveButton(context, customOrange, donationImage, isAnalyzing),
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

  // --- المكونات الفرعية (Widgets) ---

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
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1593113598332-cd288d649433?q=80&w=200'),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            "جمعية رسالة",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
        ),
        const Center(
          child: Text("Cairo, Egypt", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildImpactStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _infoItem("12k", "Donors"),
        _infoItem("Verified", "Status"),
      ],
    );
  }

  Widget _infoItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildPhotoSection(WidgetRef ref, File? image, bool isAnalyzing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Item Photo",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: isAnalyzing ? null : () => _pickImage(ref),
          child: Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[200]!, width: 2),
            ),
            child: isAnalyzing
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.blue),
                  SizedBox(height: 10),
                  Text("AI is analyzing item condition...", style: TextStyle(color: Colors.blue, fontSize: 12)),
                ],
              ),
            )
                : (image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image.file(image, fit: BoxFit.cover),
            )
                : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_enhance_outlined, size: 45, color: Colors.blue),
                SizedBox(height: 10),
                Text("Capture item for AI analysis", style: TextStyle(color: Colors.grey)),
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget _buildConditionSection(WidgetRef ref) {
    final currentCondition = ref.watch(itemConditionProvider);
    final conditions = ["New", "Good", "Fair"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.blue, size: 20),
            SizedBox(width: 8),
            Text(
              "AI Suggested Condition",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: conditions.map((condition) {
            bool isSelected = currentCondition == condition;
            return GestureDetector(
              onTap: () => ref.read(itemConditionProvider.notifier).state = condition,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF5722) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  condition,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _pickImage(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      ref.read(isAnalyzingProvider.notifier).state = true;

      // محاكاة معالجة الـ AI للصور كما هو مذكور في البحث
      await Future.delayed(const Duration(seconds: 2));

      ref.read(donationImageProvider.notifier).state = File(pickedFile.path);
      ref.read(isAnalyzingProvider.notifier).state = false;

      // تعيين قيمة افتراضية ناتجة عن "التحليل"
      ref.read(itemConditionProvider.notifier).state = "Good";
    }
  }

  Widget _buildDescription() {
    return const Text(
      "Our AI system ensures that your donation is categorized correctly to reach those in need faster.",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.4),
    );
  }

  Widget _buildGiveButton(BuildContext context, Color color, File? image, bool isAnalyzing) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        // الزرار يكون معطل أثناء التحليل أو إذا لم يتم اختيار صورة
        onPressed: (image == null || isAnalyzing)
            ? null
            : () => context.push('/donation-details/Clothes'),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 0,
        ),
        child: const Text(
          "CONTINUE",
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}