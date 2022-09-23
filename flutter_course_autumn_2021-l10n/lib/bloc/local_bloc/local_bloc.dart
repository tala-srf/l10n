import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_event.dart';
part 'local_state.dart';

class LocalBloc extends Bloc<LocalEvent, LocalState> {
  LocalBloc() : super(LocalInitial()) {
    on<ChangeLocal>((event, emit) {
      emit(LocalChanged(event.newLocal));
      SharedPreferences.getInstance()
          .then((value) => value.setString('local', event.newLocal));
      emit(LocalInitial(event.newLocal));
    });
  }
}
