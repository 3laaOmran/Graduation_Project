import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_account_settings_item.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: TextStyles.font20blackbold,
          ),
          verticalSpace(30),
          buildAccountSettingsItem(
            image: 'assets/images/orders_list.png',
            text: 'Your Orders',
          ),
          verticalSpace(20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.donationScreen);
            },
            child: buildAccountSettingsItem(
              image: 'assets/images/donate.png',
              text: 'Donate',
            ),
          ),
          verticalSpace(20),
          buildAccountSettingsItem(
            image: 'assets/images/about.png',
            text: 'About App',
          ),
          verticalSpace(50),
          AppTextButton(
            buttonText: 'LOGOUT',
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              CashHelper.removeData(key: 'token').then((value) {
                if (value) {
                  context.pushNamedAndRemoveUntil(Routes.loginScreen,
                      predicate: ((route) => false));
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
