import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_snack_bar.dart';
import '../bloc/preorder_bloc.dart';

import '../preorder.dart';

class PreorderListPage extends StatefulWidget {
  const PreorderListPage({Key? key}) : super(key: key);

  @override
  State<PreorderListPage> createState() => _PreorderListPageState();
}

class _PreorderListPageState extends State<PreorderListPage> {
  PreorderBloc bloc = PreorderBloc();
  PreorderStatus statusSelection = PreorderStatus.nonSelected;
  final String appbarTitle = 'PREORDER LİSTESİ';

  @override
  void initState() {
    bloc.add(PreorderFetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(appbarTitle),
        actions: [
          IconButton(
            onPressed: () {
              bloc.add(PreorderSaveButtonEvent());
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: BlocConsumer<PreorderBloc, PreorderState>(
        buildWhen: (previous, current) => current is! PreorderActionState,
        listenWhen: (previous, current) => current is PreorderActionState,
        bloc: bloc,
        builder: (context, state) {
          if (state is PreorderInitialState) {
            return const Center(child: LinearProgressIndicator());
          } else if (state is PreorderEmptyState) {
            return const Center(
              child: Text("Bu uçuşa ait preorder bulunmamaktadır."),
            );
          } else if (state is PreorderDataFetchedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SeatFilterSelection(bloc: bloc),
                    state.preorderList.isEmpty
                        ? const Center(
                            child: Text(
                                "Bu koltuk numaralarına ait preorder bulunmamaktadır."),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.preorderList.length,
                            itemBuilder: (context, index) {
                              var item = state.preorderList[index];
                              return PreorderCardWidget(bloc: bloc, item: item);
                            },
                          ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("hata"),
            );
          }
        },
        listener: (context, state) {
          if (state is PreorderSaveButtonPressedState) {
            CustomSnackBar.show(
                context, PreorderInitialTextItems.preorderMessage);
          } else {}
        },
      ),
    );
  }
}
