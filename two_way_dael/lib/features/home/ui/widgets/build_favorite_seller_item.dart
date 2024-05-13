import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/ui/Modules/seller_details.dart';

Widget buildFavoriteSellerItem(context) => InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SellerDetailsScreen()));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        child: Container(
          width: 180.0,
          height: 250.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.asset(
                        'assets/images/default_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                verticalSpace(10),
                Text(
                  'Seller Name',
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
                      'City Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font13GreyBold,
                    ),
                    horizontalSpace(5),
                    const Spacer(),
                    CircleAvatar(
                      radius: 13.0,
                      backgroundColor: ColorManager.gray,
                      child: IconButton(
                        padding: const EdgeInsetsDirectional.only(
                          end: 2.0,
                          start: 2.0,
                          top: 3.0,
                          bottom: 2.0,
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
