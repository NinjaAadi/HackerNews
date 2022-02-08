import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();
  //define the getters to get the Streams
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  //Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;
  StoriesBloc() {
    //_items = _items.stream;
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids!);
    // print(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        print(index);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  clearCache() {
    return _repository.clearCache();
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
