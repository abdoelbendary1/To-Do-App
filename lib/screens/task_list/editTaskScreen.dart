import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/providers/ListProvider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app1/screens/task_list/toasts.dart';
import 'package:todo_app1/theme/AppTheme.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  static const String routeName = "/EditTaskScreen";
  Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen>
    with SingleTickerProviderStateMixin {
  var formkey = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  var selectedDate = DateTime.now();
  late AnimationController animationController;
  late ListProvider listProvider;
  FToast fToast = FToast();

  //? toast msg

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
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);

    var args = ModalRoute.of(context)!.settings.arguments as Task;
    widget.task = args;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        titleSpacing: 30,
        toolbarHeight: MediaQuery.of(context).size.height * .11,
        title: Text(
          AppLocalizations.of(context)!.appBarTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        color: provider.appTheme == ThemeMode.light
            ? AppTheme.backgroundColor
            : AppTheme.backgrounColorDark,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              color: AppTheme.primaryColor,
            ),
            Center(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.only(bottom: 150),
                  width: MediaQuery.of(context).size.width * .85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: provider.appTheme == ThemeMode.light
                        ? AppTheme.whiteColor
                        : AppTheme.bottomAppBarColorDark,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.editTask,
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
                        // taking data from user

                        Form(
                            key: formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.taskTitle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),

                                  //task title data
                                  child: TextFormField(
                                    style: TextStyle(
                                      color:
                                          provider.appTheme == ThemeMode.light
                                              ? AppTheme.blackColor
                                              : AppTheme.whiteColor,
                                    ),
                                    controller: taskTitleController =
                                        TextEditingController(text: args.title),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .errorMessegeTitle;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // hintText: args.title,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: provider.appTheme ==
                                                    ThemeMode.light
                                                ? AppTheme.blackColor
                                                : AppTheme.whiteColor,
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.taskDesc,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),

                                  //task desc data
                                  child: TextFormField(
                                    style: TextStyle(
                                      color:
                                          provider.appTheme == ThemeMode.light
                                              ? AppTheme.blackColor
                                              : AppTheme.whiteColor,
                                    ),
                                    controller: taskDescriptionController =
                                        TextEditingController(
                                            text: args.description),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .errorMessegeDesc;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: provider.appTheme ==
                                                    ThemeMode.light
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: provider.appTheme ==
                                                  ThemeMode.light
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
                                    //handling showing selcteddate
                                    child: selectedDate == DateTime.now()
                                        ? Text(
                                            DateFormat.yMMMd()
                                                .format(args.dateTime!),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: provider.appTheme ==
                                                          ThemeMode.light
                                                      ? AppTheme.blackColor
                                                      : AppTheme.whiteColor,
                                                ),
                                          )
                                        : Text(
                                            DateFormat.yMMMd()
                                                .format(selectedDate),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: provider.appTheme ==
                                                          ThemeMode.light
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

                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            foregroundColor:
                                                AppTheme.whiteColor,
                                            backgroundColor:
                                                AppTheme.primaryColor),
                                        onPressed: () {
                                          editTask();

                                          listProvider
                                              .updateTaskDetails(widget.task);
                                          listProvider.getTasksList();

                                          fToast.showToast(
                                            child: Toasts(
                                                message: AppLocalizations.of(
                                                        context)!
                                                    .taskEdited),
                                            toastDuration: Duration(seconds: 1),
                                            gravity: ToastGravity.TOP,
                                          );
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!.save,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontSize: 20,
                                                  color: provider.appTheme ==
                                                          ThemeMode.light
                                                      ? AppTheme.whiteColor
                                                      : AppTheme.whiteColor,
                                                ))),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
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

  void editTask() {
    if (formkey.currentState?.validate() == true) {
      widget.task.title = taskTitleController.text;
      widget.task.description = taskDescriptionController.text;
      widget.task.dateTime = selectedDate;
    }
  }
}
