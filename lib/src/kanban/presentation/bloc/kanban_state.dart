part of 'kanban_bloc.dart';

abstract class KanbanState extends Equatable {
  const KanbanState();  

  @override
  List<Object> get props => [];
}
class KanbanInitial extends KanbanState {}
