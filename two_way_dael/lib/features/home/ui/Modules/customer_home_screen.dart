import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/components.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/home/data/models/products_model.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
            top: 20.0,
            end: 20.0,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 7.0,
                  child: Container(
                    color: Colors.white,
                    width: 344.0,
                    height: 49.0,
                    child: CustomTextFormField(
                      borderRadius: BorderRadius.circular(15.0),
                      controller: controller,
                      keyboardType: TextInputType.text,
                      sufixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                      hintText: 'Search...',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      },
                    ),
                    //
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  'News & Offers',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 21.0),
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
                        // fit: BoxFit.cover,
                      ),
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-psd/delicious-food-facebook-template_23-2150056445.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                        // fit: BoxFit.cover,
                      ),
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/flat-food-landing-page-template_23-2149046596.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                        // fit: BoxFit.cover,
                      ),
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/online-grocery-store-banner-design_23-2150085726.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                        // fit: BoxFit.cover,
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
                      autoPlayAnimationDuration: const Duration(seconds: 1),
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
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 21.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      Container(
                        width: 53.0,
                        height: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: ColorManager.mainOrange, width: 0.5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Text(
                            'Food',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 9.0,
                                  color: ColorManager.mainOrange,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 53.0,
                        height: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: ColorManager.mainOrange, width: 0.5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Text(
                            'Drink',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 9.0,
                                  color: ColorManager.mainOrange,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 53.0,
                        height: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: ColorManager.mainOrange, width: 0.5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Text(
                            'Soup',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 9.0,
                                  color: ColorManager.mainOrange,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 53.0,
                        height: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: ColorManager.mainOrange, width: 0.5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Text(
                            'Pizza',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 9.0,
                                  color: ColorManager.mainOrange,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 53.0,
                        height: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: ColorManager.mainOrange, width: 0.5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Text(
                            'Burger',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 9.0,
                                  color: ColorManager.mainOrange,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 53.0,
                        height: 23.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: ColorManager.mainOrange, width: 0.5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Text(
                            'Soda',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 9.0,
                                  color: ColorManager.mainOrange,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
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
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 21.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 200.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final productsModel =
                          CustomerCubit.get(context).productsModel;
                      if (productsModel != null &&
                          productsModel.message != null &&
                          index < productsModel.message!.length) {
                        return buildItem(
                            context, productsModel.message?[index]);
                      } else {
                        return const CircularProgressIndicator(); // or any other fallback widget
                      }
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10.0),
                    itemCount: CustomerCubit.get(context)
                            .productsModel
                            ?.message
                            ?.length ??
                        0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(context, Message? model) => InkWell(
        onTap: () {
          context.FoodDetails();
        },
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              elevation: 10.0,
              child: Container(
                width: 147.0,
                height: 159.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: SizedBox(
                          height: 79.0,
                          width: 130.0,
                          child: Image(
                            image: NetworkImage('${model?.imagePath}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        '${model?.name}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                            fontSize: 15.0),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${model?.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                      fontSize: 13.0),
                            ),
                            Text(
                              'egp',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                      fontSize: 7.0),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 13.0,
                              backgroundColor: ColorManager.mainOrange,
                              child: IconButton(
                                padding: const EdgeInsetsDirectional.only(
                                    end: 2.0, start: 4.0),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

// ListView.separated(
// scrollDirection: Axis.horizontal,
// physics: const BouncingScrollPhysics(),
// itemBuilder: (context, index) => buildItem(context, CustomerCubit.get(context).productsModel?.message?[index]),
// separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
// itemCount: CustomerCubit.get(context).productsModel!.message!.length,
// ),
