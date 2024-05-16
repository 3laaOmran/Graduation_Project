import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/widgets/show_bottom_sheet.dart';

class BuildCharityItem extends StatefulWidget {
  const BuildCharityItem({super.key, required this.charityItemModel});

  final CharityItemModel charityItemModel;

  @override
  State<BuildCharityItem> createState() => _BuildCharityItemState();
}

class _BuildCharityItemState extends State<BuildCharityItem> {
  bool? isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            showBottomSheetMethod(context);
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Row(
                children: [
                  // Checkbox(
                  //   side: const BorderSide(
                  //     color: ColorManager.mainOrange,
                  //     width: 2,
                  //   ),
                  //   activeColor: ColorManager.mainOrange,
                  //   value: isSelected,
                  //   onChanged: (bool? newValue) {
                  //     setState(() {
                  //       isSelected = newValue;
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    // width: 250,
                    height: 100,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              // color: ColorManager.mainOrange,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                // color: Colors.black
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  widget.charityItemModel.image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.charityItemModel.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.font15BlackBold,
                                      ),
                                    ),
                                    Text(
                                      'Charity',
                                      style: TextStyles.font11GreyBold,
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(15),
                              Text(
                                '${widget.charityItemModel.value} egp',
                                style: TextStyles.font15BlackRegular,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                ),
                onPressed: () {},
              ),
            ],
          ),
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
