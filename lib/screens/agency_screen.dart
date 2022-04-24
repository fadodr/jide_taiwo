import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/screens/exploreproperty_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/bottom_navigation_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/main_menu_one_drawer.dart';

class AgencyScreen extends StatelessWidget {
  static const routename = '/agencyscreen';
  const AgencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _services = [
      {
        'image': 'assets/images/lettingservices.png',
        'text': 'LETTING SERVICES'
      },
      {
        'image': 'assets/images/sellingproperties.png',
        'text': 'SELLING/BUYING PROPERTIES'
      },
      {
        'image': 'assets/images/shortletservices.png',
        'text': 'SHORTLET SERVICES'
      }
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => AppBarTwoWidget('Agency', () {
            Scaffold.of(context).openDrawer();
          }),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const MenuMenuOneDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: SingleChildScrollView(
            child: Column(
                children: List.generate(
              _services.length + 2,
              (index) => index == 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'No matter the dynamics, when it comes to letting, buying or selling of properties of any kind, we are a trusted ally. We are experienced well enough to transact or advice across all residential, commercial, industrial and agricultural markets. Our experts are available and ready to meet your needs. We are always poised to offer you the benefits of our strong market knowledge. Our in-house experts will guide you all the way through transaction conceptualization to completion.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14, height: 1.5),
                      ),
                    )
                  : index == _services.length + 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButtonWidget(
                              width: double.maxFinite,
                              height: 51,
                              buttonText: 'Search for available properties',
                              borderRadius: 8,
                              ontap: () {
                                Navigator.of(context)
                                    .pushNamed(ExplorePropertyScreen.routename);
                              },
                              textColor: Colors.white,
                              bgColor: Theme.of(context).primaryColor),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Stack(
                            children: [
                              Image(
                                  image:
                                      AssetImage(_services[index - 1]['image'])),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                width: double.infinity,
                                height: 66,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        hextocolor('#000000').withOpacity(0.3)),
                                child: Text(
                                  _services[index - 1]['text'],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
            )),
          ),
      ),
      // bottomNavigationBar: const BottomNavigationWidget()
    );
  }
}
