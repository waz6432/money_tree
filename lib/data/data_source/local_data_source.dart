// ignore_for_file: constant_identifier_names

import 'package:financial_ledger/data/network/error_handler.dart';
import 'package:financial_ledger/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_REPORT_KEY = "CACHE_REPORT_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 min

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache({required HomeResponse homeResponse});

  Future<ReportResponse> getReport();
  Future<void> saveReportToCache({required ReportResponse reportResponse});

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache({required HomeResponse homeResponse}) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(data: homeResponse);
  }

  @override
  Future<ReportResponse> getReport() {
    CachedItem? cachedItem = cacheMap[CACHE_REPORT_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveReportToCache({required ReportResponse reportResponse}) async {
    cacheMap[CACHE_REPORT_KEY] = CachedItem(data: reportResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem({this.data});
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeinMills = DateTime.now().millisecondsSinceEpoch; // time now is 1

    bool isCacheValid = currentTimeinMills - expirationTime < cacheTime;

    return isCacheValid;
  }
}
