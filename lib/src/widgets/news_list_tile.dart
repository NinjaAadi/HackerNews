import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/news_list.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_bloc.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({required this.itemId});

  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    bloc.fetchItem(itemId);
    return StreamBuilder(
        stream: bloc.items,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          return FutureBuilder(
              future: snapshot.data![itemId],
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return LoadingContainer();
                }

                return buildTile(context,itemSnapshot.data);
              });
        });
  }

  Widget buildTile(BuildContext context,ItemModel? item) {
    int? descendants = item?.descendants;

    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context,"/${item?.id}");
          },
          title: Text(item?.title as String),
          subtitle: Text('${item?.score} points'),
          trailing: Column(
            children: [const Icon(Icons.comment), Text('$descendants')],
          ),
        ),
        const Divider(
          height: 8.0,
        )
      ],
    );
  }
}
