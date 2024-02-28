import 'package:flutter/material.dart';

import '../../bloc/exchange_bloc.dart';
import '../../utility/constants/exchange_string_extension.dart';

class CurrencyValueInputArea extends StatefulWidget {
  final ExchangeFetchListState state;
  final ExchangeBloc bloc;
  const CurrencyValueInputArea({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  State<CurrencyValueInputArea> createState() => _CurrencyValueInputAreaState();
}

class _CurrencyValueInputAreaState extends State<CurrencyValueInputArea> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.state.amount.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        labelText: widget.state.selectedSourceExchange.fromCur,
      ),
      onTap: () {
        if (controller.text == "0.00") {
          controller.text = "";
        }
      },
      onChanged: (value) {
        widget.bloc.add(
          ExchangeChangeCurrencyValueInputEvent(
            amount: value.toAmount,
          ),
        );
      },
    );
  }
}
