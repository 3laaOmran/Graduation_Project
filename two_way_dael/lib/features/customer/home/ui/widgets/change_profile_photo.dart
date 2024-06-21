import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  File? _image;

  Future<void> _pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var model = cubit.userDataModel;
        var profilePicture = model?.data?.profilePicture;
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state is CustomerUpdateImageLoadingState
                    ? const LinearProgressIndicator(
                        color: ColorManager.mainOrange,
                      )
                    : Text(
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
                  width: 290.w,
                  height: 200.0.h,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 280.w,
                          height: 190.0.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  )
                                : profilePicture != null &&
                                        profilePicture !=
                                            'http://2waydeal.online/uploads/default.png'
                                    ? DecorationImage(
                                        image: NetworkImage(profilePicture),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/default_profile.png'),
                                      ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25.0)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
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
                              color: ColorManager.mainOrange,
                              width: 1.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 17.0,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: _pickImage,
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
                  onPressed: () {
                    if (_image != null) {
                      cubit.updateProfileImage(image: _image!);
                    } else {
                      // Handle the case when _image is null
                      print('No image selected.');
                    }
                  },
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
