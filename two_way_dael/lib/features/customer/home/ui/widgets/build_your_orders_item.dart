import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/customer/home/data/models/orders_model.dart';

class BuildYourOrdersItem extends StatelessWidget {
  const BuildYourOrdersItem({super.key, required this.order});
  final Orders order;
  @override
  Widget build(BuildContext context) {
    Map<String, IconData> iconMapping = {
      'Icons.pending': Icons.pending,
      'Icons.payments': Icons.payments,
      'Icons.highlight_off': Icons.highlight_off,
      'Icons.check': Icons.check,
      'Icons.error_outline': Icons.error_outline,
    };
    IconData getIconData(String iconString) {
      return iconMapping[iconString] ??
          Icons.help; // default to help icon if not found
    }

      Color stringToColor(String colorString) {
    if (colorString.startsWith('0x') || colorString.startsWith('0X')) {
      return Color(int.parse(colorString));
    } else {
      throw FormatException("Color string must start with '0x' or '0X'.");
    }
  }


    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // horizontalSpace(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Total paid: ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font17BlackBold),
                      Text('${order.netPrice}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font17MainOrangeBold),
                    ],
                  ),
                  verticalSpace(5),
                  Text(
                    'Status:  ${order.status}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font13GreyBold,
                  ),
                ],
              ),
              const Spacer(),
              //  horizontalSpace(10),

              Column(
                children: [
                  Icon(
                    // Icons.check_circle,
                    getIconData(order.icon!),
                    color: stringToColor(order.iconColor!),
                    size: 25.0,
                  ),
                  verticalSpace(5),
                  Text(
                    '${order.orderedFrom}',
                    style: TextStyles.font13GreyBold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
