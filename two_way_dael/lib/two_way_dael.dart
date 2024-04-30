import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/routing/app_router.dart';
import 'package:two_way_dael/core/theming/themes.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';

import 'core/routing/routes.dart';

class TwoWayDealApp extends StatelessWidget {
  final AppRouter appRouter;
  const TwoWayDealApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => CustomerCubit()..getProducts(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.onboardingScreen,
          theme: lightTheme,
          // ThemeData(
            // fontFamily: "Comfortaa",
            // scaffoldBackgroundColor: Colors.white,
            // inputDecorationTheme: InputDecorationTheme(
            //   focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(
            //       color: ColorManager.mainOrange,
            //     ),
            //   ),
            // )
          // ),
          onGenerateRoute: appRouter.generateRoure,
        ),
      ),
    );
  }
}
