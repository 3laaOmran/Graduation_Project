import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';

Widget buildSellerProductItem() {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 15,
          offset: Offset(8, 8),
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage('assets/images/pizza.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        verticalSpace(10),
        Text(
          'ProductModel',
          style: TextStyles.font17BlackBold,
        ),
        verticalSpace(5),
        Row(
          children: [
            Text(
              '150 egp',
              style: TextStyles.font13GreyBold,
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: ColorManager.mainOrange,
              child: customIconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icons.add,
                toolTip: 'Edit',
                size: 23,
              ),
            ),
            horizontalSpace(5),
            const DeleteCircleAvatar(),
          ],
        ),
      ],
    ),
  );
}

class DeleteCircleAvatar extends StatelessWidget {
  const DeleteCircleAvatar({super.key});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorManager.mainOrange,
      child: customIconButton(
        color: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Center(child: Text('Are you sure ?!')),
              content:
                  const Text('You want to delete permanently this Product'),
              actions: [
                AppTextButton(
                  buttonText: 'Yes',
                  textStyle: TextStyles.font12White,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  buttonWidth: 30,
                  buttonHeight: 15,
                ),
                AppTextButton(
                  buttonText: 'No',
                  textStyle: TextStyles.font12White,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  buttonWidth: 30,
                  buttonHeight: 15,
                ),
              ],
            ),
          );
        },
        icon: Icons.close,
        toolTip: 'Delete',
        size: 23,
      ),
    );
  }
}
