import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/bloc_observer.dart';
import 'package:two_way_dael/core/networking/remote/dio_helper.dart';
import 'package:two_way_dael/two_way_dael.dart';

import 'core/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(TwoWayDealApp(
    appRouter: AppRouter(),
  ));
}
