// extension on String
import 'package:financial_ledger/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}

extension NonNullMap<K, V> on Map<K, V>? {
  Map<K, V> orEmptyMap() {
    if (this == null) {
      return EMPTY_MAP.cast<K, V>();
    } else {
      return this!;
    }
  }
}

extension NonNullList<T> on List<T>? {
  List<T> orEmptyList() {
    if (this == null) {
      return EMPTY_LIST.cast<T>();
    } else {
      return this!;
    }
  }
}
