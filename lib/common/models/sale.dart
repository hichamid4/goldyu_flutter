import 'package:goldyu/common/models/saleItem.dart';

class Sale {
  int id;
  int userId;
  double totalWeight;
  double totalPrice;
  List<SaleItem> saleItems;

  Sale({
    required this.id,
    required this.userId,
    required this.totalWeight,
    required this.totalPrice,
    required this.saleItems,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      userId: json['user_id'],
      totalWeight: double.parse(json['total_weight'].toString()),
      totalPrice: double.parse(json['total_price'].toString()),
      saleItems: (json['sale_items'] as List).map((item) => SaleItem.fromJson(item)).toList(),
    );
  }
}
