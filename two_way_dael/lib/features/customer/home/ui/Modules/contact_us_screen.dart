import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final Uri facebookUrl =
      Uri.parse('https://www.facebook.com/profile.php?id=100018078196215');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is ContactUsSuccessState) {
          showToast(
              message: state.contactUsModel.message!,
              state: TostStates.SUCCESS);
          messageController.clear();
          titleController.clear();
        }
      },
      builder: (context, state) {
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
              ),
            ),
            backgroundColor: ColorManager.mainOrange,
            title: Text(
              'Contact Us',
              style: TextStyles.font18White,
            ),
          ),
          body: Container(
            height: double.infinity,
            padding: const EdgeInsetsDirectional.only(
                end: 20.0, start: 20.0, top: 30.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/main_background.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get In Touch',
                    style: TextStyles.font30blackbold,
                  ),
                  verticalSpace(10),
                  Text(
                    'If you have any queries, get in touch with us. We will be happy to help you!',
                    style: TextStyles.font18Grey800bold,
                  ),
                  verticalSpace(20),
                  Form(
                    key: emailFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.title_outlined),
                          hintText: 'Subject',
                          controller: titleController,
                          isObsecureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Subject';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        CustomTextFormField(
                          borderRadius: BorderRadius.circular(10),
                          maxLines: 7,
                          hintText: 'Message',
                          controller: messageController,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.message),
                          isObsecureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Message';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  AppTextButton(
                    buttonText: 'Send Message',
                    textStyle: TextStyles.font17WhiteBold,
                    onPressed: () {
                      if (emailFormKey.currentState!.validate()) {
                        CustomerCubit.get(context).contactUs(
                            subject: titleController.text,
                            message: messageController.text);
                      }
                    },
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Text(
                        'Or you can contact us by ',
                        style: TextStyles.font15BlackBold,
                      ),
                      GestureDetector(
                        onTap: _sendEmail,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: ColorManager.mainOrange,
                            ),
                            Text(
                              'email...',
                              style: TextStyles.font15BlackBold.copyWith(
                                color: ColorManager.mainOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Column(
                    children: [
                      Text(
                        'Follow Us To See Hot Offers And New Features',
                        style: TextStyles.font15BlackBold,
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildSocialMediaItem(
                            onTap: launchFacebook,
                            image: 'assets/images/facebook.png',
                          ),
                          buildSocialMediaItem(
                            onTap: launchFacebook,
                            image: 'assets/images/linkedin.png',
                          ),
                          buildSocialMediaItem(
                            onTap: launchFacebook,
                            image: 'assets/images/X.png',
                          ),
                          buildSocialMediaItem(
                            onTap: launchFacebook,
                            image: 'assets/images/instagram.png',
                          ),
                        ],
                      ),
                      verticalSpace(20),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void launchFacebook() async {
    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl);
    } else {
      debugPrint('Could not launch $facebookUrl');
    }
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'alaaomran1102002@gmail.com',
      queryParameters: {
        'subject': '',
        'body': '',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('Could not launch $emailUri');
    }
  }
}

Widget buildSocialMediaItem({required String image, Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Image.asset(
      image,
      width: 25,
    ),
  );
}
