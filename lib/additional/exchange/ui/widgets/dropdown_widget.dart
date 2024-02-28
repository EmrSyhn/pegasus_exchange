import 'package:flutter/material.dart';

import '../../../../model/exchange.dart';

class DropdownWidget extends StatelessWidget {
  final Exchange value;
  final void Function(Exchange?)? onChanged;
  final List<Exchange> currencyList;
  const DropdownWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.currencyList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Add border color
        borderRadius: BorderRadius.circular(8.0), // Add border radius
      ),
      child: DropdownButton<Exchange>(
        isExpanded: true,
        underline: Container(),
        value: value,
        items:
            currencyList.map<DropdownMenuItem<Exchange>>((Exchange currency) {
          return DropdownMenuItem<Exchange>(
            value: currency,
            child: Text(currency.fromCur.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
