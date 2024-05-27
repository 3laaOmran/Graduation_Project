import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String dropDownValue = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: customIconButton(
          toolTip: 'back',
          onPressed: () {
            context.pop();
          },
          icon: Icons.arrow_back,
          color: Colors.white,
        ),
        backgroundColor: ColorManager.mainOrange,
        title: Text(
          'Search....',
          style: TextStyles.font20Whitebold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 6,
                      shadowColor: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                      child: CustomTextFormField(
                        hintText: 'Search...',
                        isObsecureText: false,
                        sufixIcon: Icons.search,
                        keyboardType: TextInputType.name,
                        suffixIconSize: 25,
                        maxLines: 1,
                        validator: (value) {},
                        onFieldSubmitted: (value) {
                          showToast(
                              message: 'Searching...',
                              state: TostStates.others);
                        },
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  Column(
                    children: [
                      Text(
                        'Search For',
                        style: TextStyles.font14BlackBold,
                      ),
                      verticalSpace(5),
                      DropdownButton<String>(
                        menuMaxHeight: 500.h,
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.white,
                        alignment: Alignment.center,
                        value: dropDownValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        underline: Container(
                          height: 2,
                          color: ColorManager.gray,
                        ),
                        isDense: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'All',
                            child: Text('All'),
                          ),
                          DropdownMenuItem(
                            value: 'Food',
                            child: Text('Food'),
                          ),
                          DropdownMenuItem(
                            value: 'Drinks',
                            child: Text('Drinks'),
                          ),
                          DropdownMenuItem(
                            value: 'Pizza',
                            child: Text('Pizza'),
                          ),
                          DropdownMenuItem(
                            value: 'Soup',
                            child: Text('Soup'),
                          ),
                          DropdownMenuItem(
                            value: 'Others',
                            child: Text('Others'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(20),
              const Center(
                child: LinearProgressIndicator(
                  color: ColorManager.mainOrange,
                ),
              ),
              Column(
                children: [
                  verticalSpace(100),
                  const Image(
                    image: AssetImage('assets/images/searching.png'),
                  ),
                ],
              ),
              // GridView.count(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 5,
              //   mainAxisSpacing: 1,
              //   childAspectRatio: 1 / 1.5, //width / height

              //   children: List.generate(
              //       20, (index) => const BuildFavoriteSellerItem()),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
