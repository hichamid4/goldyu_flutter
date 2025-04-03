import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/helpers/secure_storage_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SaleCard extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final double totalWeight;
  final String saleDate;
  final String saleTime;

  const SaleCard({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.totalWeight,
    required this.saleDate,
    required this.saleTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Stack(
        children: [
          // White Background (Placed First so it's Below)
          Container(
            height: 100, // Match height
            decoration: BoxDecoration(
              color: Colors.white, // Right side color
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),

          // Blue Clipped Section (Placed Last so it Appears on Top)
          ClipPath(
            clipper: DiagonalClipper(),
            child: Container(
              height: 100, // Adjust height as needed
              decoration: BoxDecoration(
                color: TColors.primaryColor, // Left side color
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),

          // Content Layer (On Top of Both Backgrounds)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Side (Price & Weight)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${NumberFormat('#,###', 'fr_FR').format(totalPrice)} DH',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$totalWeight g',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                // Right Side (Date, Time & User)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      saleDate,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Text(
                      saleTime,
                      style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 107, 105, 105)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userName,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // Action Button
                IconButton(
                  icon: Icon(
                    Iconsax.info_circle5,
                    color: TColors.primaryColor,
                    size: 35,
                  ),
                  onPressed: () async {
                    String? token = await SecureStorageHelper.getToken();
                    print(token);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Sharp Division at 80-degree Angle
class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0); // Top-left corner
    path.lineTo(size.width * 0.3, 0); // 30% width
    path.lineTo(size.width * 0.7, size.height); // 80-degree diagonal split
    path.lineTo(0, size.height); // Bottom-left corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
