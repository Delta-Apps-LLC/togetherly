import 'package:flutter/material.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/pin_dialog.dart';

class ProfilePerson extends StatelessWidget {
  const ProfilePerson({super.key, required this.person});
  final Person person;

  @override
  Widget build(BuildContext context) {
    Widget getAvatar(Person person) {
      String image = switch (person.icon) {
        ProfileIcon.bear => 'bear',
        ProfileIcon.cat => 'cat',
        ProfileIcon.chicken => 'chicken',
        ProfileIcon.dog => 'dog',
        ProfileIcon.fish => 'fish',
        ProfileIcon.fox => 'fox',
        ProfileIcon.giraffe => 'giraffe',
        ProfileIcon.gorilla => 'gorilla',
        ProfileIcon.koala => 'koala',
        ProfileIcon.panda => 'panda',
        ProfileIcon.rabbit => 'rabbit',
        ProfileIcon.tiger => 'tiger',
      };
      return Image.asset(
        'assets/images/avatars/$image.png',
        width: 60,
      );
    }

    Future<void> buildPinDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) => PinDialog(person: person));
    }

    return InkWell(
      onTap: () => buildPinDialog(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 120,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getAvatar(person),
            Text(
              person.name,
              style: AppTextStyles.brandAccentLarge,
            )
          ],
        ),
      ),
    );
  }
}
