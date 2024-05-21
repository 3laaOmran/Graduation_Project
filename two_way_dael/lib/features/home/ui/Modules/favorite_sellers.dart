import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
// import 'package:two_way_dael/features/home/ui/widgets/build_favorite_seller_item.dart';

class FvaoriteSellers extends StatelessWidget {
  const FvaoriteSellers({super.key});

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
          'Favorite Sellers',
          style: TextStyles.font20Whitebold,
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/add_favorites.png'),
          verticalSpace(30),
          Text(
            'You don\'t have a \nfavorite sellers yet..',
            style: TextStyles.font18Grey800bold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(50),
          AppTextButton(
            buttonText: 'Add Some',
            buttonWidth: 200,
            textStyle: TextStyles.font17WhiteBold,
            onPressed: () {
              context.pop();
            },
          ),
        ],
      )),
      // CustomScrollView(
      //   slivers: [
      //     SliverList(
      //       delegate: SliverChildListDelegate(
      //         [
      //           Padding(
      //             padding: const EdgeInsetsDirectional.symmetric(
      //               horizontal: 20,
      //               vertical: 20,
      //             ),
      //             child: GridView.count(
      //               shrinkWrap: true,
      //               physics: const NeverScrollableScrollPhysics(),
      //               crossAxisCount: 2,
      //               crossAxisSpacing: 5,
      //               mainAxisSpacing: 1,
      //               childAspectRatio: 1 / 1.5, //width / height

      //               children: List.generate(
      //                   20, (index) => const BuildFavoriteSellerItem()),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
