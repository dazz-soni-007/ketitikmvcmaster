import 'package:flutter/material.dart';
import 'package:ketitik/models/category.dart';
import 'package:ketitik/utility/colorss.dart';

class MultiSelectChip extends StatefulWidget {
  final List<Preference?> categoryList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.categoryList, {required this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.categoryList) {
      choices.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChoiceChip(
          padding: const EdgeInsets.all(15),
          shadowColor: Colors.black,
          selectedColor: MyColors.themeColorYellow,
          label: Text(item!.categories.toString().capitalize()),
          elevation: 3,
          selected: selectedChoices.contains(item.categories!),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item.categories!)
                  ? selectedChoices.remove(item.categories!)
                  : selectedChoices.add(item.categories!);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class MultiSelectChipEdit extends StatefulWidget {
  final List<Preference?> categoryList;
  final Function(List<String>) onSelectionChanged;
  List<String> selectedCat = [];

  MultiSelectChipEdit(this.categoryList,
      {required this.selectedCat, required this.onSelectionChanged});

  @override
  MultiSelectChipEditState createState() => MultiSelectChipEditState();
}

class MultiSelectChipEditState extends State<MultiSelectChipEdit> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.categoryList) {
      choices.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChoiceChip(
          padding: const EdgeInsets.all(15),
          shadowColor: Colors.black,
          selectedColor: MyColors.themeColorYellow,
          label: Text(item!.categories.toString().capitalize()),
          elevation: 3,
          selected: widget.selectedCat.contains(item.categories!),
          onSelected: (selected) {
            setState(() {
              widget.selectedCat.contains(item.categories!)
                  ? widget.selectedCat.remove(item.categories!)
                  : widget.selectedCat.add(item.categories!);
              widget.onSelectionChanged(widget.selectedCat);
            });
          },
        ),
      ));
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
