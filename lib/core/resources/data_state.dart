class DataState<T> {
  final T? data;
  final String? error;

  DataState({this.data, this.error});

  factory DataState.success(T data) {
    return DataStateSuccess(data);
  }

  factory DataState.error(String error) {
    return DataStateError(error);
  }
}

class DataStateSuccess<T> extends DataState<T> {
  DataStateSuccess(T data) : super(data: data);
}

class DataStateError<T> extends DataState<T> {
  DataStateError(String error) : super(error: error);
}
