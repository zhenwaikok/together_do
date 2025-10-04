class MyResponse<T, V> {
  final ResponseStatus _status;
  T? _error;
  V? _data;

  MyResponse.initial() : _status = ResponseStatus.initial;
  MyResponse.loading() : _status = ResponseStatus.loading;
  MyResponse.complete(data) : _status = ResponseStatus.complete, _data = data;
  MyResponse.error(error) : _status = ResponseStatus.error, _error = error;

  T? get error => _error;
  V? get data => _data;
  ResponseStatus get status => _status;
}

enum ResponseStatus { initial, complete, error, loading, consumed }
