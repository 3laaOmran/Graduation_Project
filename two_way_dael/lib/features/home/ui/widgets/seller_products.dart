import 'package:flutter/material.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_food_item.dart';

class SellerProducts extends StatelessWidget {
  const SellerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 1,
      childAspectRatio: 1 / 1.35, //width / height

      children: List.generate(20, (index) => buildItem(context)),
    );
  }
}