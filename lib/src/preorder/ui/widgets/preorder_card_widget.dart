import 'package:flutter/material.dart';
import '../../../model/preorder_model.dart';
import '../../bloc/preorder_bloc.dart';
import '../../helper/preorder_enum.dart';
import '../../helper/preorder_methods.dart';

class PreorderCardWidget extends StatefulWidget {
  final PreorderBloc bloc;
  final Preorder item;
  const PreorderCardWidget({Key? key, required this.bloc, required this.item})
      : super(key: key);

  @override
  State<PreorderCardWidget> createState() => _PreorderCardWidgetState();
}

class _PreorderCardWidgetState extends State<PreorderCardWidget> {
  @override
  Widget build(BuildContext context) {
    PreorderStatus statusSelection =
        findPreorderStatusByCode(widget.item.status!);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item.name ?? "_",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(20),
                      isExpanded: true,
                      underline: Container(),
                      value: statusSelection,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: const <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: PreorderStatus.nonSelected,
                          child: Text('Durum Seçiniz'),
                        ),
                        DropdownMenuItem(
                          value: PreorderStatus.delivered,
                          child: Text('Teslim Edildi'),
                        ),
                        DropdownMenuItem(
                          value: PreorderStatus.noCatering,
                          child: Text('İkram Yok'),
                        ),
                        DropdownMenuItem(
                          value: PreorderStatus.noGuess,
                          child: Text('Misafir Yok'),
                        ),
                        DropdownMenuItem(
                          value: PreorderStatus.damaged,
                          child: Text('Hasarlı'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != PreorderStatus.nonSelected) {
                          setState(() {
                            statusSelection = value;
                          });
                          widget.bloc.add(PreorderChangeStatusEvent(
                            preorderId: widget.item.preorderId ?? 0,
                            status: statusSelection,
                          ));
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PNR: ${widget.item.pnrNo ?? "_"}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "SSR: ${widget.item.ssrCode ?? "_"}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Koltuk: ${widget.item.seatNo ?? '_'}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
