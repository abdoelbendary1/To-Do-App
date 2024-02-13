import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
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
  DateTime? _focusDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: EasyInfiniteDateTimeLine(
            locale: AppLocalizations.of(context)!.locale,
            controller: _controller,
            firstDate: DateTime(2023),
            focusDate: _focusDate,
            lastDate: DateTime(2023, 12, 31),
            onDateChange: (selectedDate) {
              setState(() {
                _focusDate = selectedDate;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => TaskBox(),
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: Colors.transparent,
            ),
            itemCount: 30,
          ),
        )
      ],
    );
  }
}
