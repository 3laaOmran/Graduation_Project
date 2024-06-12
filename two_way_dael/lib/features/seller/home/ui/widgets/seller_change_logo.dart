import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

import '../../../../../core/widgets/custom_button.dart';

class SellerChangeLogo extends StatefulWidget {
  const SellerChangeLogo({super.key});

  @override
  State<SellerChangeLogo> createState() => _SellerChangeLogoState();
}

class _SellerChangeLogoState extends State<SellerChangeLogo> {
  File? imagePick;
  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imagePick = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        var model = cubit.sellerDataModel;
        var image = model!.data!.image;
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Your Business Logo',
                  style: TextStyles.font20blackbold,
                ),
                verticalSpace(30),
                Text(
                  'Add Logo',
                  style: TextStyles.font15BlackRegular,
                ),
                verticalSpace(15),
                SizedBox(
                  width: 260,
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 250.0,
                          height: 170.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: imagePick != null
                                  ? DecorationImage(
                                      image: FileImage(imagePick!),
                                      fit: BoxFit.cover,
                                    )
                                  : image != null
                                      ? DecorationImage(
                                          image: NetworkImage(image))
                                      : const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/default_profile.png')),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25.0)),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              )),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25.0)),
                              border: Border.all(
                                  color: ColorManager.mainOrange, width: 1.0)),
                          child: CircleAvatar(
                            radius: 17.0,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                pickImage();
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 20.0,
                                color: ColorManager.mainOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(40),
                AppTextButton(
                  buttonText: 'Save',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {},
                ),
                verticalSpace(150),
              ],
            ),
          ),
        );
      },
    );
  }
}
