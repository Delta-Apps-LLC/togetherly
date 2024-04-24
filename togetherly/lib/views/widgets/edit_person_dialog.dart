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

class EditPersonDialog extends StatefulWidget {
  const EditPersonDialog({super.key, this.person});
  final Person? person;

  @override
  State<EditPersonDialog> createState() => _EditPersonDialogState();
}

class _EditPersonDialogState extends State<EditPersonDialog> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final MultiSelectController<Map<String, dynamic>> selectController =
      MultiSelectController();
  String _name = '';
  String _pin = '';
  String _verifyPin = '';
  bool _isParent = false;
  bool _showAvatarError = false;
  Map<String, dynamic> _selectedAvatar = {};

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

  void submitPerson(BuildContext context) async {
    if (_selectedAvatar.isEmpty) {
      setState(() => _showAvatarError = true);
    } else {
      setState(() => _showAvatarError = false);
      if (_formKey.currentState!.validate()) {
        final personProvider =
            Provider.of<PersonProvider>(context, listen: false);
        final userProvider =
            Provider.of<UserIdentityProvider>(context, listen: false);
        final newPerson = _isParent
            ? Parent(
                familyId: userProvider.familyId!,
                pin: _pin,
                name: _name,
                icon: _parseProfilePic(_selectedAvatar['title']))
            : Child(
                familyId: userProvider.familyId!,
                pin: _pin,
                name: _name,
                icon: _parseProfilePic(_selectedAvatar['title']),
                totalPoints: 0);
        setState(() => _loading = true);
        await personProvider.addPerson(newPerson);
        setState(() => _loading = false);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

    Widget buildForm(BuildContext context) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First name',
              ),
              onChanged: (value) => setState(() => _name = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              maxLength: 5,
              obscureText: true,
              initialValue: _pin,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'PIN',
              ),
              onChanged: (value) => setState(() => _pin = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a PIN';
                } else if (value.length != 5) {
                  return 'PIN must be exactly 5 digits';
                }
                return null;
              },
            ),
            TextFormField(
              maxLength: 5,
              obscureText: true,
              initialValue: _verifyPin,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Verify PIN',
              ),
              onChanged: (value) => setState(() => _verifyPin = value),
              validator: (value) {
                if (value != _pin) {
                  return 'PIN does not match';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This person is a parent',
                  style: AppTextStyles.brandBody,
                ),
                Checkbox(
                  value: _isParent,
                  activeColor: AppColors.brandGreen,
                  onChanged: (value) => setState(() => _isParent = value!),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Avatar:',
                  style: AppTextStyles.brandBody,
                ),
                buildDropdown(),
              ],
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
          ],
        ),
      );
    }

    return AlertDialog(
      scrollable: true,
      title: const Center(
        child: Text(
          'New Person',
          style: AppTextStyles.brandHeading,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildForm(context),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: AppTextStyles.brandAccent,
          ),
        ),
        ElevatedButton(
          style: AppWidgetStyles.submitButton,
          onPressed: () => submitPerson(context),
          child: _loading
              ? const CircularProgressIndicator(
                  color: AppColors.brandPurple,
                )
              : const Text(
                  'Save',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
