import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/features/customer/home/data/models/favorites_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

class BuildFavoriteSellerItem extends StatelessWidget {
  const BuildFavoriteSellerItem({super.key, required this.favItem});
  final FavoritesData favItem;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.0,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          favItem.image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Text(
                    favItem.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font18Grey800bold,
                  ),
                  verticalSpace(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        favItem.rateWithReviews ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font13GreyBold,
                      ),
                      horizontalSpace(5),
                      const Spacer(),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ColorManager.mainOrange,
                        child: Center(
                          child: customIconButton(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                              right: 2.0,
                              top: 3.0,
                              bottom: 2.0,
                            ),
                            onPressed: () {
                              
                            },
                            icon: Icons.favorite,
                            color: Colors.white,
                            size: 20.0,
                            toolTip: 'Remove from favorite',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
