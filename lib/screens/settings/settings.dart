// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/screens/settings/ThemeBottomSheet.dart';
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
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.appTheme == ThemeMode.light
          ? AppTheme.backgroundColor
          : AppTheme.backgrounColorDark,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.08,
            color: AppTheme.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.appTheme == ThemeMode.light
                            ? AppTheme.blackColor
                            : AppTheme.whiteColor,
                      ),
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
                        color: provider.appTheme == ThemeMode.light
                            ? AppTheme.whiteColor
                            : AppTheme.bottomAppBarColorDark,
                        border:
                            Border.all(color: AppTheme.primaryColor, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.appLanguage == "en"
                                ? AppLocalizations.of(context)!.english
                                : AppLocalizations.of(context)!.arabic,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: provider.appTheme == ThemeMode.light
                                ? AppTheme.blackColor
                                : AppTheme.whiteColor,
                          )
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
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.appTheme == ThemeMode.light
                            ? AppTheme.blackColor
                            : AppTheme.whiteColor,
                      ),
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
                        color: provider.appTheme == ThemeMode.light
                            ? AppTheme.whiteColor
                            : AppTheme.bottomAppBarColorDark,
                        border:
                            Border.all(color: AppTheme.primaryColor, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.appTheme == ThemeMode.light
                                ? AppLocalizations.of(context)!.light
                                : AppLocalizations.of(context)!.dark,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: provider.appTheme == ThemeMode.light
                                ? AppTheme.blackColor
                                : AppTheme.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ShowLanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ShowThemBottomSheet());
  }
}
