import 'package:goldyu/common/models/saleItem.dart';

class Sale {
  int id;
  int userId;
  double totalWeight;
  double totalPrice;
  DateTime? saleDate;
  List<SaleItem> saleItems;

  Sale({
    required this.id,
    required this.userId,
    required this.totalWeight,
    required this.totalPrice,
    required this.saleItems,
    this.saleDate,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      userId: json['user_id'],
      saleDate: json['sale_date'] != null ? DateTime.tryParse(json['sale_date']) : null,
      totalWeight: double.parse(json['total_weight'].toString()),
      totalPrice: double.parse(json['total_price'].toString()),
      saleItems: (json['sale_items'] as List).map((item) => SaleItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total_weight': totalWeight,
      'total_price': totalPrice,
      'sale_date': saleDate?.toIso8601String(),
      'sale_items': saleItems.map((item) => item.toJson()).toList(),
    };
  }
}
