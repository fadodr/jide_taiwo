import 'package:flutter/material.dart';

class Valuation {
  final String? text;
  final String? title;
  final String? image;
  Valuation({@required this.title, @required this.image, @required this.text});
}

List<Valuation> valuations = [
  Valuation(
      title: 'Asset Valuation',
      image: 'assets/images/valuation.png',
      text: 'We are conversant with the Nigerian and West African real estate '
          'industry. This knowledge enable our valuation experts deploy global best practices in asset valuation services.'),
  Valuation(
    title: 'Development Valuation',
    image: 'assets/images/Development_valuation.png',
    text:  'With 27 business offices spread across Nigeria, our experts combined locational knowledge with global standards to deliver expert opinions to our clients and indeed other stakeholders in project development and management.'),
  Valuation(
    title:  'Commercial & Industrial Valuation',
    image:  'assets/images/commercialValuation.png',
    text:  'We have earned trust as a go-to firm when commercial/Industrial valuation comes to mind in Nigeria. For over four decades, we have provided expert opinions and appraisal on commercial valuation ranging from offices, retail, and industrial concerns to a wide spectrum of clients in private and public sectors.'),
  Valuation(
    title: 'Education sector Valuation',
    image: 'assets/images/educationValuation.png',
    text:  'We leverage on the depth of our valuation specialists to provide expert opinions on appraisal relating to schools at all levels. Our wealth of experience is brought to bear on valuation of educational premises, infrastructures, student accommodation, healthcare, sports and logistics support. '),
  Valuation(
    title: 'Power & Energy Sector Valuation',
    image: 'assets/images/powerValuation.png',
    text:  'We are mindful of the importance of an efficient energy and power sector in the development of a nation. Our power and energy valuation specialists provide timely and professional appraisal and due diligence on energy assets, utilities and machinery for banks, operators, insurance, regulatory and allied players in the energy and power sector. '),
  Valuation(
     title: 'Expert Witness & Dispute Resolution',
     image: 'assets/images/expertResolution.png',
     text: 'At Jide Taiwo & Co., We provide advisory on valuation in aid of conflict resolution as it relates to property disputes. We have been engaged by solicitors and other legal practitioners as expert witness, mediator, and arbitrators on several occasions..'),
  Valuation(
    title: 'Agric & Agro Allied Valuation',
    image: 'assets/images/agricValuation.png',
    text:  'Farm and agro-allied asset valuation can be for diverse purpose. Such appraisal could be for loan security, merger and acquisition, internal transfer, statement of account, dispute resolution or taxation.'),
  Valuation(
    title: 'Hotel & Hospitality Valuation',
    image: 'assets/images/hotelValuation.png',
    text: 'Operating from our various business offices are our team of hotel and hospitality valuation experts. Our specialty covers not just hotels, but serviced apartments, hostels, tourist sites, beaches, and similar assets, so classified for their trading potentials. '),
];
