import 'package:cubit/cubit.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void home() => emit(0);

  void explore() => emit(1);

  void library() => emit(2);
}
