import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/providers/family_provider.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _loading = false;
  bool _pinVisible = false;

  @override
  Widget build(BuildContext context) {
    void logout() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final scaffoldProvider =
          Provider.of<ScaffoldProvider>(context, listen: false);
      final userProvider =
          Provider.of<UserIdentityProvider>(context, listen: false);
      setState(() => _loading = true);
      await authProvider.logout();
      userProvider.setPersonId(null);
      setState(() => _loading = false);
      scaffoldProvider.setScaffoldValues(
          index: 0, title: 'Family', type: HomePageType.parent);
    }

    void changeProfile() {
      final userProvider =
          Provider.of<UserIdentityProvider>(context, listen: false);
      userProvider.setPersonId(null);
    }

    Widget getAvatar(Person? person) {
      String? image = switch (person?.icon) {
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
        // TODO: Handle this case.
        null => null,
      };
      return Image.asset(
        'assets/images/avatars/$image.png',
        width: 80,
      );
    }

    String getFamilyName() {
      final familyProvider =
          Provider.of<FamilyProvider>(context, listen: false);
      return familyProvider.familyName ?? '';
    }

    return Consumer<PersonProvider>(
      builder: (context, personProvider, child) => Padding(
        padding: AppWidgetStyles.appPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'My Profile',
                  style: AppTextStyles.brandHeading,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              getAvatar(personProvider.currentPerson),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Name:',
                        style: AppTextStyles.brandAccentLarge,
                      ),
                      Text(
                        personProvider.currentPerson!.name,
                        style: AppTextStyles.brandAccentLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Family:',
                        style: AppTextStyles.brandAccentLarge,
                      ),
                      Text(
                        getFamilyName(),
                        style: AppTextStyles.brandAccentLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PIN:',
                        style: AppTextStyles.brandAccentLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            _pinVisible
                                ? personProvider.currentPerson!.pin
                                : '*****',
                            style: AppTextStyles.brandAccentLarge,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () =>
                                setState(() => _pinVisible = !_pinVisible),
                            icon: Icon(
                                _pinVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.brandBlack,
                                size: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                onPressed: () => changeProfile(),
                icon: const Icon(
                  Icons.account_circle,
                  color: AppColors.brandBlue,
                ),
                label: Text(
                  'Change Profile',
                  style: AppTextStyles.brandAccent
                      .copyWith(color: AppColors.brandBlack),
                ),
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppColors.brandWhite),
                  textStyle:
                      MaterialStatePropertyAll(AppTextStyles.brandAccent),
                  fixedSize:
                      MaterialStatePropertyAll<Size>(Size.fromWidth(200)),
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.only(top: 10, bottom: 10)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                onPressed: () => logout(),
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  'Log Out',
                  style: AppTextStyles.brandAccent
                      .copyWith(color: AppColors.brandBlack),
                ),
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppColors.brandWhite),
                  textStyle:
                      MaterialStatePropertyAll(AppTextStyles.brandAccent),
                  fixedSize:
                      MaterialStatePropertyAll<Size>(Size.fromWidth(200)),
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.only(top: 10, bottom: 10)),
                ),
              ),
              if (_loading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
