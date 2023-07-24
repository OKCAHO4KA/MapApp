import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/search/search_destination_delegate.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : const _SearchbarBody();
      },
    );
  }
}

class _SearchbarBody extends StatelessWidget {
  const _SearchbarBody();

  void onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final start = locationBloc.state.lastKnowLocation;

      final end = result.position!;

      final destination = await searchBloc.getCoorsStartToEnd(start!, end);
      mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeInDown(
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              final result = await showSearch(
                  context: context, delegate: SearchDestinationDelegate());
              if (result == null) return;

              Future.microtask(() => onSearchResults(context, result));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(0, 5))
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: const Text('¿ Dónde quieres ir ?',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}
