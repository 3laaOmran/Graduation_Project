import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

import '../../../../../core/widgets/custom_button.dart';

class ChangeProfilePhoto extends StatefulWidget {
  const ChangeProfilePhoto({super.key});

  @override
  State<ChangeProfilePhoto> createState() => _ChangeProfilePhotoState();
}

class _ChangeProfilePhotoState extends State<ChangeProfilePhoto> {
  File? imagePick;
  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imagePick = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var model = cubit.userDataModel;
        var image = model!.data!.profilePicture;
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Profile Photo',
                  style: TextStyles.font20blackbold,
                ),
                verticalSpace(30),
                Text(
                  'Add Photo',
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
                                  : image != 'http://2waydeal.online/uploads/default.png'
                                      ? DecorationImage(
                                          image: NetworkImage(image!))
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
