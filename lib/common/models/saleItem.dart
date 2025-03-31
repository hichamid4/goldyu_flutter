class SaleItem {
  int id;
  int saleId;
  int categoryId;
  int modelId;
  int typeId;
  int quantity;
  double price;
  double weight;
  double pricePerGram;

  SaleItem({
    required this.id,
    required this.saleId,
    required this.categoryId,
    required this.modelId,
    required this.typeId,
    required this.quantity,
    required this.price,
    required this.weight,
    required this.pricePerGram,
  });

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      id: json['id'],
      saleId: json['sale_id'],
      categoryId: json['category_id'],
      modelId: json['model_id'],
      typeId: json['type_id'],
      quantity: json['quantity'],
      price: double.parse(json['price'].toString()),
      weight: double.parse(json['weight'].toString()),
      pricePerGram: double.parse(json['price_per_gram'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'model_id': modelId,
      'type_id': typeId,
      'quantity': quantity,
      'price': price,
      'weight': weight,
    };
  }
}
