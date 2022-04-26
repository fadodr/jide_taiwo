import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/screens/getintouch_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/bottom_navigation_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import '../widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/provider/valuation_provider.dart';

class ValuationScreen extends StatelessWidget {
  static const routename = '/valauatiobsrceen';
  const ValuationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            child: AppBarWidget('Valuation', null),
            preferredSize: Size.fromHeight(kToolbarHeight)),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/watermarkimage2.png'))),
            child: ListView.builder(
                itemCount: valuations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          '${valuations[index].image}',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          valuations[index].title!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          valuations[index].text!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 14, height: 1.5),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButtonWidget(
                              width: 211,
                              height: 38,
                              buttonText: 'Book A Valuation',
                              borderRadius: 8,
                              textSize: 14,
                              ontap: () {
                                Navigator.of(context)
                                    .pushNamed(GetInTouchScreen.routename);
                              },
                              textColor: Colors.white,
                              bgColor: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  );
                }))
        //bottomNavigationBar: const BottomNavigationWidget()
        );
  }
}
