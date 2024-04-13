import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';

class FiltersDialog extends StatelessWidget {
  const FiltersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          'Filters',
          style: AppTextStyles.brandHeading,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[],
      ),
    );
  }
}
