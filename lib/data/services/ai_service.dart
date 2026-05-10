import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../utils/constants.dart';

class AIService {
  final GenerativeModel _model;

  AIService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: AppConstants.geminiApiKey,
        );

  Future<Map<String, String>> analyzeDonationItem(File image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final content = [
        Content.multi([
          TextPart(
              "Analyze this donation item. Identify the category (Food, Clothes, or Other) and assess its condition (New, Good, Damaged, or Not Safe). Return only a JSON-like format: {\"category\": \"...\", \"condition\": \"...\", \"reason\": \"...\"}"),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(content);
      final text = response.text;

      if (text == null) throw Exception("Empty response from AI");

      // Extract JSON values (simplified parsing)
      final categoryMatch = RegExp(r'"category":\s*"([^"]+)"').firstMatch(text);
      final conditionMatch = RegExp(r'"condition":\s*"([^"]+)"').firstMatch(text);

      return {
        "category": categoryMatch?.group(1) ?? "Other",
        "condition": conditionMatch?.group(1) ?? "Good",
      };
    } catch (e) {
      print("AI Analysis Error: $e");
      return {
        "category": "Other",
        "condition": "Good",
      };
    }
  }
}
