import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_no_internet.dart';

class CustomerLayoutScreen extends StatelessWidget {
  const CustomerLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CustomerCubit.get(context);

    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return cubit.bottomScreens[cubit.currentIndex];
              } else {
                return buildNoInternetWidget();
              }
            },
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorManager.mainOrange,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsetsDirectional.only(
                end: 20, start: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 30,
                  offset: const Offset(8, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                selectedItemColor: ColorManager.mainOrange,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 35,
                    ),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                      size: 30,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                    ),
                    label: 'Favorite',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


