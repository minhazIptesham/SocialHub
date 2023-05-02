import 'package:flutter/material.dart';
import 'package:social_hub/res/color.dart';

class ProfileList extends StatelessWidget {
  final String title, value;
  final Icon iconData;
  const ProfileList({Key? key,
    required this.title,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title,style: Theme.of(context).textTheme.titleMedium,),
          leading: iconData,
          trailing: Text(value,style: Theme.of(context).textTheme.titleMedium,),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(.5),
        ),
      ],
    );
  }
}
