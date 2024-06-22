import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_account_settings_item.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Settings',
              style: TextStyles.font20blackbold,
            ),
            verticalSpace(30),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.yourOrdersScreen);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/orders_list.png',
                text: 'Your Orders',
              ),
            ),
            verticalSpace(20),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.favoriteSellers);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/favorites.png',
                text: 'Favorites',
              ),
            ),
            verticalSpace(20),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.contactUsScreen);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/contact_us_icon.png',
                text: 'Contact Us',
              ),
            ),
            verticalSpace(20),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.aboutAppScreen);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/about.png',
                text: 'About App',
              ),
            ),
            verticalSpace(50),
            AppTextButton(
              buttonText: 'Logout',
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {
                CashHelper.removeData(key: 'token').then((value) {
                  if (value) {
                    context.pushNamedAndRemoveUntil(
                        Routes.chooseAccountTypeScreen,
                        predicate: ((route) => false));
                  }
                });
              },
            ),
            verticalSpace(150),
          ],
        ),
      ),
    );
  }
}
