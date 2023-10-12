import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'helpers/location_helper.dart';
import 'helpers/themes_helper.dart';
import 'providers/event_provider.dart';
import 'providers/ticket_provider.dart';
import 'screens/create-event-screen/create_event_success_screen.dart';
import 'screens/profile-screen/edit_profile_screen.dart';
import 'screens/home.dart';
import 'screens/create-event-screen/create_event.dart';
import 'screens/profile-screen/saved_event_screen.dart';
import 'screens/profile-screen/ticket_list_screen.dart';
import 'screens/profile-screen/wallet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocationHelper.requestPermission();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => EventProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => TicketProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // darkTheme: ThemesHelper.lightTheme,
          theme: ThemesHelper.lightTheme,
          initialRoute: "/",
          routes: {
            Home.routeName: (context) => const Home(),
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
