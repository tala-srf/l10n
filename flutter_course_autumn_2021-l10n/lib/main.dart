import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course_autumn_2021/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_course_autumn_2021/bloc/local_bloc/local_bloc.dart';
import 'package:flutter_course_autumn_2021/bloc/locations_bloc/locations_bloc.dart';
import 'package:flutter_course_autumn_2021/gen_l10n/app_localizations.dart';
import 'package:flutter_course_autumn_2021/ui/home.dart';
import 'package:flutter_course_autumn_2021/ui/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
}

main() async {
  WidgetsFlutterBinding();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) => print(value));
  FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('backend_token') ?? 'EMPTY_TOKEN';
  String local = sharedPreferences.getString('local') ?? 'en';
  runApp(MyApp(
    token: token,
    local: local,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.token, required this.local}) : super(key: key);
  String local;
  String token;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<LocationsBloc>(
          create: (_) => LocationsBloc(),
        ),
        BlocProvider<LocalBloc>(
          create: (context) => LocalBloc()..add(ChangeLocal(local)),
        )
      ],
      child: MainApp(
        token: token,
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  MainApp({
    Key? key,
    required String? token,
  }) : super(key: key);

  String? token;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalBloc, LocalState>(
      builder: (context, state) {
        print(state.local);
        return MaterialApp(
            title: 'Localization example',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''), // English, no country code
              Locale('es', ''), // Spanish, no country code
              Locale('ar', '')
            ],
            locale: Locale(state.local),
            routes: {'/settings': (_) => SettingsPage()},
            themeMode: ThemeMode.dark,
          
            debugShowCheckedModeBanner: false,
            home: HomePage());
      },
    );
  }

  Future<String> tokenCall() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('backend_token') ?? 'EMPTY_TOKEN';
  }

  ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.indigo,
    ).copyWith(
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 32, color: Colors.indigo),
        bodyText1: TextStyle(color: Colors.black, fontSize: 32),
      ),
      chipTheme: ChipThemeData(
          padding: EdgeInsets.all(0),
          backgroundColor: Colors.indigo.shade400,
          disabledColor: Colors.white,
          selectedColor: Colors.indigo,
          secondarySelectedColor: Colors.blue,
          labelStyle: TextStyle(fontSize: 16),
          secondaryLabelStyle: TextStyle(fontSize: 14),
          brightness: Brightness.light),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 10)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
        ),
      ),
    );
  }
}

const sharedToken = 'backend_token';
