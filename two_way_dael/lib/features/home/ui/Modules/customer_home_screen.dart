import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_ctegory_item.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_food_item.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        // var model = cubit.userModel;
        // cubit.nameController.text = model!.data!.name!;
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                  // top: 20.0,
                  end: 20.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(75),
                      Material(
                        elevation: 6,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(25),
                        child: CustomTextFormField(
                          hintText: 'Search...',
                          isObsecureText: false,
                          sufixIcon: Icons.search,
                          suffixIconSize: 25,
                          validator: (value) {},
                        ),
                      ),
                      verticalSpace(25),
                      Text(
                        'News & Offers',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 21.0),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CarouselSlider(
                          items: const [
                            Image(
                              image: NetworkImage(
                                'https://img.freepik.com/free-psd/japanese-food-restaurant-horizontal-banner-template_23-2149447411.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais',
                              ),
                            ),
                            Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-psd/delicious-food-facebook-template_23-2150056445.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                            ),
                            Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-vector/flat-food-landing-page-template_23-2149046596.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                            ),
                            Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-vector/online-grocery-store-banner-design_23-2150085726.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                            ),
                          ],
                          options: CarouselOptions(
                            height: 200.0,
                            initialPage: 0,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: false,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            reverse: false,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Categories',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 21.0),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              BuildCategoryItem(text: 'Food'),
                              SizedBox(
                                width: 10.0,
                              ),
                              BuildCategoryItem(text: 'Drink'),
                              SizedBox(
                                width: 10.0,
                              ),
                              BuildCategoryItem(text: 'Soup'),
                              SizedBox(
                                width: 10.0,
                              ),
                              BuildCategoryItem(text: 'Pizza'),
                              SizedBox(
                                width: 10.0,
                              ),
                              BuildCategoryItem(text: 'Burger'),
                              SizedBox(
                                width: 10.0,
                              ),
                              BuildCategoryItem(text: 'Soda'),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Meals you might like',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 21.0),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1 / 1.35, //width / height

                        children:
                            List.generate(20, (index) => buildItem(context)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.changeBottomNav(cubit.currentIndex + 1);
                        if (cubit.currentIndex != 1) {
                          cubit.currentIndex = 0;
                        }
                      },
                      child: const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.white,
                        child: Image(
                          image: AssetImage(
                            'assets/images/two_way_deal_icon.png',
                          ),
                          width: 40,
                        ),
                      ),
                    ),
                    horizontalSpace(10),
                    GestureDetector(
                      onTap: () {
                        cubit.changeBottomNav(cubit.currentIndex + 1);
                        if (cubit.currentIndex != 1) {
                          cubit.currentIndex = 0;
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Two Way Deal',
                            // 'Hello, ${CustomerCubit.get(context).nameController.text}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                          ),
                          Text(
                            'Shopping Time?',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container());
                        },
                        child: const Image(
                          image: AssetImage('assets/images/moved_cart.gif'),
                          width: 35,
                        ),
                      ),
                    ),
                    // customIconButton(
                    //   onPressed: () {},
                    //   icon: Icons.shopping_cart_outlined,
                    //   color: ColorManager.mainOrange,
                    //   size: 30,
                    // ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        customIconButton(
                          onPressed: () {
                            context.pushNamed(Routes.notificationsScreen);
                          },
                          icon: Icons.notifications,
                          toolTip: 'Notifications',
                          size: 30.0,
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            top: 11.0,
                            end: 14.0,
                          ),
                          child: const CircleAvatar(
                            radius: 3.5,
                            backgroundColor: ColorManager.mainOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
