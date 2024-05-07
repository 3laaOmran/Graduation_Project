import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

class BuilsCharityItem extends StatefulWidget {
  const BuilsCharityItem({super.key, required this.charityItemModel});

  final CharityItemModel charityItemModel;

  @override
  State<BuilsCharityItem> createState() => _BuilsCharityItemState();
}

class _BuilsCharityItemState extends State<BuilsCharityItem> {
  bool? isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              side: const BorderSide(
                color: ColorManager.mainOrange,
                width: 2,
              ),
              activeColor: ColorManager.mainOrange,
              value: isSelected,
              onChanged: (bool? newValue) {
                setState(() {
                  isSelected = newValue;
                });
              },
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: Container(
                decoration: const BoxDecoration(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            AssetImage(widget.charityItemModel.image),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.charityItemModel.name,
                              style: TextStyles.font15BlackBold,
                            ),
                            Text(
                              'Charity',
                              style: TextStyles.font11GreyBold,
                            ),
                          ],
                        ),
                        verticalSpace(15),
                        Text(
                          '${widget.charityItemModel.value} egp',
                          style: TextStyles.font15BlackRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CharityItemModel {
  final String image;
  final String name;
  final int value;

  CharityItemModel({
    required this.image,
    required this.name,
    required this.value,
  });
}
