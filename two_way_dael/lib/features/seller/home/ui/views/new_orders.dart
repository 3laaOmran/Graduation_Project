import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';

class NewOrdersScreen extends StatelessWidget {
  const NewOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: customIconButton(
          toolTip: 'back',
          onPressed: () {
            context.pop();
          },
          icon: Icons.arrow_back,
          color: Colors.white,
        ),
        backgroundColor: ColorManager.mainOrange,
        title: Text(
          'New Orders',
          style: TextStyles.font20Whitebold,
        ),
      ),
      body: Center(
        child: Image.asset('assets/images/seller_no_orders.png'),
      ),
    );
  }
}
