import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

class ReviewsRepository {
  ReviewsRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<List<dynamic>> fetchReviews() async {
    final raw = await _loader.load(AppAssets.mockReviews) as Map<String, dynamic>;
    return raw['reviews'] as List<dynamic>;
  }

  Future<Map<String, dynamic>?> fetchReview(String id) async {
    final list = await fetchReviews();
    for (final r in list) {
      final m = r as Map<String, dynamic>;
      if (m['id'] == id) return m;
    }
    return null;
  }
}
