// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app1/screens/settings/settingBotttomSheet.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    border: Border.all(color: AppTheme.primaryColor, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.english,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    border: Border.all(color: AppTheme.primaryColor, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.light,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ShowBottomSheet(
              option1: AppLocalizations.of(context)!.english,
              option2: AppLocalizations.of(context)!.arabic,
            ));
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ShowBottomSheet(
              option1: AppLocalizations.of(context)!.light,
              option2: AppLocalizations.of(context)!.dark,
            ));
  }
}
