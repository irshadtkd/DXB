/// Service categories a provider can register for (one account, many services).
/// Add new ids here and map them to catalog hub `route` keys in [hubRoutesFor].
abstract final class ProviderCategoryIds {
  static const String food = 'food';
  static const String laundry = 'laundry';
  static const String rental = 'rental';
  static const String homeServices = 'home_services';

  static const List<String> all = [food, laundry, rental, homeServices];

  /// Catalog hub JSON `route` values shown for each registered category.
  static Set<String> hubRoutesFor(String categoryId) {
    switch (categoryId) {
      case food:
        return {'food', 'availability'};
      case laundry:
        return {'laundry'};
      case rental:
        return {'cars'};
      case homeServices:
        return {'home_services'};
      default:
        return {};
    }
  }

  static Set<String> allHubRoutesFor(Iterable<String> categoryIds) =>
      categoryIds.expand(hubRoutesFor).toSet();
}
