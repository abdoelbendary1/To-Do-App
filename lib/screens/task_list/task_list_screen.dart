import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/providers/auth_provider.dart';
import 'package:todo_app1/screens/task_list/task_box.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListTab extends StatefulWidget {
  TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  List<Task> tasksList = [];
  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   var listProvider = Provider.of<ListProvider>(context);
  //   listProvider.getTasksList();
  //   setState(() {
  //     tasksList = listProvider.tasksList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider =
        Provider.of<AuthinticationProvider>(context, listen: false);
    if (listProvider.tasksList.isEmpty) {
      print("build screen");
      listProvider.getTasksList(authProvider.currentUser?.id ?? "");
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              color: AppTheme.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: EasyInfiniteDateTimeLine(
                timeLineProps: const EasyTimeLineProps(separatorPadding: 14),
                showTimelineHeader: false,
                locale: AppLocalizations.of(context)!.locale,
                activeColor: provider.appTheme == ThemeMode.light
                    ? AppTheme.whiteColor
                    : AppTheme.bottomAppBarColorDark,
                dayProps: EasyDayProps(
                  todayStyle: DayStyle(
                    monthStrStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                    ),
                    dayStrStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                    ),
                    dayNumStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.whiteColor
                          : AppTheme.bottomAppBarColorDark,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * .1,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    monthStrStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.primaryColor
                          : AppTheme.whiteColor,
                    ),
                    dayStrStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.primaryColor
                          : AppTheme.whiteColor,
                    ),
                    dayNumStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.primaryColor
                          : AppTheme.whiteColor,
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    monthStrStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                    ),
                    dayStrStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                    ),
                    dayNumStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.blackColor
                          : AppTheme.whiteColor,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: provider.appTheme == ThemeMode.light
                          ? AppTheme.whiteColor
                          : AppTheme.bottomAppBarColorDark,
                    ),
                  ),
                ),
                controller: _controller,
                firstDate: DateTime.now().subtract(Duration(days: 7)),
                focusDate: listProvider.selectedDate,
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChange: (date) {
                  listProvider.changeSelectedDay(
                      date, authProvider.currentUser!.id!);
                  listProvider.getTasksList(authProvider.currentUser!.id!);

                  print(listProvider.selectedDate);
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => TaskBox(
              task: listProvider.tasksList[index],
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 20,
              color: Colors.transparent,
            ),
            itemCount: listProvider.tasksList.length,
          ),
        )
      ],
    );
  }
}
