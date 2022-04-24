import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/property_model.dart';
import 'package:http/http.dart' as http;

class PropertyProvider extends ChangeNotifier {
  List<Property> _propertiesData = [];

  List<Property> get getPropertiesData {
    return [..._propertiesData];
  }

  Future<void> fetchListOfProperties() async {
    if (_propertiesData.isEmpty) {
      try {
        HttpClient httpClient = HttpClient();
        HttpClientRequest request = await httpClient.getUrl(Uri.parse(
            'https://jidetaiwoandco.com/mailsolution/propertylistingauthapi.php'));
        request.headers.set('Content-type', 'application/json');
        HttpClientResponse response = await request.close();
        String reply = await response.transform(utf8.decoder).join();
        var extractedData = json.decode(reply) as List<dynamic>;
        httpClient.close();
        List<Property> loadedProperties = [];
        for (var data in extractedData) {
          loadedProperties.add(Property(
              id: data['id'],
              description: data['propertydescription'],
              officeId: data['ref'],
              location: data['location'],
              branch: data['branch'],
              price: double.parse(data['propertyprice']),
              contract: data['propertycontract'],
              numberOfRooms: data['bedroom'],
              status: data['propertystatus'],
              area: data['propertydimension'],
              numberOfBathrooms: data['bathroom'],
              numberOfViews: 5,
              balcony: true,
              parking: true,
              clientMobile: data['clientmobile']));
        }
        _propertiesData = loadedProperties;
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      return;
    }
  }
}
