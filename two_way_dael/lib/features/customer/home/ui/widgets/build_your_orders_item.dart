import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';

class BuildYourOrdersItem extends StatelessWidget {
  const BuildYourOrdersItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      child: Container(
        height: 160.0.h,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120.h,
                width: 120.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/pizza.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalSpace(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font17BlackBold,
                  ),
                  // verticalSpace(10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '50000 egp',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font13GreyBold,
                      ),
                      horizontalSpace(20),
                      customIconButton(
                        onPressed: () {
                          showToast(
                            message: 'Delivery completed successfully',
                            state: TostStates.SUCCESS,
                          );
                        },
                        icon: Icons.check,
                        color: Colors.green,
                        size: 30.0,
                        toolTip: 'Done',
                      ),
                    ],
                  ),
                  // customIconButton(
                  //   onPressed: () {
                  //     showToast(
                  //       message: 'The Order has been canceled',
                  //       state: TostStates.ERROR,
                  //     );
                  //   },
                  //   icon: Icons.cancel_outlined,
                  //   color: Colors.red,
                  //   size: 30.0,
                  //   toolTip: 'Canceled',
                  // ),
                  // customIconButton(
                  //   onPressed: () {
                  //     showToast(
                  //       message: 'The order is on the way...',
                  //       state: TostStates.WARNING,
                  //     );
                  //   },
                  //   icon: Icons.watch_later_outlined,
                  //   color: Colors.amber,
                  //   size: 30.0,
                  //   toolTip: 'In Progress',
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
