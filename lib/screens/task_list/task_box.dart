import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/screens/task_list/editTaskScreen.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskBox extends StatefulWidget {
  TaskBox({super.key, required this.task});
  Task task;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
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
            autoClose: true,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            onPressed: (context) {
              FireBaseUtils.deleteTaskFromList(widget.task).timeout(
                Duration(
                  milliseconds: 500,
                ),
                onTimeout: () => listProivider.getTasksList(),
              );
            },
            backgroundColor: AppTheme.redColor,
            foregroundColor: AppTheme.whiteColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, EditTaskScreen.routeName,
              arguments: Task(
                title: widget.task.title,
                description: widget.task.description,
                dateTime: widget.task.dateTime,
                isDone: false,
              ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(
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
                        text: widget.task.title ?? "Unknown task",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppTheme.primaryColor),
                      )),
                      Row(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat.Hm().format(widget.task.dateTime!) ??
                                "Unknown Date ",
                            style: Theme.of(context).textTheme.bodyLarge,
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
                        "Is done!",
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
