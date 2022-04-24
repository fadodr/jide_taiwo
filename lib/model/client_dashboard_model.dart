import 'package:flutter/material.dart';

class ClientDashboard {
  final String? property;
  final String? type;
  final String? tenancy;
  final String? contract;

  ClientDashboard(
      {@required this.property,
      @required this.type,
      @required this.tenancy,
      @required this.contract});
}
