import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/helpers/helpers.dart';

import '../blocs/blocs.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Positioned(top: 50, left: 20, child: _BtnBack()),
          Center(
              child: Transform.translate(
            offset: const Offset(0, -20),
            child: BounceInDown(
              from: 100,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 55,
              ),
            ),
          )),
          Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  minWidth: size.width - 120,
                  onPressed: () async {
                    final start = locationBloc.state.lastKnowLocation;
                    if (start == null) return;

                    final end = mapBloc.mapCenter;
                    if (end == null) return;
                    showLoadingMessage(context);
                    final destination =
                        await searchBloc.getCoorsStartToEnd(start, end);
                    await mapBloc.drawRoutePolyline(destination);
                    searchBloc.add(OffActivateManualMarkerEvent());
                    Future.microtask(() => Navigator.pop(context));
                  },
                  color: const Color.fromARGB(255, 3, 55, 108),
                  elevation: 0,
                  height: 45,
                  shape: const StadiumBorder(),
                  child: const Text('Confirmar destino',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                ),
              ))
        ]));
  }
}

class _BtnBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 20,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            final searchBloc =
                BlocProvider.of<SearchBloc>(context, listen: false);
            searchBloc.add(OffActivateManualMarkerEvent());
          },
        ),
      ),
    );
  }
}
