import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // 안드로이드 정보
      var build = await deviceInfoPlugin.androidInfo;
      name = "${build.brand} ${build.model}";
      identifier = build.id;
      version = build.version.codename;
    } else {
      // ios 정보
      var build = await deviceInfoPlugin.iosInfo;
      name = "${build.name} ${build.model}";
      identifier = build.identifierForVendor!;
      version = build.systemVersion;
    }
  } on PlatformException {
    return DeviceInfo(name: name, identifier: identifier, version: version);
  }

  return DeviceInfo(name: name, identifier: identifier, version: version);
}

bool isEmailValid(String email) {
  return email.isNotEmpty;
}
