part of 'local_bloc.dart';

abstract class LocalEvent extends Equatable {
  const LocalEvent();

  @override
  List<Object> get props => [];
}

class ChangeLocal extends LocalEvent {
  String newLocal;
  ChangeLocal(this.newLocal);
}
