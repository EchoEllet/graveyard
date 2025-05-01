import 'package:flutter/foundation.dart' show immutable;

@immutable
sealed class GeoLocationException implements Exception {
  const GeoLocationException({required this.message});
  final String message;

  @override
  String toString() => message.toString();
}

class UnknownGeoLocationException extends GeoLocationException {
  const UnknownGeoLocationException({required super.message});
}
