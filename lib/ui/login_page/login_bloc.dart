import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/login_page/login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginBloc.initialState);

  static LoginState get initialState => LoginState(
        isSearching: false,
      );

  void updateLoadingState(bool isLoading) {
    emit(state.clone(isSearching: isLoading));
  }
}
