import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/features/seller/home/ui/views/add_product.dart';
import 'package:two_way_dael/features/seller/home/ui/views/mian_seller_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/profile_seller_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/const.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/notification_widget.dart';
import '../../../../../core/theming/colors.dart';
import 'seller_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //int index = 0;
  int _selectedIndex = 0;
  Color iconColor = ColorManager.mainOrange;
  Color backgroundIconColor = Colors.white;

  List<Widget> pages = [
    const SellerProductsScreen(),
    const SecondScreen(),
    const ProfileSellerScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _selectedIndex == 0
            ? Colors.white //ColorManager.mainOrange
            : _selectedIndex == 2
                ? mixedColor
                : Colors.white,
        flexibleSpace: _selectedIndex == 0
            ? FlexibleSpaceBar(
                background: Image.asset(
                  images["backgroundimage"]!,
                  fit: BoxFit.cover,
                ),
              )
            : Container(),
        actions: [
          notificationButton(_selectedIndex),
        ],
      ),
      body: pages[_selectedIndex],
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30.w, right: 5.w), //.sp  .h    .w
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProduct()));
              },
              heroTag: "addproductTag",
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w, right: 5.w), //.sp  .h    .w
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    heroTag: "logoTag",
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    onPressed: () {
                      // Make Action
                      setState(() {}); //statfull
                      _selectedIndex = 0;
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(images["logo"]!)),
                  ),
                  FloatingActionButton(
                    heroTag: "hometag",
                    backgroundColor:
                        _selectedIndex == 1 ? iconColor : backgroundIconColor,
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Icon(Icons.home_outlined,
                        color: _selectedIndex == 1
                            ? backgroundIconColor
                            : iconColor),
                  ),
                  FloatingActionButton(
                    heroTag: "personTag",
                    backgroundColor:
                        _selectedIndex == 2 ? iconColor : backgroundIconColor,
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() {});
                      _selectedIndex = 2;
                    },
                    child: Icon(Icons.person,
                        color: _selectedIndex == 2
                            ? backgroundIconColor
                            : iconColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
