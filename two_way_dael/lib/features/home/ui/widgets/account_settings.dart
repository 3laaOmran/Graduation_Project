import 'package:flutter/material.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_account_settings_item.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

Widget accountSettings() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
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
        buildAccountSettingsItem(
          image: 'assets/images/wallet.png',
          text: 'Your Pay',
        ),
        verticalSpace(20),
        buildAccountSettingsItem(
          image: 'assets/images/donate.png',
          text: 'Donate',
        ),
        verticalSpace(20),
        buildAccountSettingsItem(
          image: 'assets/images/about.png',
          text: 'About App',
        ),
      ],
    ),
  );
}
