import 'package:flutter/material.dart';

class DropDownSelector extends StatefulWidget {
  final String label;
  final List<String> listItems;
  final String? selectedItem;
  const DropDownSelector(this.label, this.listItems, this.selectedItem, {Key? key})
      : super(key: key);

  @override
  _DropDownSelectorState createState() => _DropDownSelectorState();
}

class _DropDownSelectorState extends State<DropDownSelector> {
  String selectedItems = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItems = widget.selectedItem.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.black26
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: DropdownButton<String>(
                  value: selectedItems,
                  underline: const SizedBox(),
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 25.0,
                    color: Colors.black26,
                  ),
                  items: widget.listItems.map<DropdownMenuItem<String>>(
                        (String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style:
                          const TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) => setState(() {
                    selectedItems = newValue!;
                  })),
            ),
          ),
        ),
      ],
    );
  }
}