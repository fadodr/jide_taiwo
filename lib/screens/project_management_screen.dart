import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/screens/getintouch_screen.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/main_menu_one_drawer.dart';

class ProjectManagementScreen extends StatelessWidget {
  static const routename = '/projectmgtscreen';
  const ProjectManagementScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _facilityMgtData = [
      {
        'title' : 'Project Management & Development Services',
        'image' : 'assets/images/Project_Management.png',
        'text' : 'Our team of project development and management include professionals in the building industry. '
      },
    ];
    
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
            builder: (context) => AppBarTwoWidget('Project Management', () {
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
                itemCount: _facilityMgtData.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            'The Project Team work across the network of our branch offices located in every geo-political zones of Nigeria. Professionally qualified and leaning on a rare assemblage of wealth of experience, each consultant regularly updates knowledge of the current trends and potentialities of the future.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14, height: 1.5),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Image.asset(
                            _facilityMgtData[index -1]['image'],
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            _facilityMgtData[index - 1]['title'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _facilityMgtData[index - 1]['text'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 13, height: 1.5),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButtonWidget(
                                width: 211,
                                height: 38,
                                buttonText: 'Speak To Us',
                                borderRadius: 8,
                                textSize: 14,
                                ontap: () {
                                  Navigator.of(context)
                                    .pushNamed(GetInTouchScreen.routename);
                                },
                                textColor: Colors.white,
                                bgColor: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  }
                })),);
  }
}
