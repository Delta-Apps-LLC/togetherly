import 'package:flutter/material.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/date.dart';
import 'package:togetherly/views/widgets/new_chore_dialog.dart';

class ChoreDetailsDialog extends StatelessWidget {
  const ChoreDetailsDialog({super.key, required this.chore});
  final Chore chore;

  Widget buildTextBox(BuildContext context, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.brandLightGray,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.brandBody,
            ),
            Text(
              description,
              style: AppTextStyles.brandBodySmall
                  .copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconText(IconData icon, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          icon,
          color: AppColors.brandGold,
          size: 24,
        ),
        Text(
          title,
          style: AppTextStyles.brandAccentLarge,
        ),
      ],
    );
  }

  Future<void> buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewChoreDialog(chore: chore);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isParent = true;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.edit,
              color: Colors.transparent,
            ),
          ),
          const Text(
            'Chore Details',
            style: AppTextStyles.brandHeading,
          ),
          IconButton(
            onPressed: isParent ? () => buildDialog(context) : null,
            icon: Icon(
              Icons.edit,
              color: isParent ? AppColors.brandBlack : Colors.transparent,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildTextBox(
            context,
            chore.title,
            chore.description,
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Due: ${chore.dueDate.prettyDate()}',
                      style: AppTextStyles.brandBody,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Does not repeat',
                      style: AppTextStyles.brandBody,
                    ),
                  ),
                  if (chore.isShared)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'With: Natalie',
                        style: AppTextStyles.brandBody,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // if (true) // TODO: chore.isBonus
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 8.0),
                  //     child: buildIconText(Icons.star, 'Bonus'),
                  //   ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: buildIconText(Icons.bolt, chore.points.toString()),
                  ),
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Assigned: Emma, Jacob, Natalie, Robert, Kenneth, Jocelyn, Maria',
              style: AppTextStyles.brandBody,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Close',
            style: AppTextStyles.brandAccent,
          ),
        ),
      ],
    );
  }
}
