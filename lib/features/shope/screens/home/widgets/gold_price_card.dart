import 'package:flutter/material.dart';

class GoldPriceCard extends StatelessWidget {
  const GoldPriceCard({
    super.key,
    required this.flag,
    required this.country,
    required this.price,
    required this.currency,
  });

  final String flag;
  final String country;
  final double price;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Set a reasonable width
      height: 150, // Prevent overflow by setting a fixed height
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the column takes only needed space
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 5),
              Text(country, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("\$$price $currency", style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        ),
      ),
    );
  }
}
