import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/providers/app_config_provider.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowThemBottomSheet extends StatefulWidget {
  ShowThemBottomSheet();

  @override
  State<ShowThemBottomSheet> createState() => _ShowThemBottomSheetState();
}

class _ShowThemBottomSheetState extends State<ShowThemBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                provider.changeTheme(ThemeMode.light);
              },
              child: provider.appTheme == ThemeMode.light
                  ? getselectedWidget(AppLocalizations.of(context)!.light)
                  : getUnselectedWidget(AppLocalizations.of(context)!.light),
            ),
            Divider(
              thickness: 4,
              color: AppTheme.greyColor,
            ),
            GestureDetector(
              onTap: () {
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.isDark()
                  ? getselectedWidget(AppLocalizations.of(context)!.dark)
                  : getUnselectedWidget(AppLocalizations.of(context)!.dark),
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
          size: 30,
          color: AppTheme.primaryColor,
        )
      ],
    );
  }

  Widget getUnselectedWidget(String text) {
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
      ],
    );
  }
}
