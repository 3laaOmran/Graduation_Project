import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
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
        padding: const EdgeInsetsDirectional.only(end: 20.0,start: 20.0,top: 30.0),
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
                      hintText: 'Title',
                      controller: titleController,
                      isObsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email title';
                        }
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
                          return 'Please enter email message';
                        }
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              AppTextButton(
                buttonText: 'Send Email',
                textStyle: TextStyles.font17WhiteBold,
                onPressed: _sendEmail,
              ),
              verticalSpace(20),
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
  }

  void launchFacebook() async {
    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl);
    } else {
      debugPrint('Could not launch $facebookUrl');
    }
  }

  void _sendEmail() async {
    if (emailFormKey.currentState!.validate()) {
      final Email email = Email(
        recipients: ['alaaomran1102002@gmail.com'],
        subject: titleController.text,
        body: messageController.text,
      );

      try {
        await FlutterEmailSender.send(email);
        debugPrint('Email sent successfully!');
      } on Exception catch (error) {
        debugPrint('Error sending email: $error');
      }
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
