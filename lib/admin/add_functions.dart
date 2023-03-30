import 'package:flutter/material.dart';

class AddFunctions {
  static ValueNotifier<String> groupValue = ValueNotifier('Romance');
}

class CustomRadio1 extends ValueListenableBuilder {
  CustomRadio1({super.key, required context, required content})
      : super(
        
            valueListenable: AddFunctions.groupValue,
            builder: (context, grpValue, child) {
              return ListTile(
                horizontalTitleGap: 1,
                contentPadding: const EdgeInsets.all(0),
                title: Text(content),
                leading: Radio(
                  value: content,
                  groupValue: grpValue,
                  onChanged: (value) {
                    AddFunctions.groupValue.value = value;
                  },
                ),
              );
            });
}

class CustomRadio extends Expanded {
 CustomRadio({super.key, required context, required content})
      : super(
        flex: 1,
            child: ValueListenableBuilder(
                valueListenable:AddFunctions.groupValue, builder:(context, grpValue, child) =>  ListTile(
                horizontalTitleGap: 1,
                contentPadding: const EdgeInsets.all(0),
                title: Text(content),
                leading: Radio(
                  value: content,
                  groupValue: grpValue,
                  onChanged: (value) {
                    AddFunctions.groupValue.value = value;
                  },
                ),
              ),));
}
