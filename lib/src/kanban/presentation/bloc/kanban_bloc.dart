import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'kanban_event.dart';
part 'kanban_state.dart';

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  KanbanBloc() : super(KanbanInitial()) {
    on<KanbanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
