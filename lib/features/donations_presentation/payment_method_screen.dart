import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color successGreen = Color(0xFF2E7D32); // اللون الأخضر الأساسي

    return Scaffold(
      backgroundColor: successGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Stack(
        children: [
          // العنوان العلوي
          const Positioned(
            top: 10, left: 20, right: 20,
            child: Text(
              "How would you\nlike to pay?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),

          // الحاوية البيضاء الرئيسية
          Positioned.fill(
            top: 130,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(25, 40, 25, 20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildPaymentCard(Icons.credit_card, "Visa ending in 1234", Colors.blue[800]!, true),
                        _buildPaymentCard(Icons.account_balance_wallet, "MasterCard ending in 5678", Colors.red[700]!, false),
                        _buildAddMethod(context),

                        const SizedBox(height: 30),
                        _buildDonationSummary(),
                      ],
                    ),
                  ),

                  // زر FINISH النهائي
                  _buildFinishButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(IconData icon, String title, Color iconColor, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? iconColor : Colors.grey[200]!,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Icon(
          isSelected ? Icons.check_circle : Icons.radio_button_off,
          color: isSelected ? iconColor : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildAddMethod(BuildContext context) {
    return InkWell(
      onTap: () { /* فتح صفحة إضافة كارت جديد */ },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.grey),
            SizedBox(width: 10),
            Text(
              "Add new payment method",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total Donation", style: TextStyle(color: Colors.grey, fontSize: 16)),
          Text("\$50.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF2E7D32))),
        ],
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.givelifyOrange.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // منطق إتمام العملية بنجاح وإظهار Success Dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.givelifyOrange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text(
            "FINISH",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}