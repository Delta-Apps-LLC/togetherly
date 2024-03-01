import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    super.key
  });

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppWidgetStyles.appPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text('Hello there! This is the Store page.'),
            ),
          ],
        ),
      ),
    );
  }
}
