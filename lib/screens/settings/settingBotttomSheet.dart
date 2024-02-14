import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowLanguageBottomSheet extends StatefulWidget {
  ShowLanguageBottomSheet();

  @override
  State<ShowLanguageBottomSheet> createState() =>
      _ShowLanguageBottomSheetState();
}

class _ShowLanguageBottomSheetState extends State<ShowLanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: provider.appTheme == ThemeMode.light
            ? AppTheme.whiteColor
            : AppTheme.bottomAppBarColorDark,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                provider.changeLanguage("en");
              },
              child: provider.appLanguage == "en"
                  ? getselectedWidget(AppLocalizations.of(context)!.english)
                  : getUnselectedWidget(AppLocalizations.of(context)!.english),
            ),
            Divider(
              thickness: 2,
              color: AppTheme.greyColor,
            ),
            GestureDetector(
              onTap: () {
                provider.changeLanguage("ar");
              },
              child: provider.appLanguage == "ar"
                  ? getselectedWidget(AppLocalizations.of(context)!.arabic)
                  : getUnselectedWidget(AppLocalizations.of(context)!.arabic),
            ),
          ],
        ),
      ),
    );
  }

  Widget getselectedWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppTheme.primaryColor, fontSize: 28),
        ),
        Icon(
          Icons.check_circle,
          size: 40,
          color: AppTheme.primaryColor,
        )
      ],
    );
  }

  Widget getUnselectedWidget(String text) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppTheme.primaryColor, fontSize: 28),
      ),
    );
  }
}
