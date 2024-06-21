import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_your_orders_item.dart';

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
        padding: const EdgeInsetsDirectional.only(
          start: 20.0,
          end: 20.0,
          top: 15.0,
          bottom: 10.0,
        ),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pushNamed(Routes.ordersDetailsScreen);
                },
                child: const BuildYourOrdersItem())),

        // child: Center(
        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Image.asset('assets/images/empty_cart.png'),
        //     verticalSpace(30),
        //     Text(
        //       'You have not order any\n product yet !!',
        //       style: TextStyles.font18Grey800bold,
        //       textAlign: TextAlign.center,
        //     ),
        //     verticalSpace(50),
        //     AppTextButton(
        //       buttonText: 'Order Now',
        //       buttonWidth: 200,
        //       textStyle: TextStyles.font17WhiteBold,
        //       onPressed: () {
        //         context.pop();
        //       },
        //     ),
        //   ],
        // )),
      ),
    );
  }
}
