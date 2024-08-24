import 'package:flutter/material.dart';
import 'package:yuppo_chat_app/constants/color_constants.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.name,
    required this.isByMe,
    required this.isPreviousBySameUser,
  });
  final String name;
  final bool isByMe;
  final bool isPreviousBySameUser;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isPreviousBySameUser
          ? Colors.transparent
          : isByMe
              ? ColorConstants.primaryColor
              : ColorConstants.greyColor,
      child: Text(
        getAvatarText(),
        style: TextStyle(
            color: isPreviousBySameUser
                ? Colors.transparent
                : isByMe
                    ? Colors.white
                    : Colors.black),
      ),
    );
  }

  String getAvatarText() {
    final splittedName = name.split(' ');
    String avatarName = '';

    for (final split in splittedName) {
      avatarName += split.substring(0, 1);
    }

    return avatarName.toUpperCase();
  }
}
