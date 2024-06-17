import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';


class SellerChangeLogo extends StatefulWidget {
  const SellerChangeLogo({super.key});

  @override
  State<SellerChangeLogo> createState() => _SellerChangeLogoState();
}

class _SellerChangeLogoState extends State<SellerChangeLogo> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        var model = cubit.sellerDataModel;
        var image = model!.data!.image;
        var healthCertificate =
            model.data!.certificates!.healthApprovalCertificate!;
        var commercialLicense =
            model.data!.certificates!.commercialResturantLicense!;
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'More About Your Business',
                  style: TextStyles.font20blackbold,
                ),
                verticalSpace(30),
                Text(
                  'Business Logo',
                  style: TextStyles.font15BlackRegular,
                ),
                verticalSpace(15),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image:
                          image != 'http://2waydeal.online/uploads/default.png'
                              ? DecorationImage(image: NetworkImage(image!))
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
                verticalSpace(40),
                Text(
                  'Health Certificate',
                  style: TextStyles.font15BlackRegular,
                ),
                verticalSpace(15),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: healthCertificate !=
                              'http://2waydeal.online/uploads'
                          ? DecorationImage(
                              image: NetworkImage(healthCertificate))
                          : const DecorationImage(
                              image: AssetImage(
                                  'assets/images/image_picker_background.png')),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                verticalSpace(40),
                Text(
                  'Commercial License',
                  style: TextStyles.font15BlackRegular,
                ),
                verticalSpace(15),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: commercialLicense !=
                              'http://2waydeal.online/uploads'
                          ? DecorationImage(
                              image: NetworkImage(commercialLicense))
                          : const DecorationImage(
                              image: AssetImage(
                                  'assets/images/image_picker_background.png')),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
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
