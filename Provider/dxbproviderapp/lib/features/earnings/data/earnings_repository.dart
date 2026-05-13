import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class EarningsRepository {
  EarningsRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<Map<String, dynamic>> fetchEarnings() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return (await _loader.load(AppAssets.mockEarnings)) as Map<String, dynamic>;
  }

  Future<List<dynamic>> fetchPayouts() async {
    final raw = await _loader.load(AppAssets.mockPayouts) as Map<String, dynamic>;
    return raw['payouts'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> fetchBank() async {
    return (await _loader.load(AppAssets.mockBankDetails)) as Map<String, dynamic>;
  }
}
