import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class InboxRepository {
  InboxRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<List<dynamic>> fetchThreads() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final raw = await _loader.load(AppAssets.mockConversations) as Map<String, dynamic>;
    return raw['threads'] as List<dynamic>;
  }

  Future<List<dynamic>> fetchMessages(String threadId) async {
    final raw = await _loader.load(AppAssets.mockConversations) as Map<String, dynamic>;
    final key = 'messages_$threadId';
    return (raw[key] as List<dynamic>?) ?? [];
  }
}
