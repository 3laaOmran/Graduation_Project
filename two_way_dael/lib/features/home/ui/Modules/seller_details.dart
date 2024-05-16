import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_food_item.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_sliver_appbar.dart';

class SellerDetailsScreen extends StatelessWidget {
  const SellerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            RatingBarIndicator(
                              rating: 4,
                              itemCount: 5,
                              itemSize: 25.0,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: ColorManager.mainOrange,
                              ),
                            ),
                            const Spacer(),
                            AppTextButton(
                              buttonWidth: 100,
                              buttonHeight: 30,
                              verticalPadding: 0,
                              textStyle: TextStyles.font12White,
                              buttonText: 'Rate us',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Center(
                                          child: Text(
                                        'Rate Us',
                                        style: TextStyle(
                                          color: ColorManager.mainOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Center(
                                          heightFactor:
                                              BorderSide.strokeAlignCenter,
                                          child: RatingBarIndicator(
                                            rating: 0,
                                            itemCount: 5,
                                            itemSize: 25.0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: ColorManager.mainOrange,
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppTextButton(
                                              buttonText: 'Cancel',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              buttonWidth: 80,
                                              verticalPadding: 0,
                                              buttonHeight: 30,
                                              textStyle: TextStyles.font12White,
                                            ),
                                            horizontalSpace(20),
                                            AppTextButton(
                                              buttonText: 'Send',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              buttonWidth: 80,
                                              verticalPadding: 0,
                                              buttonHeight: 30,
                                              textStyle: TextStyles.font12White,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          Text(
                            'About',
                            style: TextStyles.font20blackbold,
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 20.0,
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
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Address: ',
                                style: TextStyles.font17BlackBold),
                            TextSpan(
                                text: ' ElBhira / Nobaria',
                                style: TextStyles.font17BlackBold),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Contacts: ',
                                style: TextStyles.font17BlackBold),
                            TextSpan(
                                text: ' 01286765359',
                                style: TextStyles.font17BlackBold),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        'Products',
                        style: TextStyles.font20blackbold,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1 / 1.35, //width / height

                        children:
                            List.generate(20, (index) => buildItem(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
