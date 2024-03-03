import 'package:flutter/material.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/themes.dart';

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

  String prettyDate(String date) {
    List<String> dateTimeArr = date.split(' ');
    List<String> dateArr = dateTimeArr.elementAt(0).split('-');
    return '${dateArr.elementAt(1)}/${dateArr.elementAt(2)}/${dateArr.elementAt(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Chore Details',
          style: AppTextStyles.brandHeading,
        ),
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
                      'Due: ${prettyDate(chore.dueDate.toString())}',
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
                  // if (chore.isBonus)
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
          )
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
