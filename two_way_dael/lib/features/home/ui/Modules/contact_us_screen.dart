import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Contact Us',
          style: TextStyles.font18White,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                width: double.infinity,
                image: AssetImage(
                  'assets/images/contact_us.png',
                ),
              ),
              Text(
                'Get In Touch',
                style: TextStyles.font30blackbold,
              ),
              verticalSpace(10),
              Text(
                'If you have any queries, get in touch with us. We well be happy to help you!',
                style: TextStyles.font18Grey800bold,
              ),
              verticalSpace(20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'First Name',
                      contentPadding: EdgeInsets.zero,
                      isObsecureText: false,
                      validator: (value) {},
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: CustomTextFormField(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'Last Name',
                      isObsecureText: false,
                      validator: (value) {},
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.phone),
                hintText: 'Phone',
                isObsecureText: false,
                validator: (value) {},
              ),
              verticalSpace(20),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.email),
                hintText: 'E-mail',
                isObsecureText: false,
                validator: (value) {},
              ),
              verticalSpace(20),
              CustomTextFormField(
                borderRadius: BorderRadius.circular(10),
                maxLines: 7,
                hintText: 'Message',
                isObsecureText: false,
                validator: (value) {},
              ),
              verticalSpace(20),
              AppTextButton(
                buttonText: 'Send Message',
                textStyle: TextStyles.font17WhiteBold,
                onPressed: () {
                  showToast(
                    message: 'We will answer as soon as possible',
                    state: TostStates.SUCCESS,
                  );
                },
              ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
