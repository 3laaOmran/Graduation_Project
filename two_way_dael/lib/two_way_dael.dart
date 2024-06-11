import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/routing/app_router.dart';
import 'package:two_way_dael/core/theming/themes.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class TwoWayDealApp extends StatelessWidget {
  final AppRouter appRouter;
  final String startWidget;
  const TwoWayDealApp(
      {super.key, required this.appRouter, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: token != null
          ? BlocProvider(
              create: (context) => CustomerCubit()
                ..getGovernorates()
                ..getCategories()
                ..getProducts()
                ..getUserData(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: startWidget,
                theme: lightTheme,
                onGenerateRoute: appRouter.generateRoure,
              ),
            )
          : sellerToken != null
              ? BlocProvider(
                  create: (context) => SellerCubit(),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: startWidget,
                    theme: lightTheme,
                    onGenerateRoute: appRouter.generateRoure,
                  ),
                )
              : null,
    );
  }
}
