import 'package:flutter/material.dart';
import '../../bloc/preorder_bloc.dart';
import '../../helper/preorder_enum.dart';

class SeatFilterSelection extends StatefulWidget {
  const SeatFilterSelection({Key? key, required this.bloc}) : super(key: key);
  final PreorderBloc bloc;
  @override
  State<SeatFilterSelection> createState() => _SeatFilterSelectionState();
}

class _SeatFilterSelectionState extends State<SeatFilterSelection> {
  PreorderSeatInterval intervalSelection = PreorderSeatInterval.nonSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        underline: Container(),
        value: intervalSelection,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
        ),
        items: const <DropdownMenuItem>[
          DropdownMenuItem(
            value: PreorderSeatInterval.nonSelected,
            child: Text('Filtrele'),
          ),
          DropdownMenuItem(
            value: PreorderSeatInterval.start,
            child: Text('1-11'),
          ),
          DropdownMenuItem(
            value: PreorderSeatInterval.mid,
            child: Text('11-22'),
          ),
          DropdownMenuItem(
            value: PreorderSeatInterval.end,
            child: Text('22-33'),
          ),
          DropdownMenuItem(
            value: PreorderSeatInterval.all,
            child: Text('HEPSİ'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            intervalSelection = value;
          });
          widget.bloc.add(
              PreorderFilterByIntervalEvent(seatInterval: intervalSelection));
        },
      ),
    );
  }
}
