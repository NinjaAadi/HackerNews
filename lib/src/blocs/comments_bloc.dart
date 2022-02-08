import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class CommentsBloc {
  final _commentFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _repository = Repository();
  //getters
  Stream<Map<int, Future<ItemModel?>>> get itemWithComments =>
      _commentsOutput.stream;

  //sink getter
  Function(int) get fetchItemWithComments => _commentFetcher.sink.add;

  CommentsBloc() {
    _commentFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }
  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
        (cache, int id, index) {
      print(index);
      cache[id] = _repository.fetchItem(id);
      cache[id]?.then((item) {
        item?.kids.forEach((kidId) {
          // ignore: void_checks
          return fetchItemWithComments(kidId);
        });
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentFetcher.close();
    _commentsOutput.close();
  }
}
