import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/home/data/models/order_details_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderDetailsModel});

  final OrderDetailsModel orderDetailsModel;

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
        throw const FormatException(
            "Color string must start with '0x' or '0X'.");
      }
    }

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
        title: Text(
          'Order Details',
          style: TextStyles.font18White,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${orderDetailsModel.data!.id}',
                        style: TextStyles.font15BlackBold),
                    verticalSpace(8),
                    Text('Order From: ${orderDetailsModel.data!.orderedFrom}',
                        style: TextStyles.font15BlackBold),
                    verticalSpace(8),
                    Text(
                        'Total price:  ${orderDetailsModel.data!.totalPrice} egp',
                        style: TextStyles.font15BlackBold),
                    verticalSpace(8),
                    Text(
                        'Shipping Price:  ${orderDetailsModel.data!.shippingPrice} egp',
                        style: TextStyles.font15BlackBold),
                    verticalSpace(8),
                    Text('Total Paid:  ${orderDetailsModel.data!.netPrice} egp',
                        style: TextStyles.font15BlackBold),
                  ],
                ),
              ),
            ),
            verticalSpace(20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Status:',
                            style: TextStyles.font17BlackBold),
                        verticalSpace(4),
                        Text(orderDetailsModel.data!.status!,
                            style: TextStyles.font15BlackBold),
                      ],
                    ),
                    const Spacer(),
                    Icon(getIconData(orderDetailsModel.data!.icon!),
                        color:
                            stringToColor(orderDetailsModel.data!.iconColor!),
                        size: 30),
                  ],
                ),
              ),
            ),
            verticalSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Products:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                verticalSpace(8),
                const ProductItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Product 1',
                  quantity: 2,
                  price: 30.0,
                ),
                const ProductItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Product 2',
                  quantity: 1,
                  price: 60.0,
                ),
              ],
            ),
            // const ProductList(),
            verticalSpace(20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery Address:',
                        style: TextStyles.font17BlackBold),
                    verticalSpace(8),
                    Text(orderDetailsModel.data!.address!,
                        style: TextStyles.font15BlackBold),
                    verticalSpace(16),
                    Text('Payment Method:', style: TextStyles.font17BlackBold),
                    verticalSpace(8),
                    Text(orderDetailsModel.data!.paymentMethod!,
                        style: TextStyles.font15BlackBold),
                  ],
                ),
              ),
            ),
            verticalSpace(20),
            AppTextButton(
              buttonText: 'Cancel Order',
              onPressed: () {
                context.pop();
              },
              textStyle: TextStyles.font17WhiteBold,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int quantity;
  final double price;

  const ProductItem(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(imageUrl, width: 50, height: 50),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyles.font17BlackBold),
                  verticalSpace(4),
                  Text('Quantity: $quantity',
                      style: TextStyles.font15BlackBold),
                ],
              ),
            ),
            Text('${price.toStringAsFixed(2)} egp',
                style: TextStyles.font15BlackBold),
          ],
        ),
      ),
    );
  }
}
