import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: provider.appTheme == ThemeMode.light
              ? AppTheme.whiteColor
              : AppTheme.bottomAppBarColorDark,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.addTask,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.appTheme == ThemeMode.light
                            ? AppTheme.blackColor
                            : AppTheme.whiteColor,
                      ),
                ),
              ),
              Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: taskTitleController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .errorMessegeTitle;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.hintTitle,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: provider.appTheme == ThemeMode.light
                                      ? AppTheme.blackColor
                                      : AppTheme.whiteColor,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: taskDescriptionController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .errorMessegeDesc;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.hintDesc,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: provider.appTheme == ThemeMode.light
                                      ? AppTheme.blackColor
                                      : AppTheme.whiteColor,
                                ),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.selectDate,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: provider.appTheme == ThemeMode.light
                                        ? AppTheme.blackColor
                                        : AppTheme.whiteColor,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            pickDate();
                          },
                          child: Text(
                            DateFormat.yMMMd().format(selectedDate),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: provider.appTheme == ThemeMode.light
                                      ? AppTheme.blackColor
                                      : AppTheme.whiteColor,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: AppTheme.whiteColor,
                              textStyle: Theme.of(context).textTheme.titleSmall,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            addTask();
                          },
                          child: Text(AppLocalizations.of(context)!.addButton),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void pickDate() async {
    var chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void addTask() {
    if (formkey.currentState?.validate() == true) {
      Task task = Task(
        title: taskTitleController.text,
        description: taskDescriptionController.text,
        dateTime: selectedDate,
      );
      FireBaseUtils.addTaskToFireStore(task)
          .timeout(const Duration(milliseconds: 500), onTimeout: () {
        print("Task added succesfully");
        Navigator.pop(context);
      });
    }
  }
}
