import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: ColorManager.mainOrange,
        title: Text(
          'Your Orders',
          style: TextStyles.font18White,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty_cart.png'),
            verticalSpace(30),
            Text(
              'You have not order any\n product yet !!',
              style: TextStyles.font18Grey800bold,
              textAlign: TextAlign.center,
            ),
            verticalSpace(50),
            AppTextButton(
              buttonText: 'Order Now',
              buttonWidth: 200,
              textStyle: TextStyles.font17WhiteBold,
              onPressed: () {
                context.pop();
              },
            ),
          ],
        )),
      ),
    );
  }
}
//  child: GridView.count(
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 5,
          //   mainAxisSpacing: 1,
          //   childAspectRatio: 1 / 1.35, //width / height
        
          //   children: List.generate(5, (index) => buildItem(context)),
          // ),