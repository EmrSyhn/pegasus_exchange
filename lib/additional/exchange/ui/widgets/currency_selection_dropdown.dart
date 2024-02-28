import 'package:flutter/material.dart';

import '../../../model/exchange.dart';
import '../../bloc/exchange_bloc.dart';
import '../../utility/helper/exchange_list_extension.dart';
import 'dropdown_widget.dart';

class CurrencySelectionDropdown extends StatelessWidget {
  final ExchangeBloc bloc;
  final ExchangeFetchListState state;
  const CurrencySelectionDropdown({
    super.key,
    required this.bloc,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DropdownWidget(
            value: state.selectedSourceExchange,
            currencyList: bloc.currencyList
                .filterExchange()
                .filterE(exchange: state.selectedConvertedExchange),
            onChanged: (v) {
              _updateSelectedCurrencies(
                sourceCurrency: v!,
                convertedCurrency: state.selectedConvertedExchange,
              );
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: _swapCurrencies,
            child: const Icon(Icons.currency_exchange),
          ),
        ),
        Expanded(
          flex: 2,
          child: DropdownWidget(
            value: state.selectedConvertedExchange,
            currencyList: bloc.currencyList
                .filterExchange()
                .filterE(exchange: state.selectedSourceExchange),
            onChanged: (v) {
              _updateSelectedCurrencies(
                sourceCurrency: state.selectedSourceExchange,
                convertedCurrency: v!,
              );
            },
          ),
        ),
      ],
    );
  }

  void _updateSelectedCurrencies({
    required Exchange sourceCurrency,
    required Exchange convertedCurrency,
  }) {
    bloc.add(ExchangeSourceCurrencySelectionEvent(exchange: sourceCurrency));
    bloc.add(
        ExchangeConvertedCurrencySelectionEvent(exchange: convertedCurrency));
  }

  void _swapCurrencies() {
    final temp = state.selectedSourceExchange;
    _updateSelectedCurrencies(
      sourceCurrency: state.selectedConvertedExchange,
      convertedCurrency: temp,
    );
  }
}
