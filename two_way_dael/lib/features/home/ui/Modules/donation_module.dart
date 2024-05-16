import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_floating_action_button.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/widgets/show_bottom_sheet.dart';

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
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.grey[300],
                ),
              ),
            ));
      },
    );
  }
}

