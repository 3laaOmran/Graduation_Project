import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Text('profile'),
        );
      },
    );
  }
}
