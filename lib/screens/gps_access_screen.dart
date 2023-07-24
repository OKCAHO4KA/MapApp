import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
        return !state.isGpsEnabled
            ? const _EnableGpsMesage()
            : const _AccessButton();
      }),
    ));
  }
}

class _EnableGpsMesage extends StatelessWidget {
  const _EnableGpsMesage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe de habilitar el GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Es necesario el accesso al GPS',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 20,
        ),
        MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          color: Colors.black,
          shape: const StadiumBorder(),
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAccess();
          },
          elevation: 0,
          splashColor: Colors.transparent,
          child: const Text('Solicitar Accesso',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w300)),
        )
      ],
    );
  }
}
