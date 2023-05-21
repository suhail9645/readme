import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageInitial(index: 0)) {
    on<BottemItemClicked>((event, emit) {
      emit(MainPageInitial(index:event.index));
    });
  }
}
