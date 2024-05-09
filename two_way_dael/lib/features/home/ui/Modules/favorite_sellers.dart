import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_favorite_seller_item.dart';

class FvaoriteSellers extends StatelessWidget {
  const FvaoriteSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          toolbarHeight: 80,
          backgroundColor: ColorManager.mainOrange,
          title: Text(
            'Favorite Sellers',
            style: TextStyles.font20Whitebold,
          ),
          centerTitle: true,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.4, //width / height

              children: List.generate(
                  20, (index) => buildFavoriteSellerItem(context)),
            ),
          )
        ]))
      ],
    );
  }
}