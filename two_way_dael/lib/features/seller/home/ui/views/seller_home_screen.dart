import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Seller Home Screen',
                style: TextStyles.font17BlackBold,
              ),
            ),
            verticalSpace(20),
            AppTextButton(
              buttonText: 'Logout',
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {
                CashHelper.removeData(key: 'sellerToken').then((value) {
                  if (value) {
                    context.pushNamedAndRemoveUntil(
                        Routes.chooseAccountTypeScreen,
                        predicate: ((route) => false));
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
