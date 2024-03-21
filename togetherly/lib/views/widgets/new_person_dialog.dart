import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/themes.dart';

class NewPersonDialog extends StatefulWidget {
  const NewPersonDialog({super.key});

  @override
  State<NewPersonDialog> createState() => _NewPersonDialogState();
}

class _NewPersonDialogState extends State<NewPersonDialog> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final MultiSelectController<Map<String, dynamic>> selectController =
      MultiSelectController();
  String _name = '';
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

  void submitPerson(BuildContext context) async {
    if (_selectedAvatar.isEmpty) {
      setState(() => _showAvatarError = true);
    } else {
      setState(() => _showAvatarError = false);
    }
    if (_formKey.currentState!.validate() && !_showAvatarError) {
      print(_name);
      print(_isParent);
      print(_selectedAvatar['title']);
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _loading = false);
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
            const SizedBox(
              height: 10,
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
              ? const CircularProgressIndicator()
              : const Text(
                  'Save',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
