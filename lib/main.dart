import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'helpers/location_helper.dart';
import 'helpers/themes_helper.dart';
import 'providers/event_provider.dart';
import 'providers/lobby_provider.dart';
import 'providers/ticket_provider.dart';
import 'providers/users_provider.dart';
import 'providers/wallet_provider.dart';
import 'screens/auth_screens/let_you_in_screen.dart';
import 'screens/auth_screens/sign_in_screen.dart';
import 'screens/auth_screens/sign_up_screen.dart';
import 'screens/auth_screens/welcome_screen.dart';
import 'pages/create-event/create_event_success_screen.dart';
import 'screens/profile-screen/edit_profile_screen.dart';
import 'screens/home.dart';
import 'screens/create_event.dart';
import 'screens/profile-screen/saved_event_screen.dart';
import 'screens/profile-screen/ticket_list_screen.dart';
import 'screens/profile-screen/wallet_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocationHelper.requestPermission();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => EventProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => TicketProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UsersProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => WalletProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => LobbyProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // darkTheme: ThemesHelper.lightTheme,
          theme: ThemesHelper.lightTheme,
          initialRoute: "/WelcomeScreen",
          routes: {
            Home.routeName: (context) => const Home(),
            WelcomeScreen.routeName: (context) => const WelcomeScreen(),
            LetYouInScreen.routeName: (context) => const LetYouInScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            SignInScreen.routeName: (context) => const SignInScreen(),
            CreateEventScreen.routeName: (context) => const CreateEventScreen(),
            TicketListScreen.routeName: (context) => const TicketListScreen(),
            SavedEventScreen.routeName: (context) => const SavedEventScreen(),
            EditProfileScreen.routeName: (context) => const EditProfileScreen(),
            WalletScreen.routeName: (context) => const WalletScreen(),
            EventCreateSuccessScreen.routeName: (context) =>
                const EventCreateSuccessScreen(),
          },
        ),
      ),
    );
  }
}
