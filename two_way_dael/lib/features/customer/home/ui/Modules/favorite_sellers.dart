import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_favorite_seller_item.dart';

class FvaoriteSellers extends StatelessWidget {
  const FvaoriteSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var favModel = cubit.favoritesModel;
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
              'Favorite Sellers',
              style: TextStyles.font20Whitebold,
            ),
          ),
          body:
              // Center(
              //     child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset('assets/images/add_favorites.png'),
              //     verticalSpace(30),
              //     Text(
              //       'You don\'t have a \nfavorite sellers yet..',
              //       style: TextStyles.font18Grey800bold,
              //       textAlign: TextAlign.center,
              //     ),
              //     verticalSpace(50),
              //     AppTextButton(
              //       buttonText: 'Add Some',
              //       buttonWidth: 200,
              //       textStyle: TextStyles.font17WhiteBold,
              //       onPressed: () {
              //         context.pop();
              //       },
              //     ),
              //   ],
              // )),
              CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1 / 1.5, //width / height

                        children: List.generate(
                            favModel!.data!.length,
                            (index) => BuildFavoriteSellerItem(
                                  favItem: favModel.data![index],
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
