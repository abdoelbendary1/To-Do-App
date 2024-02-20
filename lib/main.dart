import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/screens/homeScreen.dart';
import 'package:todo_app1/screens/task_list/editTaskScreen.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Unhandled Exception: PlatformException(null-error, Host platform returned null) firebase (Solved).
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCnWDt3LoSALT6o2tG0WsfTqXOQrso5ULY",
              appId: "1:1083460332141:android:b5846f364f1ab0af3a6d64",
              messagingSenderId: '1083460332141',
              projectId: "to-do-app-demo-38b05"),
        )
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppConfigProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      darkTheme: AppTheme.darkMode,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(
              task: Task(
                  title: "title",
                  description: "description",
                  dateTime: DateTime.now()),
            ),
      },
    );
  }
}
