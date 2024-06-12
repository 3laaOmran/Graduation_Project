import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_account_settings_item.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';

class SellerAccountSettings extends StatelessWidget {
  const SellerAccountSettings({super.key});

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
            verticalSpace(20),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.sellerNewOrdersScreen);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/orders_list.png',
                text: 'New Orders',
              ),
            ),
            verticalSpace(20),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.sellerAddNewProduct);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/add_product.png',
                text: 'Add New Product',
              ),
            ),
            verticalSpace(20),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.sellerDonationScreen);
              },
              child: buildAccountSettingsItem(
                image: 'assets/images/favorites.png',
                text: 'Donate Now',
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
                CashHelper.removeData(key: 'sellerToken').then((value) {
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
