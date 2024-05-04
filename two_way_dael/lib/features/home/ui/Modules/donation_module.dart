import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_charity_item.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Donate Now',
                style: TextStyles.font18White,
              ),
              verticalSpace(10),
              Text(
                'Donating has now become easier',
                style: TextStyles.font12White,
              ),
            ],
          ),
        ),
        body: ListView.separated(
          itemCount: 15,
          itemBuilder: (context, index) => const CharityItem(),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.5,
            color: Colors.grey[300],
          ),
        ));
  }
}


