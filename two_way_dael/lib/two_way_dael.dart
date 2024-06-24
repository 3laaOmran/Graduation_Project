import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CustomerCubit()
                ..getGovernorates()
                ..getCategories()
                ..getProducts()
                ..getUserData()
                ..getCustomerOrders()
                ..loadCart()
                ..getFavoriteSellers()
                ..getAboutApp()
                ..getNotifiCations()
                ..getHotDealsAndOffers(),
            ),
            BlocProvider(
              create: (context) => SellerCubit()
                ..getCategories()
                ..getNotifiCations()
                ..getSellerData(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: startWidget,
            theme: lightTheme,
            onGenerateRoute: appRouter.generateRoure,
          ),
        ));
  }
}
