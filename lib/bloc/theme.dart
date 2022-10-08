import 'package:bloc/bloc.dart';

class ThemeBloc extends Cubit<bool> {
  // true -> light mode || false-> dark mode
  ThemeBloc() : super(true);

  void changeTheme() => emit(!state);
}
