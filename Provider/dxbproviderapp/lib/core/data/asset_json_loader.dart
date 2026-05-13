import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Loads JSON from Flutter assets (mock API).
final class AssetJsonLoader {
  const AssetJsonLoader();

  Future<dynamic> load(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw) as dynamic;
  }
}
