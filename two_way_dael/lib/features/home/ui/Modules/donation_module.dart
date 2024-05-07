import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_floating_action_button.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              backgroundColor: ColorManager.mainOrange,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donate Now',
                    style: TextStyles.font18White,
                  ),
                  verticalSpace(10),
                  Text(
                    'Donating has now become easier',
                    style: TextStyles.font12White,
                  ),
                ],
              ),
            ),
            floatingActionButton: floatingactionButton(
              text: 'Donate Now',
              onPressed: () {
                showBottomSheetMethod(context);
              },
            ),
            body: ListView.separated(
              itemCount: cubit.charities.length,
              itemBuilder: (context, index) => ListTile(
                title: cubit.charities[index],
              ),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.5,
                color: Colors.grey[300],
              ),
            ));
      },
    );
  }
}

void showBottomSheetMethod(context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: 500,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(30),
          topEnd: Radius.circular(30),
        ),
      ),
      child: BlocBuilder<CustomerCubit, CustomerStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemCount: CustomerCubit.get(context).charities.length,
              itemBuilder: (context, index) => ListTile(
                title: CustomerCubit.get(context).charities[index],
              ),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.5,
                color: Colors.grey[300],
              ),
            ),
          );
        },
      ),
    ),
  );
}
