import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          final result = SearchResult(cancel: true);
          close(context, result);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnowLocation;

    searchBloc.getPlacesByQuery(proximity!, query);

    return BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        itemCount: state.places.length,
        itemBuilder: (context, index) {
          final place = state.places[index];
          return ListTile(
            leading: const Icon(
              Icons.place_sharp,
              color: Color.fromRGBO(191, 71, 15, 1),
            ),
            titleTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(191, 71, 15, 1)),
            title: Text(
              place.text,
            ),
            subtitle: Text(place.placeNameEs),
            onTap: () {
              final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(
                    place.center[1],
                    place.center[0],
                  ),
                  namePlace: place.text,
                  descriptionPlace: place.placeNameEs);
              searchBloc.add(AddToHistoryEvent(place));

              close(context, result);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Color.fromRGBO(191, 71, 15, 1),
            height: 3,
          );
        },
      );
    }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = BlocProvider.of<SearchBloc>(context).state.historyPlaces;

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_rounded),
          title: const Text('Colocar la ubicación manualmente',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        ...history.map((e) => ListTile(
            leading: const Icon(Icons.history),
            title: Text(e.text),
            subtitle: Text(e.placeNameEs),
            onTap: () {
              final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(
                    e.center[1],
                    e.center[0],
                  ),
                  namePlace: e.text,
                  descriptionPlace: e.placeNameEs);

              close(context, result);
            }))
      ],
    );
  }
}
