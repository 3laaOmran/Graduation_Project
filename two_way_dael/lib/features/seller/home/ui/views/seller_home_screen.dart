import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_no_internet.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SellerCubit.get(context);

    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            extendBody: true,
            body: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return cubit.sellerBottomScreens[cubit.currentIndex];
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsetsDirectional.only(
                  end: 30.0, start: 30, bottom: 20),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 40,
                    offset: const Offset(8, 20),
                  )
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BottomNavigationBar(
                    showUnselectedLabels: false,
                    currentIndex: cubit.currentIndex,
                    selectedItemColor: ColorManager.mainOrange,
                    onTap: (index) {
                      cubit.changeBottomNav(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt_rounded),
                        label: 'Products',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home_filled,
                          size: 35,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          size: 35,
                        ),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
