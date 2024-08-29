import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/login_page/login_event.dart';
import 'package:travel_app/ui/login_page/login_state.dart';
import 'package:flutter/cupertino.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(BuildContext context) : super(LoginState.initialState) {}

  static LoginState get initialState => LoginState(
        isSearching: false,
      );

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case UpdateLoadingState:
        final data = event as UpdateLoadingState;
        yield state.clone(isSearching: !data.isLoading);
        break;
    }
  }
}
