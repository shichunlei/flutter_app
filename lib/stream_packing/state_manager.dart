import 'dart:async';

import 'state.dart';

class StateManager {
  StreamController<BaseState> controller;

  StateManager(){
    controller = StreamController();
  }

  void dispose() {
    controller?.close();
  }

  void loadingDialog() {
    controller.sink.add(ShowDialogState());
  }

  void loading() {
    controller.sink.add(LoadingState());
  }

  void error() {
    controller.sink.add(ErrorState());
  }

  void content<T>(T t) {
    controller.sink.add(ContentState<T>(t));
  }
}
