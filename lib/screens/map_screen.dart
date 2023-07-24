import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, stateLoc) {
          if (stateLoc.lastKnowLocation == null) {
            return const Center(child: Text('Espere por favor ...'));
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              Map<String, Polyline> polylines = Map.from(state.polylines);
              Map<String, Marker> markers = Map.from(state.markers);

              if (!state.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: stateLoc.lastKnowLocation!,
                      polylines: polylines.values.toSet(),
                      markers: markers.values.toSet(),
                    ),
                    const Searchbar(),
                    const ManualMarker()
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnFollowUser(),
          BtnLocation(),
          BtnToggleUserRoute(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
