import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class AnalyticsRepository {
  AnalyticsRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<Map<String, dynamic>> overview() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return (await _loader.load(AppAssets.mockAnalyticsOverview)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> vertical() async {
    return (await _loader.load(AppAssets.mockAnalyticsVertical)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> operational() async {
    return (await _loader.load(AppAssets.mockAnalyticsOperational)) as Map<String, dynamic>;
  }
}
