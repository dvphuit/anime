part of 'base_cubit.dart';

@immutable
abstract class ViewState<T> {
  const ViewState();
}

class Initial extends ViewState {
  const Initial();
}

class Loading extends ViewState {
  const Loading();
}

class Loaded extends ViewState {
  const Loaded();
}

class Result<T> extends ViewState<T> {
  final AnimeRoute route;
  final T data;

  const Result(this.route, this.data);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Result && o.data == data && o.route == route;
  }

  @override
  int get hashCode => route.hashCode;
}

class Error extends ViewState {
  final String msg;

  const Error(this.msg);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Error && o.msg == msg;
  }

  @override
  int get hashCode => msg.hashCode;
}
