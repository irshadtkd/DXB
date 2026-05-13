import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class CustomersRepository {
  CustomersRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<List<dynamic>> fetchCustomers() async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    final raw = await _loader.load(AppAssets.mockCustomers) as Map<String, dynamic>;
    return raw['customers'] as List<dynamic>;
  }

  Future<Map<String, dynamic>?> fetchCustomer(String id) async {
    final list = await fetchCustomers();
    for (final c in list) {
      final m = c as Map<String, dynamic>;
      if (m['id'] == id) return m;
    }
    return null;
  }
}
