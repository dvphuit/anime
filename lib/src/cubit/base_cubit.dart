import 'package:cubit/cubit.dart';
import 'package:meta/meta.dart';
part 'view_state.dart';

abstract class BaseCubit extends Cubit<ViewState>{
  BaseCubit(Initial initial) : super(Initial());

}