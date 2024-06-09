import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_drop_down_list.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_snackbar.dart';
import 'package:two_way_dael/features/seller/auth/signup/logic/cubit/seller_signup_cubit.dart';

class SellerPhotoAndAddressScreen extends StatelessWidget {
  const SellerPhotoAndAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerSignupCubit()..getGovernorates(),
      child: BlocConsumer<SellerSignupCubit, SellerSignupStates>(
        listener: (context, state) {
          if (state is SellerPhotoAndAddressLoadingState) {
            CashHelper.getData(key: 'sellerRegisterToken');
          } else if (state is SellerPhotoAndAddressSuccessState) {
            if (state.photoAndAddressModel.status == 200) {
              showSnackBar(context,
                  message: state.photoAndAddressModel.message!);
              // showToast(
              //     message: state.photoAndAddressModel.message!,
              //     state: TostStates.SUCCESS);
              context.pushNamedAndRemoveUntil(Routes.sellerCirtificates,
                  predicate: (route) => false);
              // CashHelper.saveData(key: 'token', value: registerToken)
              //     .then((value) {
              //   // sellerToken = sellerRegisterToken;
              // });
            }
          } else if (state is SellerPhotoAndAddressErrorState) {
            showSnackBar(context, message: state.error);
            // showToast(message: 'An Error Occurred', state: TostStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SellerSignupCubit.get(context);
          // var model = cubit.governoratesModel;
          return SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main_background.png'),
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: AbsorbPointer(
                        absorbing: state is SellerPhotoAndAddressLoadingState
                            ? true
                            : false,
                        child: Form(
                          key: cubit.photoAndAddressFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(100),
                              // verticalSpace(70),
                              // GestureDetector(
                              //   onTap: () {
                              //     context.pushNamed(Routes.sellerSignupScreen);
                              //   },
                              //   child: Image.asset(
                              //     'assets/images/arrow.png',
                              //     width: 60.w,
                              //   ),
                              // ),
                              // verticalSpace(30),
                              Text(
                                'Step 3',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 30.0),
                              ),
                              Text(
                                'Add more details',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                              ),
                              verticalSpace(40),
                              Text(
                                'Add Your Business Logo',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w100),
                              ),
                              verticalSpace(10),
                              SizedBox(
                                width: 250,
                                height: 180,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 240.0,
                                        height: 170.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: cubit.imagePick == null
                                                ? const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/image_picker_background.png'),
                                                    fit: BoxFit.none)
                                                : DecorationImage(
                                                    image: FileImage(
                                                        cubit.imagePick!)),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(25.0)),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.0)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25.0)),
                                          border: Border.all(
                                              color: ColorManager.mainOrange,
                                              width: 1.0)),
                                      child: CircleAvatar(
                                        radius: 17.0,
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.pickImage();
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            size: 20.0,
                                            color: ColorManager.mainOrange,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Street',
                                    style: TextStyles.font17BlackBold,
                                  ),
                                  verticalSpace(5),
                                  CustomTextFormField(
                                    prefixIcon:
                                        const Icon(Icons.maps_home_work),
                                    isObsecureText: false,
                                    hintText: 'Street',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please, Enter yor street';
                                      }
                                      return null;
                                    },
                                    controller: cubit.streetController,
                                  ),
                                  verticalSpace(20),
                                  CustomDropDownList(
                                    selectedItems:
                                        (List<dynamic> selectedList) {
                                      for (var item in selectedList) {
                                        if (item is SelectedListItem) {
                                          cubit.governorateController.text =
                                              item.name;
                                          cubit.selectedGovernorateId = cubit
                                                  .governoratesList
                                                  .indexOf(item) +
                                              1;
                                          debugPrint('item.name: ${item.name}');
                                          debugPrint(
                                              'gov id: ${cubit.selectedGovernorateId}');

                                          debugPrint(
                                              'widget.dropedList!.indexOf(item): ${cubit.governoratesList.indexOf(item)}');
                                          SellerSignupCubit.get(context)
                                              .getCities(
                                                  cubit.selectedGovernorateId);
                                          cubit.cityController.text = '';
                                          cubit.selectedCityId = null;
                                        }
                                      }
                                    },
                                    validation: (value) {
                                      if (value!.isEmpty) {
                                        return 'Governorate is required';
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(
                                      Icons.location_city_outlined,
                                      color: ColorManager.mainOrange,
                                    ),
                                    dropedList: cubit.governoratesList,
                                    textEditingController:
                                        cubit.governorateController,
                                    title: 'Governorate',
                                    hint: 'Governorate',
                                    isCitySelected: true,
                                  ),
                                  verticalSpace(20),
                                  cubit.selectedCities.isNotEmpty
                                      ? CustomDropDownList(
                                          selectedItems:
                                              (List<dynamic> selectedList) {
                                            for (var item in selectedList) {
                                              if (item is SelectedListItem) {
                                                cubit.cityController.text =
                                                    item.name;
                                                cubit.selectedCityId = cubit
                                                        .selectedCities
                                                        .indexOf(item) +
                                                    1;
                                                debugPrint(
                                                    'item.name: ${item.name}');
                                                debugPrint(
                                                    'city id: ${cubit.selectedCityId}');

                                                debugPrint(
                                                    'widget.dropedList!.indexOf(item): ${cubit.selectedCities.indexOf(item)}');
                                              }
                                            }
                                          },
                                          validation: (value) {
                                            if (value!.isEmpty) {
                                              return 'City is required';
                                            }
                                            return null;
                                          },
                                          prefixIcon: const Icon(
                                            Icons.location_on,
                                            color: ColorManager.mainOrange,
                                          ),
                                          dropedList: cubit.selectedCities,
                                          textEditingController:
                                              cubit.cityController,
                                          title: 'City',
                                          hint: 'City',
                                          isCitySelected: true,
                                        )
                                      : Container(),
                                ],
                              ),
                              verticalSpace(50),
                              state is! SellerPhotoAndAddressLoadingState
                                  ? AppTextButton(
                                      buttonText: 'Next',
                                      textStyle: TextStyles.font17WhiteBold,
                                      onPressed: () {
                                        if (cubit.imagePick == null) {
                                          showSnackBar(context, message: 'Please pick an image for your business logo');
                                          return;
                                        }
                                        if (cubit.photoAndAddressFormKey.currentState!.validate()) {
                                          debugPrint('Selected Governorate ID: ${cubit.selectedGovernorateId}');
                                          debugPrint('Selected City ID: ${cubit.selectedCityId}');
                                          debugPrint('${cubit.imagePick}');
                                          cubit.photoAndAddress(
                                            cityId: cubit.selectedCityId!,
                                            governorateId: cubit.selectedGovernorateId!,
                                            token: sellerRegisterToken!,
                                            image: cubit.imagePick,
                                            street: cubit.streetController.text,
                                          );
                                        }
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorManager.mainOrange,
                                      ),
                                    ),
                              verticalSpace(20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
