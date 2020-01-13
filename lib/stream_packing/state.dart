class BaseState {}

class LoadingState extends BaseState {}

class ErrorState extends BaseState {}

class ShowDialogState extends BaseState {}

class HideDialogState extends BaseState {}

class ContentState<T> extends BaseState {
  T t;

  ContentState(this.t);
}
