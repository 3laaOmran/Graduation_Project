import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:animations/animations.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_sliver_appbar.dart';
import 'package:two_way_dael/features/home/ui/widgets/seller_about.dart';
import 'package:two_way_dael/features/home/ui/widgets/seller_products.dart';
import 'package:two_way_dael/features/home/ui/widgets/sliver_appbar_delegate.dart';

class SellerDetailsScreen extends StatefulWidget {
  const SellerDetailsScreen({super.key});

  @override
  State<SellerDetailsScreen> createState() => _SellerDetailsScreenState();
}

Widget currentWidget = const SellerAbout();
bool isAboutSelected = true;

class _SellerDetailsScreenState extends State<SellerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 50.0,
              maxHeight: 50.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: ColorManager.gray,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAboutSelected = true;
                              currentWidget = const SellerAbout();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isAboutSelected
                                  ? ColorManager.mainOrange
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'About',
                                style: isAboutSelected
                                    ? TextStyles.font17WhiteBold
                                    : TextStyles.font17BlackBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1.3,
                        color: ColorManager.gray,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAboutSelected = false;
                              currentWidget = const SellerProducts();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isAboutSelected
                                  ? Colors.white
                                  : ColorManager.mainOrange,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Products',
                                style: isAboutSelected
                                    ? TextStyles.font17BlackBold
                                    : TextStyles.font17WhiteBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 900),
                    transitionBuilder: (Widget child,
                        Animation<double> primaryAnimation,
                        Animation<double> secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                        child: child,
                      );
                    },
                    child: currentWidget,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
