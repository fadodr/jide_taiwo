import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/property_image_model.dart';

class PropertyImageProvider extends ChangeNotifier {
  final Map<String, PropertyImage> _propertyimages = {};

  Map<String, PropertyImage> get getpropertyimages {
    return {..._propertyimages};
  }

  Future<String?> fetchpropertyimages(String id) async {
    String? extractedImage;
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          'https://jidetaiwoandco.com/mailsolution/propertybriefimagesauthapi.php?propertyid=${id}'));
      request.headers.set('Content-type', 'application/json');
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      extractedImage = json.decode(reply)['photo'] as String;
      httpClient.close();
      _propertyimages.putIfAbsent(id, () => PropertyImage(id, extractedImage!));
    } catch (_) {}
    return extractedImage;
  }
}
