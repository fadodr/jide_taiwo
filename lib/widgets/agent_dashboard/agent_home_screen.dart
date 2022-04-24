import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/property_provider.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/client_dashboard_menu_drawer.dart';
import 'package:provider/provider.dart';

class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agentId = ModalRoute.of(context)!.settings.arguments;
    List _containerDetails = [
      {'number': 12, 'text': 'Total number of prospect'},
      {'number': 12, 'text': 'Total number of properties available'},
      {'number': 12, 'text': 'Total number of views'}
    ];

    return Scaffold(
      backgroundColor: hextocolor('#E5E5E5'),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'My Dashboard',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
              fontSize: 20),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
                children: List.generate(
              _containerDetails.length + 1,
              (index) => index == 0
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: Text(
                                '12',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Total number of your property listings',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18, color: hextocolor('#5E5B5B')),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: ElevatedButtonWidget(
                                    width: double.maxFinite,
                                    height: 50,
                                    buttonText: 'Add new properties',
                                    borderRadius: 8,
                                    textSize: 14,
                                    ontap: () {},
                                    textColor: Colors.white,
                                    bgColor: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButtonWidget(
                                    width: double.maxFinite,
                                    height: 50,
                                    buttonText: 'View details',
                                    borderRadius: 8,
                                    textSize: 14,
                                    ontap: () {},
                                    textColor: Colors.white,
                                    bgColor: Theme.of(context).primaryColor),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: Text(
                                _containerDetails[index - 1]['number'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            _containerDetails[index - 1]['text'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18, color: hextocolor('#5E5B5B')),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButtonWidget(
                              width: double.maxFinite,
                              height: 50,
                              buttonText: 'View details',
                              borderRadius: 8,
                              textSize: 14,
                              ontap: () {},
                              textColor: Colors.white,
                              bgColor: Theme.of(context).primaryColor),
                        ],
                      ),
                    ),
            )),
          ),
        ),
      ),
    );
  }
}
