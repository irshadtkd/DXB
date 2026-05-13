import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class OrdersRepository {
  OrdersRepository(this._loader);

  final AssetJsonLoader _loader;

  Future<List<dynamic>> fetchOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 240));
    final raw = await _loader.load(AppAssets.mockOrders) as Map<String, dynamic>;
    return raw['orders'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> fetchOrderDetail(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final raw = await _loader.load(AppAssets.mockOrderDetail) as Map<String, dynamic>;
    return Map<String, dynamic>.from(raw)..['id'] = id;
  }

  Future<List<dynamic>> fetchRiders() async {
    final raw = await _loader.load(AppAssets.mockRiders) as Map<String, dynamic>;
    return raw['riders'] as List<dynamic>;
  }
}
