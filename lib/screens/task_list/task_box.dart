import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
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
                onTimeout: () => print("task deleted"),
              );
            },
            backgroundColor: AppTheme.redColor,
            foregroundColor: AppTheme.whiteColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.task.title ?? "Unknown task"),
                  Text(widget.task.description ?? "Unknown description "),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check,
                      size: 30,
                      color: AppTheme.whiteColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
