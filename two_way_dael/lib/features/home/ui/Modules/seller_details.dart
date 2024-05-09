import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_food_item.dart';

class SellerDetailsScreen extends StatelessWidget {
  const SellerDetailsScreen({super.key});

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      leading: customIconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icons.arrow_back,
        color: ColorManager.mainOrange,
      ),
      centerTitle: true,
      expandedHeight: 450,
      toolbarHeight: 60,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: const Text(
          '\t Seller Name',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ColorManager.mainOrange,
          ),
        ),
        background: Hero(
          tag: 1,
          child: Image.asset(
            'assets/images/default_profile.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

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
                                text: ' ElBhira / Abohomos',
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
