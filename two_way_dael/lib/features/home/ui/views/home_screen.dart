import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

class CustomerLayoutScreen extends StatelessWidget {
  const CustomerLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CustomerCubit.get(context);

    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
              bottom: 20.0,
              end: 20.0,
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              child: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                selectedItemColor: ColorManager.mainOrange,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: 'Profile',
                  ),
                ],
                elevation: 0.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
