import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/utilities/date.dart';

class EditChoreDialog extends StatefulWidget {
  const EditChoreDialog({super.key, this.assignedChildId, this.chore});
  final int?
      assignedChildId; // left as optional depending on if the chore is created on the child page or the parent page
  final Chore?
      chore; // left as optional depending on if the parent is creating a new chore or editing an existing one

  @override
  State<EditChoreDialog> createState() => _EditChoreDialogState();
}

class _EditChoreDialogState extends State<EditChoreDialog> {
  static const List<String> _weekdayAbbreviations = [
    'S',
    'M',
    'T',
    'W',
    'Th',
    'F',
    'Sa'
  ];

  final _formKey = GlobalKey<FormState>();
  final MultiSelectController<Child> selectController = MultiSelectController();

  DateTime _dueDate = DateTime.now();
  late String _title;
  late String _description;
  late int _points = 0;
  late bool _isBonus;
  late bool _isShared;
  bool _loading = false;
  List<Child> _assignedPeople = [];

  // TODO: add _repeatingWeekdays and _assignedPeople to initState from Chore parameter
  final List<bool> _repeatingWeekdays = List.filled(7, false);

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PersonProvider>(context, listen: false);
    _title = widget.chore?.title ?? '';
    _description = widget.chore?.description ?? '';
    _points = widget.chore?.points ?? 0;
    _isBonus = false;
    _isShared = widget.chore?.isShared ?? false;
    _dueDate = widget.chore?.dueDate ?? DateHelpers.getDateToday();
    final List<ValueItem<Child>> assignedValueItems =
        _assignedPeople.map((e) => ValueItem(label: e.name, value: e)).toList();
    selectController.setOptions(provider.children
        .map((child) => ValueItem(label: child.name, value: child))
        .toList());
    assignedValueItems
        .forEach((child) => selectController.addSelectedOption(child));
  }

  void submitChore(BuildContext context, ChoreProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final newChore = Chore(
        title: _title,
        description: _description,
        points: _points,
        dueDate: _dueDate,
        isShared: _isShared,
      );
      setState(() => _loading = true);
      await provider.addChore(newChore);
      setState(() => _loading = false);
      Navigator.of(context).pop();
    }
  }

  void updateChore(BuildContext context, ChoreProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final updatedChore = Chore(
        id: widget.chore!.id,
        title: _title,
        description: _description,
        points: _points,
        dueDate: _dueDate,
        isShared: _isShared,
      );
      setState(() => _loading = true);
      // await provider.updateChore(updatedChore); // TODO: fix
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

  Widget buildDropdown() {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        child: MultiSelectDropDown<Child>(
          controller: selectController,
          selectionType: SelectionType.multi,
          dropdownHeight: 200,
          chipConfig: const ChipConfig(
            wrapType: WrapType.scroll,
            backgroundColor: AppColors.brandLightGray,
            labelColor: AppColors.brandWhite,
            labelStyle: AppTextStyles.brandBodySmall,
          ),
          clearIcon: const Icon(
            Icons.clear,
            color: AppColors.brandBlack,
          ),
          onOptionSelected: (options) {},
          // selectedOptions: selectController.selectedOptions,
          options: selectController.options,
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
            initialValue: _title,
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
            initialValue: _description,
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
                  initialValue: _points.toString(),
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
                children: [0, 1, 2, 3, 4, 5, 6].map((i) {
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
                'Assigned:',
                style: AppTextStyles.brandBody,
              ),
              buildDropdown(),
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
            onPressed: () => widget.chore != null
                ? updateChore(context, provider)
                : submitChore(context, provider),
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
