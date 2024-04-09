import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/family_provider.dart';
import 'package:togetherly/themes.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final _formKey = GlobalKey<FormState>();
  String _familyName = '';
  bool _loading = false;

  void createFamily() async {
    final provider = Provider.of<FamilyProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      await provider.createFamily(_familyName);
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.brandBlue,
      ),
      body: Padding(
        padding: AppWidgetStyles.appPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Create your Family Group',
                style: AppTextStyles.brandHeading.copyWith(fontSize: 28),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: _familyName,
                    onChanged: (value) => setState(() => _familyName = value),
                    decoration: const InputDecoration(
                      labelText: 'Family Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your family name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => createFamily(),
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppColors.brandGreen),
                  fixedSize:
                      MaterialStatePropertyAll<Size>(Size.fromWidth(250)),
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.only(top: 8, bottom: 8)),
                ),
                child: _loading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Continue',
                        style: AppTextStyles.brandHeading
                            .copyWith(color: AppColors.brandBlack),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
