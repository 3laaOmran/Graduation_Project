// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:two_way_dael/core/theming/colors.dart';
// import 'package:two_way_dael/core/theming/styles.dart';

// class OTPTextField extends StatelessWidget {
//   final bool first;
//   final bool last;
//   final TextEditingController controller;
//   const OTPTextField(
//       {required this.controller,
//       required this.first,
//       required this.last,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorColor: Colors.white,
//       onChanged: ((value) {
//         if (value.isNotEmpty && last == false) {
//           FocusScope.of(context).nextFocus();
//         } else if (value.isEmpty && first == false) {
//           FocusScope.of(context).previousFocus();
//         }
//       }),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Required';
//         }
//         return null;
//       },
//       controller: controller,
//       keyboardType: TextInputType.number,
//       inputFormatters: [LengthLimitingTextInputFormatter(1)],
//       textAlign: TextAlign.center,
//       style: TextStyles.font20Whitebold,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         fillColor: ColorManager.mainOrange,
//         filled: true,
//         constraints: BoxConstraints(
//           maxHeight: 70.h,
//           maxWidth: 75.w,
//         ),
//       ),
//     );
//   }
// }
