import 'package:flutter/material.dart';
import 'package:todo_app1/theme/AppTheme.dart';

class ShowBottomSheet extends StatelessWidget {
  ShowBottomSheet({required this.option1, required this.option2});
  String option1;
  String option2;

  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
              child: Text(
                option1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppTheme.primaryColor, fontSize: 28),
              ),
            ),
            Divider(
              thickness: 2,
              color: AppTheme.greyColor,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                option2,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppTheme.primaryColor, fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
