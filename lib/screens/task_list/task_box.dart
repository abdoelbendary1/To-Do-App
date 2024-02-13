import 'package:flutter/material.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: AppTheme.whiteColor, borderRadius: BorderRadius.circular(15)),
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
                Text(AppLocalizations.of(context)!.taskTitle),
                Text(AppLocalizations.of(context)!.taskDesc),
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
    );
  }
}
