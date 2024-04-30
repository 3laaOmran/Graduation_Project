import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'siginup_state.dart';

class SiginupCubit extends Cubit<SiginupState> {
  SiginupCubit() : super(SiginupInitial());
}
