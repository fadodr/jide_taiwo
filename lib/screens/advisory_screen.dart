import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/screens/getintouch_screen.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/provider/advisory_consultancy_provider.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/main_menu_one_drawer.dart';

class AdvisoryScreen extends StatelessWidget {
  static const routename = '/advisoryscreen';
  const AdvisoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => AppBarTwoWidget('Advisory & Consultancy', () {
            Scaffold.of(context).openDrawer();
          }),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const MenuMenuOneDrawer(),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
          child: ListView.builder(
              itemCount: advisories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        '${advisories[index].image}',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        advisories[index].title!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        advisories[index].text!,
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
                            buttonText: 'Speak To Us',
                            borderRadius: 10,
                            textSize: 14,
                            ontap: () {
                              Navigator.of(context)
                                  .pushNamed(GetInTouchScreen.routename);
                            },
                            textColor: Colors.white,
                            bgColor: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
