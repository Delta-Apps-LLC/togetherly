import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/date.dart';

class NewChoreDialog extends StatefulWidget {
  const NewChoreDialog({super.key, this.assignedChildId});
  final int? assignedChildId;

  @override
  State<NewChoreDialog> createState() => _NewChoreDialogState();
}

class _NewChoreDialogState extends State<NewChoreDialog> {
  static const List<String> _weekdayAbbreviations = ['S', 'M', 'T', 'W', 'Th', 'F', 'Sa'];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pointsController = TextEditingController();

  DateTime _dueDate = DateTime.now();
  String _title = '';
  String _description = '';
  int _points = 0;
  bool _isBonus = false;
  bool _isShared = false;
  bool _loading = false;

  final List<bool> _repeatingWeekdays = List.filled(7, false);
  final List<Child> _assignedPeople = [];

  List<Child> peopleList = const [
    Child(
      familyId: 0,
      name: 'Emma',
      icon: ProfileIcon.bear,
      totalPoints: 45,
    ),
    Child(
      familyId: 0,
      name: 'Jacob',
      icon: ProfileIcon.dog,
      totalPoints: 80,
    ),
    Child(
      familyId: 0,
      name: 'Natalie',
      icon: ProfileIcon.cat,
      totalPoints: 65,
    ),
    Child(
      familyId: 0,
      name: 'Robert',
      icon: ProfileIcon.giraffe,
      totalPoints: 30,
    ),
  ];

  void submitChore(BuildContext context, ChoreProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final newChore = Chore(
        title: _title,
        description: _description,
        points: _points,
        dueDate: _dueDate,
        isShared: _isShared,
        assignedChildId: 1,
      );
      setState(() => _loading = true);
      await provider.addChore(newChore);
      setState(() => _loading = false);
      Navigator.of(context).pop();
    }
  }

  void updatePoints(String value) {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      setState(() => _points = intValue);
    }
  }

  String? validatePoints(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a point value";
    }
    // FilteringTestInputFormatter.digitsOnly prevents non-integers from being entered.
    int intValue = int.parse(value);
    if (intValue > 100) {
      return 'Value cannot be larger than 100';
    }
    return null;
  }

  void toggleWeekday(int i) =>
      setState(() => _repeatingWeekdays[i] = !_repeatingWeekdays[i]);

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Chore title',
            ),
            onChanged: (value) => setState(() => _title = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Chore details',
            ),
            onChanged: (value) => setState(() => _description = value),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Points:',
                style: AppTextStyles.brandBody,
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 50,
                height: 25,
                child: TextFormField(
                  style: AppTextStyles.brandBody,
                  controller: _pointsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: updatePoints,
                  validator: validatePoints,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Due: ${_dueDate.prettyDate()}',
                style: AppTextStyles.brandBody,
              ),
              TextButton(
                child: const Text(
                  'Change',
                  style: AppTextStyles.brandBody,
                ),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       'Make Bonus Chore',
          //       style: AppTextStyles.brandBody,
          //     ),
          //     Checkbox(
          //       value: _isBonus,
          //       activeColor: AppColors.brandGreen,
          //       onChanged: (value) => setState(() => _isBonus = value!),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Make Shared Chore',
                style: AppTextStyles.brandBody,
              ),
              Checkbox(
                value: _isShared,
                activeColor: AppColors.brandGreen,
                onChanged: (value) => setState(() => _isShared = value!),
              ),
            ],
          ),
          const Divider(),
          Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Days to repeat',
                  style: AppTextStyles.brandBodySmall,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [0,1,2,3,4,5,6].map((i) {
                  return InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 28,
                      width: 28,
                      decoration: _repeatingWeekdays[i]
                          ? BoxDecoration(
                              border: Border.all(
                                color: AppColors.brandBlack,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            )
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          _weekdayAbbreviations[i],
                          style: AppTextStyles.brandBodySmall,
                        ),
                      ),
                    ),
                    onTap: () => toggleWeekday(i),
                  );
                }).toList(),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Assign to:',
                style: AppTextStyles.brandBody,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DropdownButton<Child>(
                  hint: const Text(
                    'Add Person',
                    style: AppTextStyles.brandBody,
                  ),
                  items: peopleList
                      // TODO: the UI isn't updating while the dropdown is open
                      .map((person) => DropdownMenuItem<Child>(
                            onTap: () {
                              if (!_assignedPeople.contains(person)) {
                                setState(() => _assignedPeople.remove(person));
                              } else {
                                setState(() => _assignedPeople.add(person));
                              }
                            },
                            value: person,
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: AppColors.brandGreen,
                                  value: _assignedPeople.contains(person),
                                  onChanged: (value) {
                                    if (!_assignedPeople.contains(person)) {
                                      setState(
                                          () => _assignedPeople.add(person));
                                    } else {
                                      setState(
                                          () => _assignedPeople.remove(person));
                                    }
                                  },
                                ),
                                Text(
                                  person.name,
                                  style: AppTextStyles.brandBody,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (!_assignedPeople.contains(value)) {
                        _assignedPeople.add(value!);
                      } else {
                        _assignedPeople.remove(value);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChoreProvider>(
      builder: (context, provider, child) => AlertDialog(
        scrollable: true,
        title: const Center(
          child: Text(
            'New Chore',
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
            onPressed: () => submitChore(context, provider),
            child: _loading
                ? const CircularProgressIndicator()
                : const Text(
                    'Save',
                    style: AppTextStyles.brandAccent,
                  ),
          ),
        ],
      ),
    );
  }
}
