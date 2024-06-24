import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/features/customer/home/data/models/deals_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/food_details.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_food_item.dart';

class BestSaleScreen extends StatelessWidget {
  const BestSaleScreen({super.key, required this.bestsaleModel});
  final BestsaleModel bestsaleModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetProductDetailsSuccessState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetails(
                      product: CustomerCubit.get(context)
                          .productDetails!
                          .data!
                          .product!)));
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
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
              'Best Sales',
              style: TextStyles.font20Whitebold,
            ),
          ),
          body: GridView.count(
            padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 1.4,
            children: List.generate(
              bestsaleModel.data!.length,
              (index) {
                var product = bestsaleModel.data![index];
                return InkWell(
                  onTap: () {
                    var productId = product.id;
                    if (productId != null) {
                      cubit.getProductDetails(id: productId);
                    }
                  },
                  child: buildItem(context, product),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
