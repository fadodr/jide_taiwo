import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/screens/home_screen.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';

class OnboardingWidget extends StatefulWidget {
  final String imgText;
  final int screenIndex;
  final PageController pageController;

  const OnboardingWidget(
      {required this.imgText,
      required this.screenIndex,
      required this.pageController,
      Key? key})
      : super(key: key);

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  List<String> headlineText = [
    'Buy, Sell and Lease properties.',
    'Property Auctions',
    'Determine the worth of your property'
  ];

  List<String> bodyText = [
    '',
    'Search, bid and buy properties with the tap of your finger.',
    'Our teams of experts in valuation are poised to offer prompt, accurate and industry acclaimed services. This helps our clients make better business decisions.'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
            padding: EdgeInsets.only(top: 50),
            child: Image(
              image: AssetImage(widget.imgText),
              fit: BoxFit.cover,
            )),
          ),
            Column(
              children: [
                 Text(headlineText[widget.screenIndex],
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              if (bodyText[widget.screenIndex] != '')
              Text(
                bodyText[widget.screenIndex],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return index == widget.screenIndex
                        ? Container(
                            width: 36,
                            height: 10,
                            margin: const EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : Container(
                            width: 14,
                            height: 10,
                            margin: const EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey,
                            ),
                          );
                  })),
              const SizedBox(height: 20),
              widget.screenIndex == 0
                  ? Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButtonWidget(
                        width: 153,
                        height: 50,
                        bgColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        borderRadius: 28,
                        ontap: () {
                          setState(() {
                            widget.pageController.animateToPage(
                                (widget.screenIndex + 1),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut);
                          });
                        },
                        buttonText:
                            widget.screenIndex == 2 ? 'Gest Started' : 'Next',
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                widget.pageController.animateToPage(
                                    (widget.screenIndex - 1),
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut);
                              });
                            },
                            child: Text(
                              'Back',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor),
                            )),
                        ElevatedButtonWidget(
                          width: 153,
                          bgColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          height: 50,
                          borderRadius: 28,
                          ontap: () {
                            setState(() {
                              if (widget.screenIndex == 2) {
                                Navigator.of(context)
                                    .pushNamed(HomeScreen.routename);
                              } else {
                                widget.pageController.animateToPage(
                                    (widget.screenIndex + 1),
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }
                            });
                          },
                          buttonText:
                              widget.screenIndex == 2 ? 'Get Started' : 'Next',
                        )
                      ],
                    )
              ],
            )
        ],
      ),
    );
  }
}
