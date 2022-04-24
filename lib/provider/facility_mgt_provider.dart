import 'package:flutter/material.dart';

class Facility {
  final String? text;
  final String? title;
  final String? image;
  Facility({@required this.title, @required this.image, @required this.text});
}

List<Facility> facilities = [
  Facility(
      title: 'Commercial/ Office Space Management',
      image: 'assets/images/commercial_management.png',
      text: 'At Jide Taiwo and Co, our commercial/office space management services deliver enhanced occupier satisfaction, which is a focal point in maintaining full occupancy and tenant retention. We provide integrated business space management services in tandem with our clients unique business goals and strategy. '),
  Facility(
      title: 'Residential Property Management',
      image: 'assets/images/residential_management.png',
      text: 'With 27 business offices spread across Nigeria, our experts combined locational knowledge with global standards to deliver expert opinions to our clients and indeed other stakeholders in project development and management.'),
  Facility(
      title: 'Portfolio Estate Manageement',
      image: 'assets/images/portfolio_management.png',
      text: 'On behalf of our esteemed clients, we constantly seek ways to maximize investment returns of their residential and mixed used portfolios. Using a combination of new technologies, in-depth knowledge of local and national markets,.'),
  Facility(
      title: 'Shopping mall / Retail Center Management',
      image: 'assets/images/shopping_management.png',
      text: 'Shopping Mall/Retail Centre Management is one of our strengths in the area of property management portfolio. We are committed to ensuring that our managed shopping centres provide the best possible customer experience.'),
];
