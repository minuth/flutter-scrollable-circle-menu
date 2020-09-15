import 'dart:async';

class MenuController {
  final _controller = StreamController<bool>();
  Stream<bool> get stream => _controller.stream;
  void changeState(bool visible){
    _controller.sink.add(visible);
  }
  void close(){
    _controller.close();
  }
}