/******************************************************************************
 * File: wikitude_plugin.dart
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2019-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'wikitude_response.dart';
import 'wikitude_sdk_build_information.dart';

class WikitudePlugin {
  static const MethodChannel _channel =
      const MethodChannel('wikitude_plugin');

  static Future<WikitudeResponse> isDeviceSupporting(List<String> features) async {
    final String response = await _channel.invokeMethod('isDeviceSupporting', features);
    Map<String, dynamic> responseMap = jsonDecode(response);
    return new WikitudeResponse(
      success: responseMap["success"],
      message: responseMap["message"]
    );
  }

  static Future<WikitudeResponse> requestARPermissions(List<String> features) async {
    final String response = await _channel.invokeMethod('requestARPermissions', features);
    Map<String, dynamic> responseMap = jsonDecode(response);
    return new WikitudeResponse(
      success: responseMap["success"],
      message: responseMap["message"]
    );
  }

  static Future<void> openAppSettings() async {
    await _channel.invokeMethod('openAppSettings');
  }

  static Future<String> getSDKVersion() async {
    final String response = await _channel.invokeMethod('getSDKVersion');
    return response;
  }

  static Future<WikitudeSDKBuildInformation> getSDKBuildInformation() async {
    final String response = await _channel.invokeMethod('getSDKBuildInformation');
    Map<String, dynamic> responseMap = jsonDecode(response);
    return new WikitudeSDKBuildInformation(
      buildConfiguration: responseMap["buildConfiguration"],
      buildDate: responseMap["buildDate"],
      buildNumber: responseMap["buildNumber"]
    );
  }
}
