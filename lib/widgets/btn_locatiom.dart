import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/ui/uis.dart';

import '../blocs/blocs.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maps_app/blocs/blocs.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final localBloc = BlocProvider.of<LocationBloc>(context);
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
            backgroundColor: const Color.fromRGBO(236, 158, 76, 1),
            maxRadius: 25,
            child: IconButton(
              icon: const Icon(Icons.my_location_outlined, color: Colors.white),
              onPressed: () {
                final ultimaLocationKnow = localBloc.state.lastKnowLocation;

                if (ultimaLocationKnow == null) {
                  final snack = CustomSnackbar(text: 'No hay ubication');
                  ScaffoldMessenger.of(context).showSnackBar(snack);

                  return;
                }
                mapBloc.moveCamera(ultimaLocationKnow);
              },
            )));
  }
}
