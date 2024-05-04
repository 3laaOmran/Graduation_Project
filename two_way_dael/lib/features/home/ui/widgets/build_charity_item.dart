import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';

class CharityItem extends StatelessWidget {
  const CharityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) => Container(
            height: 500,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_box_outline_blank),
                      horizontalSpace(15),
                      SizedBox(
                        width: 250,
                        height: 150,
                        child:  Container(
                          
                          decoration: BoxDecoration(
                            
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/images/default_profile.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      horizontalSpace(15),
                      Icon(Icons.delete_outline)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/default_profile.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Charity Name',
                          style: TextStyles.font17BlackBold,
                        ),
                        Text(
                          'Charity',
                          style: TextStyles.font13GreyBold,
                        ),
                      ],
                    ),
                    horizontalSpace(40),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                    ),
                  ],
                ),
                verticalSpace(15),
                Text(
                  '100 egp',
                  style: TextStyles.font15BlackRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
