import 'package:flutter/material.dart';

class DropDuwnButton extends StatefulWidget {
  final List<String> list;
  final ValueChanged<String?> onChanged;
  final String? value ;  


  const DropDuwnButton({
    super.key,
    required this.list,
    required this.onChanged, this.value,
  });

  @override
  State<DropDuwnButton> createState() => _DropDuwnButtonState();
}

class _DropDuwnButtonState extends State<DropDuwnButton> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    // Initialize the dropdownValue with the first item or null if the list is empty
    if(widget.value == null) {
    dropdownValue = widget.list.isNotEmpty ? widget.list.first : null;
    }else{
dropdownValue =widget. value ; 
    }
  }

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          isFocused = hasFocus;
        });
      },
      child: Container(
        height: 48,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(
              Icons.arrow_drop_down,
              color: isFocused
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).shadowColor,
            ),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
              widget.onChanged(newValue);
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
