import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/routing/app_router.dart';
import 'package:two_way_dael/core/theming/themes.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';


class TwoWayDealApp extends StatelessWidget {
  final AppRouter appRouter;
  final String startWidget;
  const TwoWayDealApp({super.key, required this.appRouter, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => CustomerCubit()..getUserData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: startWidget,
          theme: lightTheme,
          onGenerateRoute: appRouter.generateRoure,
        ),
      ),
    );
  }
}
