import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app1/auth/login/login.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/providers/auth_provider.dart';
import 'package:todo_app1/screens/settings/settings.dart';
import 'package:todo_app1/screens/task_list/bottomSheet.dart';
import 'package:todo_app1/screens/task_list/task_list_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app1/theme/AppTheme.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    TaskListTab(),
    SettingsTab(),
  ];
  Future logout() async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthinticationProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showAddTaskBottomSheet();
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  listProvider.tasksList = [];
                  authProvider.currentUser = null;
                  await logout();
                },
                icon: Icon(Icons.exit_to_app))
          ],
          titleSpacing: 30,
          toolbarHeight: MediaQuery.of(context).size.height * .11,
          title: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: "${AppLocalizations.of(context)!.appBarTitle} | ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextSpan(
                text: "${authProvider.currentUser?.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ]),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.15,
          color: provider.appTheme == ThemeMode.light
              ? AppTheme.whiteColor
              : AppTheme.bottomAppBarColorDark,
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          child: BottomNavigationBar(
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              currentIndex: selectedIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                    ),
                    label: "Task List"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: "Settings"),
              ]),
        ),
        body: tabs[selectedIndex]);
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
