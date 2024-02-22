import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/screens/task_list/editTaskScreen.dart';
import 'package:todo_app1/screens/task_list/toasts.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskBox extends StatefulWidget {
  TaskBox({super.key, required this.task});
  Task task;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late ListProvider listProvider;
  FToast fToast = FToast();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fToast.init(context);

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProivider = Provider.of<ListProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            spacing: 10,
            autoClose: true,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            onPressed: (context) {
              FireBaseUtils.deleteTaskFromList(widget.task).timeout(
                Duration(
                  milliseconds: 500,
                ),
                onTimeout: () {
                  listProivider.getTasksList();
                },
              );

              fToast.showToast(
                child: Toasts(message: AppLocalizations.of(context)!.taskRemoved),
                toastDuration: Duration(seconds: 1),
                gravity: ToastGravity.TOP,
              );
            },
            backgroundColor: AppTheme.redColor,
            foregroundColor: AppTheme.whiteColor,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, EditTaskScreen.routeName,
              arguments: widget.task);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.light
                  ? AppTheme.whiteColor
                  : AppTheme.cardColorDark,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.02,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.task.title ??
                              AppLocalizations.of(context)!.unknownTask,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppTheme.primaryColor),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: provider.appTheme == ThemeMode.light
                                ? AppTheme.blackColor
                                : AppTheme.whiteColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat.Hm().format(widget.task.dateTime!) ??
                                AppLocalizations.of(context)!.unknownDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: provider.appTheme == ThemeMode.light
                                      ? AppTheme.blackColor
                                      : AppTheme.whiteColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                widget.task.isDone!
                    ? Text(
                        AppLocalizations.of(context)!.isDone,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppTheme.greenColor, fontSize: 30),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                          onPressed: () {
                            listProivider.updateTaskIsDone(widget.task);

                            listProivider.getTasksList();

                            print(widget.task.isDone);
                          },
                          icon: Icon(
                            Icons.check,
                            size: 30,
                            color: AppTheme.whiteColor,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
