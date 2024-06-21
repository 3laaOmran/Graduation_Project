import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/bloc_observer.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/networking/dio_helper.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/two_way_dael.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  String widget;
  bool? onBoarding = CashHelper.getData(key: 'onBoarding');
  token = CashHelper.getData(key: 'token');
  sellerToken = CashHelper.getData(key: 'sellerToken');

  if (onBoarding != null) {
    if (token != null) {
      widget = Routes.homeScreen;
    } else if (sellerToken != null) {
      widget = Routes.sellerHomeScreen;
    } else {
      widget = Routes.chooseAccountTypeScreen;
    }
  } else {
    widget = Routes.onboardingScreen;
  }
  runApp(TwoWayDealApp(
    startWidget: widget,
    appRouter: AppRouter(),
  ));
}
