import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/home/ui/Modules/food_details.dart';

Widget buildItem(context) => InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FoodDetails()));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        child: Container(
          width: 180.0,
          height: 200.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    height: 100.0,
                    width: 170.0,
                    child: Image(
                      image: AssetImage('assets/images/pizza.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // verticalSpace(10),
                const Spacer(),
                Text(
                  // '${model?.name}',
                  'Product Name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                      fontSize: 15.0),
                ),
                verticalSpace(10),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        // '${model?.price}',
                        '120.0',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              fontSize: 15.0,
                            ),
                      ),
                      horizontalSpace(5),
                      Text(
                        'egp',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            fontSize: 10.0),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 13.0,
                        backgroundColor: ColorManager.mainOrange,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                            left: 4,
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Image(
                              image: AssetImage('assets/images/white_cart.png'),
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
