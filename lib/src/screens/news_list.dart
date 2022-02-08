import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  // ignore: non_constant_identifier_names, avoid_renaming_method_parameters
  Widget build(Context) {
    final bloc = StoriesProvider.of(Context);


    return Scaffold(
        appBar: AppBar(
          title: const Text('Top news!'),
        ),
        body: buildList(bloc));
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext? context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Refresh(
              child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, int index) {
              // ignore: avoid_print
              return NewsListTile(
                itemId: snapshot.data![index],
              );
            },
          ));
        }
      },
    );
  }
}
