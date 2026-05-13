import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class SettingsRepository {
  SettingsRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<Map<String, dynamic>> businessProfile() async {
    return (await _loader.load(AppAssets.mockBusinessProfile)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> serviceAreas() async {
    return (await _loader.load(AppAssets.mockServiceAreas)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> operatingHours() async {
    return (await _loader.load(AppAssets.mockOperatingHours)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> teamRoles() async {
    return (await _loader.load(AppAssets.mockTeamRoles)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> notificationPrefs() async {
    return (await _loader.load(AppAssets.mockNotificationPrefs)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> helpTopics() async {
    return (await _loader.load(AppAssets.mockHelpTopics)) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> webTools() async {
    return (await _loader.load(AppAssets.mockWebTools)) as Map<String, dynamic>;
  }
}
