import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import '../hextocolor.dart';


class TermsScreen extends StatelessWidget {
  static const routename = '/termsandconditionscreen';
  const TermsScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          child: AppBarWidget('Terms And Conditions'),
          preferredSize: Size.fromHeight(kToolbarHeight)),
      body: SingleChildScrollView(
      child: Column(
    children: [
      Container(
        //height: 2000,
        decoration: BoxDecoration(
            image: const DecorationImage(
              alignment: Alignment.center,
                image: AssetImage('assets/images/watermarkimage2.png',)),
            color: hextocolor('#FBF9FF')),
        padding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'DISCLAIMER',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,fontWeight: FontWeight.bold
                  ),

                ),

            ),
            const SizedBox(
              height: 10,
            ),
            Text('The information contained in this website is for general information purposes only.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!,),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10),
              child:  Text(
                  ''' 1. In no event will we be liable for any loss or damage including without limitation, indirect or consequential loss or damage, or any loss or damage whatsoever arising from loss of data or profits arising out of, or in connection with, the use of this website. Through this website you are able to link to other websites which are not under the control of Jide Taiwo & Co.
               
      We have no control over the nature, content and availability of those sites. The inclusion of any links does not necessarily imply a recommendation or endorse the views expressed within them.
      
      Every effort is made to keep the website up and running smoothly. However, Jide Taiwo & Co takes no responsibility for, and will not be liable for, the website being temporarily unavailable due to technical issues beyond our control.
      
   2. By visiting our site and/ or purchasing something from us, you engage in our “Service” and agree to be bound by the following terms and conditions (“Terms of Service”, “Terms”),including those additional terms and conditions and policies referenced herein and/or available by hyperlink. 
    
    These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.'''),
            ),
            const SizedBox(
              height:20
            ),
            Text('''Please read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.

Any new features or tools which are added to the current site shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.'''),
            const SizedBox(
                height:20
            ),
            Text(
              'TERMS AND CONDITIONS FOR EXTERNAL AGENTS ENGAGEMENT',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
                height:20
            ),
            Text('Jide Taiwo & Co. shall promote, market, manage and or sell the properties (buildings/lands) posted on the website of Jide Taiwo & Co. subject to the following terms and condition:'),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child:  Text(
                  ''' 1. Upon application, verification, certification and registration of accredited agents of the properties to be posted by external estate agents, landlords/owners and or properties/estates developers.
      
 2. Upon registration and certification of the properties and owners/landlords, agents and estates developers, Jide Taiwo & Co. reserves the exclusive and sole rights to promote, market, manage and or sell the properties posted on its website to any clients who show interest and conclude the transactions on behalf of the external agents, landlords/owners and Estate/Properties Developers upon instruction from the agent, landlords/owners and Estate/Properties Developers. 
    
 3.The parties in this collaboration agreement shall share the fees and commission on any concluded transactions as shall be agreed between them
   
 4.Parties Relationship:
Nothing in this collaboration/agency agreement shall be construed to create an employer/employee relationship between Jide Taiwo & Co. and the landlords/owners, external agents and properties/ Estate developers.

 5.Under no circumstances shall either party be liable to the other party or any third party for any damage resulting from any part of this agreement such as, but not limited to, loss of revenue or anticipated profits or loss of business, course of delay or failure of delivery which are not related to or the direct result of parties’ negligence or breach.

 6. Severability:
In the event that any provision of this agreement is demand invalid or unenforceable, in whole or in part, that part shall be severed from the remainder of this agreement and all other provisions shall continue in full force and effect as valid and enforceable.

 7. Waiver:
The failure by either party to exercise any right, power or privilege under the term of this agreement will not be construed as a waiver of any subsequent or further exercise of that right, power or privilege.

 8. Governing Law:
The parties agree that this agreement shall be governed by the relevant Laws of the Federal Republic of Nigeria.

'''),
            ),

          ],
        ),

      ),

  ])),
    );
  }
}
