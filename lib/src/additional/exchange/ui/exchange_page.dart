import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exchange_bloc.dart';
import '../utility/constants/exchange_string_constants.dart';
import '../utility/constants/exchange_style_constants.dart';
import 'widgets/currency_selection_dropdown.dart';
import 'widgets/currency_value_input_area.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final ExchangeBloc bloc = ExchangeBloc();
  late String flightNo;

  @override
  void initState() {
    super.initState();
    bloc.add(ExchangeFetchListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(ExchangeStringConstants.appbarTitle),
      ),
      body: Center(
        child: BlocConsumer<ExchangeBloc, ExchangeState>(
          listener: (context, state) {
            if (state is ExchangeBackButtonClickActionState) {
              Navigator.pop(context);
            }
          },
          listenWhen: (previous, current) => current is ExchangeActionState,
          buildWhen: (previous, current) => current is! ExchangeActionState,
          bloc: bloc,
          builder: (context, state) {
            if (state is ExchangeFetchListState) {
              return _buildMainWidget(state);
            } else if (state is ExchangeInitialState) {
              return const Center(child: LinearProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildMainWidget(ExchangeFetchListState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizedBox(),
          const Text(
            ExchangeStringConstants.paraBirimi,
          ),
          sizedBox(),
          CurrencySelectionDropdown(bloc: bloc, state: state),
          sizedBox(),
          const Divider(),
          sizedBox(),
          const Text(ExchangeStringConstants.miktar),
          sizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: CurrencyValueInputArea(state: state, bloc: bloc)),
              const Expanded(
                child: Text(
                  "=",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildTotalResultWidget(state),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox sizedBox() =>
      const SizedBox(height: ExchangeStyleConstants.heightSpace20);

  Widget _buildTotalResultWidget(ExchangeFetchListState state) {
    return Text(
      state.result.toString().removeDecimalZeroFormat,
      textAlign: TextAlign.center,
    );
  }
}

extension StringExtension on String {
  String get removeDecimalZeroFormat {
    var number = double.tryParse(this);
    if (number != null) {
      return number
          .toStringAsFixed(number.truncateToDouble() == number ? 0 : 2);
    }
    return this;
  }
}
