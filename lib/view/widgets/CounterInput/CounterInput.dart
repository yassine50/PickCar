import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CounterInput extends StatefulWidget {
  final double width ;
 final double height ;
 final double iconSize  ; 
  const CounterInput({super.key, required this.width, required this.height, required this.iconSize});
  @override
  CounterInputState createState() => CounterInputState();
}

class CounterInputState extends State<CounterInput> {
 static int currentValue = 0;

  void _increment() {
    setState(() {
      currentValue++;
    });
  }

  void _decrement() {
    setState(() {
      if (currentValue > 0) currentValue--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
         mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
             color: Color(0xFFBFA6DF),
             borderRadius: BorderRadius.circular(4),
           
            ),

            width: 32,
            height: 32,
              margin: EdgeInsets.only(left: 22,right:22),
           
            child: IconButton(
              icon: Icon(Icons.remove,size: widget.iconSize,),
              onPressed: _decrement,
            ),
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$currentValue ' + " €",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
            ),
          ),
          Container(
             decoration: BoxDecoration(
             color: Color(0xFFBFA6DF),
             borderRadius: BorderRadius.circular(4),
           
            ),

            width: 32,
            height: 32,
              margin: EdgeInsets.only(left: 22,right:22),
            child: IconButton(
              icon: Icon(Icons.add,size: widget.iconSize,),
              onPressed: _increment,
            ),
          ),
        ],
      ),
    );
  }
}
