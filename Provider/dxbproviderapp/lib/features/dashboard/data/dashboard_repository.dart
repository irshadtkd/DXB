import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class DashboardRepository {
  DashboardRepository(this._loader);

  final AssetJsonLoader _loader;

  Future<Map<String, dynamic>> fetchDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 260));
    final raw = await _loader.load(AppAssets.mockDashboard);
    return raw as Map<String, dynamic>;
  }
}
