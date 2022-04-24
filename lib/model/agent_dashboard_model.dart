import 'package:flutter/material.dart';

class AgentDashboard {
  final int? numberOfPropertieslisting;
  final int? numberOfProspect;
  final int? numberOfPropertiesAvailable;
  final int? numberOfViews;

  AgentDashboard(
      {@required this.numberOfPropertieslisting,
      @required this.numberOfProspect,
      @required this.numberOfPropertiesAvailable,
      @required this.numberOfViews});
}
