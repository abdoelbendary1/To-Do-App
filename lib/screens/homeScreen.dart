import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/screens/settings/settings.dart';
import 'package:todo_app1/screens/task_list/bottomSheet.dart';
import 'package:todo_app1/screens/task_list/task_list_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
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
          titleSpacing: 30,
          toolbarHeight: MediaQuery.of(context).size.height * .11,
          title: Text(
            AppLocalizations.of(context)!.appBarTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.115,
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
