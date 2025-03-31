import 'package:get/get.dart';
import 'package:goldyu/common/models/sale.dart';
import 'package:goldyu/common/models/saleItem.dart';
import 'package:goldyu/data/providers/api_service.dart';

class SaleController extends GetxController {
  var sales = <Sale>[].obs;
  var isLoading = false.obs;

  Future<void> fetchSales() async {
    try {
      isLoading(true);
      final response = await THttpClient.get('/sales');
      if (response != null) {
        sales.value = (response.body as List).map((json) => Sale.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching sales: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addSale(List<SaleItem> saleItems) async {
    try {
      isLoading(true);
      final response = await THttpClient.post('/sales', data: {
        'sale_items': saleItems.map((item) => item.toJson()).toList(),
      });
      if (response != null) {
        sales.insert(0, Sale.fromJson(response as Map<String, dynamic>));
      }
    } catch (e) {
      print("Error adding sale: $e");
    } finally {
      isLoading(false);
    }
  }
}
