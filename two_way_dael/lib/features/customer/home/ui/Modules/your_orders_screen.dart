import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_your_orders_item.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/order_details_screen.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetCustomerOrderDetailsSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return OrderDetailsScreen(
                orderDetailsModel: state.orderDetailsModel!);
          }));
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
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
            child: cubit.customerOrders!.data!.orders!.isNotEmpty
                ? ListView.builder(
                    itemCount: cubit.customerOrders!.data!.orders!.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.getCustomerOrderDetails(
                              id: cubit
                                  .customerOrders!.data!.orders![index].id!);
                        },
                        child: BuildYourOrdersItem(
                          order: cubit.customerOrders!.data!.orders![index],
                        )))
                : Center(
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
      },
    );
  }
}
