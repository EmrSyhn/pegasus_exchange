import 'package:flutter/material.dart';

import '../../bloc/preorder_bloc.dart';

class PreorderSaveButton extends StatelessWidget {
  final PreorderBloc bloc;
  const PreorderSaveButton({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () => bloc.add(PreorderSaveButtonEvent()),
      child: const Text("KAYDET"),
    );
  }
}
