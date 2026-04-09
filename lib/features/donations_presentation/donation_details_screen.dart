import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DonationDetailsScreen extends StatefulWidget {
  final String category; // مثلاً 'Food' أو 'Clothes'
  const DonationDetailsScreen({super.key, required this.category});

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} Details"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tell us more about your donation",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // لو التبرع "أكل" نظهر تاريخ الصلاحية
            if (widget.category == "Food") ...[
              _buildInputField("Food Type (e.g. Canned, Fresh)", Icons.fastfood),
              const SizedBox(height: 20),
              _buildInputField("Expiry Date", Icons.date_range),
            ],

            // لو التبرع "لبس" نظهر المقاس والنوع
            if (widget.category == "Clothes") ...[
              _buildInputField("Size (S, M, L, XL)", Icons.straighten),
              const SizedBox(height: 20),
              _buildInputField("Gender (Men, Women, Kids)", Icons.people),
            ],

            const SizedBox(height: 20),
            _buildInputField("Quantity / Number of items", Icons.format_list_numbered),
            const SizedBox(height: 20),
            _buildInputField("Additional Notes", Icons.note_add, maxLines: 3),

            const SizedBox(height: 40),

            // زرار الإنهاء
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => _showSuccessDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FC3F7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("SUBMIT DONATION", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, IconData icon, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text("Awesome!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Your donation has been submitted successfully.", textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}