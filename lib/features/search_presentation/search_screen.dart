import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // تأكد من إضافة المكتبة
import '../../../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late GoogleMapController mapController;

  // موقع افتراضي (مثلاً القاهرة)
  static const LatLng _initialPosition = LatLng(30.0444, 31.2357);

  //Markers لأماكن الجمعيات (ممكن تربطها بـ API لاحقاً)
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('org1'),
      position: LatLng(30.0585, 31.3415),
      infoWindow: InfoWindow(title: 'جمعية رسالة', snippet: 'مدينة نصر'),
    ),
    const Marker(
      markerId: MarkerId('org2'),
      position: LatLng(30.0100, 31.4285),
      infoWindow: InfoWindow(title: 'بنك الطعام', snippet: 'التجمع الخامس'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF4FC3F7);

    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- الجزء العلوي: العنوان ---
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                "Find causes that\nmatter to you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
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
                  color: Color(0xFFFBFBFB),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    _buildSearchBar(),

                    // --- إضافة الخريطة هنا ---
                    Container(
                      height: 200, // طول الخريطة
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: GoogleMap(
                          onMapCreated: (controller) => mapController = controller,
                          initialCameraPosition: const CameraPosition(
                            target: _initialPosition,
                            zoom: 11,
                          ),
                          markers: _markers,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false, // إخفاء أزرار الزوم لشكل أنظف
                        ),
                      ),
                    ),

                    // باقي العناصر داخل ScrollView
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            _buildSectionHeader("Recent Searches"),
                            _buildRecentChips(),
                            const SizedBox(height: 25),
                            _buildSectionHeader("Suggested for you"),
                            _buildSuggestionList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 25, 25, 10),
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
          hintText: "Search charities or locations",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Color(0xFF4FC3F7)),
          suffixIcon: Icon(Icons.tune, color: Colors.grey, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
      ),
    );
  }

  Widget _buildRecentChips() {
    List<String> recent = ["Education", "Food Bank", "Children"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        children: recent.map((item) {
          return Chip(
            label: Text(item, style: const TextStyle(color: Color(0xFF2D3142), fontSize: 12)),
            backgroundColor: const Color(0xFFE3F2FD),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSuggestionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 45, width: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF4FC3F7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.location_on_outlined, color: Color(0xFF4FC3F7)),
            ),
            title: Text("Nearby Cause ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            subtitle: const Text("Cairo • 3km away", style: TextStyle(fontSize: 13)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ),
        );
      },
    );
  }
}