import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/login.dialog.dart';
import 'package:togetherly/views/widgets/signup_dialog.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {
        'text': 'Login',
        'buttonColor': AppColors.brandBlue,
        'textColor': AppColors.brandGold,
        'dialog': const LoginDialog(),
      },
      {
        'text': 'Signup',
        'buttonColor': AppColors.brandLightGray,
        'textColor': AppColors.brandBlack,
        'dialog': const SignupDialog(),
      },
    ];

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
                'Welcome to Togetherly',
                style: AppTextStyles.brandHeading.copyWith(fontSize: 28),
              ),
              Image.asset('assets/images/logo.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: buttons
                    .map((button) => Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return button['dialog'];
                                  });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  button['buttonColor']),
                              fixedSize: const MaterialStatePropertyAll<Size>(
                                  Size.fromWidth(275)),
                              padding: const MaterialStatePropertyAll<
                                      EdgeInsetsGeometry>(
                                  EdgeInsets.only(top: 10, bottom: 10)),
                            ),
                            child: Text(
                              button['text'],
                              style: AppTextStyles.brandHeading
                                  .copyWith(color: button['textColor']),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () => print('Privacy Policy'),
                      child: Text(
                        'Privacy Policy',
                        style: AppTextStyles.brandBodySmall.copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.brandGray,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () => print('Terms and Conditions'),
                      child: Text(
                        'Terms and Conditions',
                        style: AppTextStyles.brandBodySmall.copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.brandGray,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
