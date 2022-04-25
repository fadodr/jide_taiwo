import 'package:flutter/material.dart';

class Property {
  final String? id;
  final String? description;
  final String? officeId;
  final String? location;
  final String? branch;
  final double? price;
  final String? type;
  final String? contract;
  final String? numberOfRooms;
  final String? status;
  final String? area;
  final String? numberOfBathrooms;
  final int? numberOfViews;
  final bool? balcony;
  final bool? parking;
  final String? clientMobile;

  Property(
      {@required this.id,
      @required this.description,
      @required this.officeId,
      @required this.location,
      @required this.branch,
      @required this.price,
      @required this.type,
      @required this.contract,
      @required this.numberOfRooms,
      @required this.status,
      @required this.area,
      @required this.numberOfBathrooms,
      @required this.numberOfViews,
      @required this.balcony,
      @required this.parking,
      @required this.clientMobile});
}
