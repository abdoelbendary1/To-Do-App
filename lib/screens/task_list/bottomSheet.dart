import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/theme/AppTheme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet>
    with SingleTickerProviderStateMixin {
  var formkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  late AnimationController animationController;
  late ListProvider listProvider;

  //? toast msg
  FToast fToast = FToast();
  Widget taskToast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: AppTheme.greenColor.withOpacity(0.9),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          color: AppTheme.whiteColor,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(
          "Task added Succesfully!",
          style: TextStyle(color: AppTheme.whiteColor, fontSize: 20),
        ),
      ],
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return buildBottomSheet(provider, context);
  }

  Widget buildBottomSheet(
    AppConfigProvider provider,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Container(
        // bottomSheet decoration
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
              // taking data from user

              Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        //task title data
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

                        //task desc data
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

                        //select date

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
                        child: Center(
                          //add task button

                          child: GestureDetector(
                            onTap: () {
                              addTask();

                              fToast.showToast(
                                  child: taskToast,
                                  toastDuration: Duration(seconds: 1),
                                  gravity: ToastGravity.TOP);
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.add_event,
                              progress: animationController,
                              size: 80,
                              color: AppTheme.primaryColor,
                            ),
                          ),
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

  bool isAdded = false;
  void taskIconTapped() {
    if (isAdded == false) {
      animationController.forward();
      isAdded = true;
    } else {
      animationController.reverse();
      isAdded = false;
    }
  }

  void addTask() {
    if (formkey.currentState?.validate() == true) {
      Task task = Task(
        title: taskTitleController.text,
        description: taskDescriptionController.text,
        dateTime: selectedDate,
      );
      taskIconTapped();
      FireBaseUtils.addTaskToFireStore(task)
          .timeout(const Duration(milliseconds: 500), onTimeout: () {
        listProvider.getTasksList();
        print("task added");
        Navigator.pop(context);
      });
    }
  }
}
