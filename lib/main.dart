import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/account_type_provider.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_dashboard_provider.dart';
import 'package:jidetaiwoapp/provider/property_image_provider.dart';
import 'package:jidetaiwoapp/provider/property_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/screens/Terms_and_condition.dart';
import 'package:jidetaiwoapp/screens/aboutus_screen.dart';
import 'package:jidetaiwoapp/screens/advisory_screen.dart';
import 'package:jidetaiwoapp/screens/agency_screen.dart';
import 'package:jidetaiwoapp/screens/agentlisting_screen.dart';
import 'package:jidetaiwoapp/screens/auction_screen.dart';
import 'package:jidetaiwoapp/screens/change_password_screen.dart';
import 'package:jidetaiwoapp/screens/client_dashboard_screen.dart';
import 'package:jidetaiwoapp/screens/entercode_screen.dart';
import 'package:jidetaiwoapp/screens/forgot_password_screen.dart';
import 'package:jidetaiwoapp/screens/login_screen.dart';
import 'package:jidetaiwoapp/screens/reset_password_screen.dart';
import 'package:jidetaiwoapp/screens/signup_screen.dart';
import 'package:jidetaiwoapp/screens/exploreproperty_screen.dart';
import 'package:jidetaiwoapp/screens/facility_management_screen.dart';
import 'package:jidetaiwoapp/screens/getintouch_screen.dart';
import 'package:jidetaiwoapp/screens/home_screen.dart';
import 'package:jidetaiwoapp/screens/agent_dashboard_screen.dart';
import 'package:jidetaiwoapp/screens/onboarding_screen.dart';
import 'package:jidetaiwoapp/screens/edit_profile_screen.dart';
import 'package:jidetaiwoapp/screens/project_management_screen.dart';
import 'package:jidetaiwoapp/screens/public_sector_screen.dart';
import 'package:jidetaiwoapp/screens/searchforproperty_screen.dart';
import 'package:jidetaiwoapp/screens/splashscreen.dart';
import 'package:jidetaiwoapp/screens/valuation_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientDashboardProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => PropertyImageProvider()),
        ChangeNotifierProvider(create: (_) => Clientprovider()),
        ChangeNotifierProvider(create: (_) => Agentprovider()),
        ChangeNotifierProvider(create: (_) => AccountTypeProvider()),
      ],
      child: MaterialApp(
        title: 'Jide Taiwo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: hextocolor('#D30016'),
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: hextocolor('#FFEEED')),
          brightness: Brightness.light,
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold),
              headline6: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 36.0,
                  fontStyle: FontStyle.normal),
              bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
              button: TextStyle(
                  fontFamily: 'Roboto', fontSize: 18, color: Colors.white)),
        ),
        home: SplashScreen(),
        routes: {
          AboutusScreen.routename: (ctx) => const AboutusScreen(),
          AgencyScreen.routename: (ctx) => const AgencyScreen(),
          AgentListingScreen.routename: (ctx) => const AgentListingScreen(),
          AuctionScreen.routename: (ctx) => const AuctionScreen(),
          LoginScreen.routename: (ctx) => const LoginScreen(),
          SignupScreen.routename: (ctx) => const SignupScreen(),
          ExplorePropertyScreen.routename: (ctx) =>
              const ExplorePropertyScreen(),
          HomeScreen.routename: (ctx) => const HomeScreen(),
          AgentdashboardScreen.routename: (ctx) => const AgentdashboardScreen(),
          OnboardingScreen.routename: (ctx) => const OnboardingScreen(),
          SearchforpropertyScreen.routename: (ctx) => SearchforpropertyScreen(),
          GetInTouchScreen.routename: (ctx) => const GetInTouchScreen(),
          ValuationScreen.routename: (ctx) => const ValuationScreen(),
          FacilityManagementScreen.routename: (ctx) =>
              const FacilityManagementScreen(),
          ProjectManagementScreen.routename: (ctx) =>
              const ProjectManagementScreen(),
          PublicSectorScreen.routename: (ctx) => const PublicSectorScreen(),
          AdvisoryScreen.routename: (ctx) => const AdvisoryScreen(),
          ChangePasswordScreen.routename: (ctx) => const ChangePasswordScreen(),
          ClientDashboardScreen.routename: (ctx) =>
              const ClientDashboardScreen(),
          EditProfileScreen.routename: (ctx) => const EditProfileScreen(),
          ForgotPasswordScreen.routename : (ctx) => ForgotPasswordScreen(),
          EnterCodeScreen.routename: (ctx) => EnterCodeScreen(),
          ResetPasswordScreen.routename : (ctx) => ResetPasswordScreen(),
          TermsScreen.routename : (ctx) => TermsScreen()
        },
      ),
    );
  }
}
