import 'package:flutter/material.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/constance/constance.dart'  as constance;
import 'package:mycar/services/placeService.dart';

class AddressSearch extends SearchDelegate<Suggestion> {

  final String hintText;
  AddressSearch({this.hintText});

  @override
  String get searchFieldLabel => hintText;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: AppLocalizations.of('Clear'),
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of('Back'),
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : PlaceApiProvider().fetchSuggestions(
          query, constance.locale),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Text(AppLocalizations.of('Enter your address')),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title:
          Text((snapshot.data[index] as Suggestion).description),
          onTap: () {
            close(context, snapshot.data[index] as Suggestion);
          },
        ),
        itemCount: snapshot.data.length,
      )
          : Container(child: Text(AppLocalizations.of('Loading...'))),
    );
  }
}