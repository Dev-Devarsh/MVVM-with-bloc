import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_user_state.dart';

class SingleUserCubit extends Cubit<SingleUserState> {
  SingleUserCubit() : super(SingleUserInitial());
}
