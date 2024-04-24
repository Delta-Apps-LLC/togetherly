import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/edit_person_dialog.dart';

class FamilyChildItem extends StatefulWidget {
  const FamilyChildItem({super.key, required this.child});
  final Child child;

  @override
  State<FamilyChildItem> createState() => _FamilyChildItemState();
}

class _FamilyChildItemState extends State<FamilyChildItem> {
  bool _loading = false;

  Widget getAvatar(Child child) {
    String image = switch (child.icon) {
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
      width: 50,
    );
  }

  Future<void> deleteParent() async {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    setState(() => _loading = true);
    await personProvider.deletePerson(widget.child);
    setState(() => _loading = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScaffoldProvider>(context, listen: false);

    Future<void> buildPersonDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return const EditPersonDialog();
          return AlertDialog(
            title: const Text(
              'Person Details',
              style: AppTextStyles.brandHeading,
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Close',
                  style: AppTextStyles.brandAccent,
                ),
              ),
              ElevatedButton(
                style: AppWidgetStyles.submitButton.copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.error)),
                onPressed: () => deleteParent(),
                child: _loading
                    ? const CircularProgressIndicator(
                        color: AppColors.brandPurple,
                      )
                    : const Text(
                        'Delete',
                        style: AppTextStyles.brandAccent,
                      ),
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        provider.setScaffoldValues(
            index: null,
            title: widget.child.name,
            type: HomePageType.child,
            childBeingViewed: widget.child);
      },
      onLongPress: () => buildPersonDialog(context),
      child: Container(
        height: 65,
        margin: const EdgeInsets.only(top: 8),
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.brandLightGray,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    getAvatar(widget.child),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.child.name,
                      style:
                          AppTextStyles.brandBodyLarge.copyWith(fontSize: 22),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.bolt,
                      size: 35,
                      color: AppColors.brandGold,
                    ),
                    Text(
                      widget.child.totalPoints.toString(),
                      style:
                          AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 35,
                      color: AppColors.brandBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
