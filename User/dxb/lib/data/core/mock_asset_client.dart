import 'dart:convert';

import 'package:flutter/services.dart';

import '../../core/error/app_exception.dart';

/// Loads mock JSON from assets (simulates API client until backend exists).
class MockAssetClient {
  MockAssetClient();

  final Map<String, dynamic> _memoryCache = {};

  Future<Map<String, dynamic>> getJson(String assetPath) async {
    try {
      if (_memoryCache.containsKey(assetPath)) {
        return Map<String, dynamic>.from(
          _memoryCache[assetPath] as Map,
        );
      }
      final raw = await rootBundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw FormatException('Expected JSON object');
      }
      _memoryCache[assetPath] = decoded;
      return Map<String, dynamic>.from(decoded);
    } catch (_) {
      throw NetworkException();
    }
  }

  void clearCache() => _memoryCache.clear();
}
