import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_food_item.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

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
          'Your Orders',
          style: TextStyles.font18White,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 1,
          childAspectRatio: 1 / 1.35, //width / height

          children: List.generate(20, (index) => buildItem(context)),
        ),
      ),
    );
  }
}
