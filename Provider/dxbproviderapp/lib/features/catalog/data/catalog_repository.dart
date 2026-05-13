import '../../../core/constants/app_assets.dart';
import '../../../core/data/asset_json_loader.dart';

enum CatalogVertical {
  hub,
  food,
  availability,
  laundry,
  cars,
  hotels,
  marketplace,
  homeServices;

  String get asset {
    switch (this) {
      case CatalogVertical.hub:
        return AppAssets.mockCatalogHub;
      case CatalogVertical.food:
        return AppAssets.mockCatalogFood;
      case CatalogVertical.availability:
        return AppAssets.mockFoodAvailability;
      case CatalogVertical.laundry:
        return AppAssets.mockCatalogLaundry;
      case CatalogVertical.cars:
        return AppAssets.mockCatalogCars;
      case CatalogVertical.hotels:
        return AppAssets.mockCatalogHotels;
      case CatalogVertical.marketplace:
        return AppAssets.mockCatalogMarketplace;
      case CatalogVertical.homeServices:
        return AppAssets.mockCatalogHomeServices;
    }
  }
}

class CatalogRepository {
  CatalogRepository(this._loader);
  final AssetJsonLoader _loader;

  Future<Map<String, dynamic>> loadVertical(CatalogVertical v) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final raw = await _loader.load(v.asset);
    return raw as Map<String, dynamic>;
  }
}
