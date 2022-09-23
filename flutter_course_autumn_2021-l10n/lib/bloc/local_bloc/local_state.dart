part of 'local_bloc.dart';

abstract class LocalState extends Equatable {
  String local = 'en';
  LocalState();

  @override
  List<Object> get props => [];
}

class LocalInitial extends LocalState {
  String local = 'en';
  LocalInitial([this.local = 'en']);
}

class LocalChanged extends LocalState {
  String local;
  LocalChanged(this.local);
}
