import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kanban_event.dart';
part 'kanban_state.dart';

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  KanbanBloc() : super(KanbanInitial()) {
    on<KanbanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
