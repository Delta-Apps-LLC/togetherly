import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/profile_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final MultiSelectController<Map<String, dynamic>> selectController =
      MultiSelectController();
  bool _loading = false;
  bool _showAvatarError = false;
  bool _isParent = false;
  Map<String, dynamic> _selectedAvatar = {};
  String name = '';
  String pin = '';
  String verifyPin = '';
  final List<ValueItem<Map<String, dynamic>>> _avatarOptions = [
    const ValueItem(
        label: 'Bear',
        value: {'title': 'bear', 'avatar': 'assets/images/avatars/bear.png'}),
    const ValueItem(
        label: 'Cat',
        value: {'title': 'cat', 'avatar': 'assets/images/avatars/cat.png'}),
    const ValueItem(label: 'Chicken', value: {
      'title': 'chicken',
      'avatar': 'assets/images/avatars/chicken.png'
    }),
    const ValueItem(
        label: 'Dog',
        value: {'title': 'dog', 'avatar': 'assets/images/avatars/dog.png'}),
    const ValueItem(
        label: 'Fish',
        value: {'title': 'fish', 'avatar': 'assets/images/avatars/fish.png'}),
    const ValueItem(
        label: 'Fox',
        value: {'title': 'fox', 'avatar': 'assets/images/avatars/fox.png'}),
    const ValueItem(label: 'Giraffe', value: {
      'title': 'giraffe',
      'avatar': 'assets/images/avatars/giraffe.png'
    }),
    const ValueItem(label: 'Gorilla', value: {
      'title': 'gorilla',
      'avatar': 'assets/images/avatars/gorilla.png'
    }),
    const ValueItem(
        label: 'Koala',
        value: {'title': 'koala', 'avatar': 'assets/images/avatars/koala.png'}),
    const ValueItem(
        label: 'Panda',
        value: {'title': 'panda', 'avatar': 'assets/images/avatars/panda.png'}),
    const ValueItem(label: 'Rabbit', value: {
      'title': 'rabbit',
      'avatar': 'assets/images/avatars/rabbit.png'
    }),
    const ValueItem(
        label: 'Tiger',
        value: {'title': 'tiger', 'avatar': 'assets/images/avatars/tiger.png'}),
  ];

  ProfileIcon _parseProfilePic(String pic) => switch (pic) {
        "bear" => ProfileIcon.bear,
        "cat" => ProfileIcon.cat,
        "chicken" => ProfileIcon.chicken,
        "dog" => ProfileIcon.dog,
        "fish" => ProfileIcon.fish,
        "fox" => ProfileIcon.fox,
        "giraffe" => ProfileIcon.giraffe,
        "gorilla" => ProfileIcon.gorilla,
        "koala" => ProfileIcon.koala,
        "panda" => ProfileIcon.panda,
        "rabbit" => ProfileIcon.rabbit,
        "tiger" => ProfileIcon.tiger,
        _ => throw FormatException('Unsupported profile pic "$pic"'),
      };

  void createProfile(PersonProvider personProvider) async {
    final userIdentityProvider =
        Provider.of<UserIdentityProvider>(context, listen: false);
    if (_selectedAvatar.isEmpty) {
      setState(() => _showAvatarError = true);
    } else {
      setState(() => _showAvatarError = false);
    }
    if (_formKey.currentState!.validate() && !_showAvatarError) {
      setState(() => _loading = true);
      final person = _isParent
          ? Parent(
              familyId: userIdentityProvider.familyId!,
              name: name,
              icon: _parseProfilePic(_selectedAvatar['title']),
              pin: pin,
            )
          : Child(
              familyId: userIdentityProvider.familyId!,
              name: name,
              icon: _parseProfilePic(_selectedAvatar['title']),
              pin: pin,
            );
      await personProvider.addPerson(person);
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFamilyEmpty(PersonProvider provider) {
      return provider.parents.isEmpty &&
          provider.children.isEmpty &&
          provider.ready;
    }

    Widget buildDropdown() {
      return SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: MultiSelectDropDown<Map<String, dynamic>>(
            controller: selectController,
            selectionType: SelectionType.single,
            dropdownHeight: 200,
            clearIcon: const Icon(
              Icons.clear,
              color: AppColors.brandBlack,
            ),
            onOptionSelected: (options) {
              setState(() => _selectedAvatar =
                  selectController.selectedOptions.isEmpty
                      ? {}
                      : selectController.selectedOptions.first.value!);
            },
            options: _avatarOptions,
            selectedOptionTextColor: AppColors.brandBlack,
            selectedOptionIcon: const Icon(
              Icons.check,
              color: AppColors.brandGreen,
            ),
          ),
        ),
      );
    }

    Widget buildProfileForm() {
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                initialValue: name,
                onChanged: (value) => setState(() => name = value),
                decoration: const InputDecoration(labelText: 'Enter your name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Enter a PIN:',
                    style: AppTextStyles.brandBody,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      maxLength: 5,
                      obscureText: true,
                      initialValue: pin,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) =>
                          setState(() => pin = value.toString()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must enter a PIN';
                        } else if (value.length != 5) {
                          return 'PIN must be exactly 5 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Verify PIN:',
                    style: AppTextStyles.brandBody,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      maxLength: 5,
                      obscureText: true,
                      initialValue: verifyPin,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) =>
                          setState(() => verifyPin = value.toString()),
                      validator: (value) {
                        if (value != pin) {
                          return 'PIN does not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Choose Your Avatar:',
                    style: AppTextStyles.brandBody,
                  ),
                  buildDropdown(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_showAvatarError)
              Text(
                'You must select an avatar',
                style: AppTextStyles.brandAccentSub
                    .copyWith(color: Theme.of(context).colorScheme.error),
              ),
            if (_selectedAvatar['avatar'] != null)
              CircleAvatar(
                radius: 30,
                child: Image.asset(_selectedAvatar['avatar']),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'I am a parent',
                    style: AppTextStyles.brandBody,
                  ),
                  Checkbox(
                    value: _isParent,
                    activeColor: AppColors.brandGreen,
                    onChanged: (value) => setState(() => _isParent = value!),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.brandBlue,
      ),
      body: Padding(
        padding: AppWidgetStyles.appPadding,
        child: Consumer<PersonProvider>(
          builder: (context, personProvider, child) => Center(
            child: SingleChildScrollView(
              child: !personProvider.ready
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          isFamilyEmpty(personProvider)
                              ? 'Create Your Profile'
                              : 'Choose Your Profile',
                          style:
                              AppTextStyles.brandHeading.copyWith(fontSize: 28),
                        ),
                        isFamilyEmpty(personProvider)
                            ? buildProfileForm()
                            : ProfileList(list: [
                                ...personProvider.parents,
                                ...personProvider.children
                              ]),
                        if (isFamilyEmpty(personProvider))
                          ElevatedButton(
                            onPressed: () => createProfile(personProvider),
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  AppColors.brandGreen),
                              fixedSize: MaterialStatePropertyAll<Size>(
                                  Size.fromWidth(250)),
                              padding:
                                  MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                      EdgeInsets.only(top: 8, bottom: 8)),
                            ),
                            child: _loading
                                ? const CircularProgressIndicator()
                                : Text(
                                    'Create',
                                    style: AppTextStyles.brandHeading
                                        .copyWith(color: AppColors.brandBlack),
                                  ),
                          ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
