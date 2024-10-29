import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:donezo/config/theme/app_color.dart';
import 'package:donezo/core/di/injection_container.dart';
import 'package:donezo/core/widgets/app_button.dart';
import 'package:donezo/core/widgets/app_dropdown.dart';
import 'package:donezo/src/task_management/presentation/bloc/add_todo/add_todo_bloc.dart';
import 'package:donezo/src/task_management/presentation/bloc/task_form/task_form_bloc.dart';
import 'package:donezo/src/task_management/presentation/bloc/task_form_validation/task_form_validation_bloc.dart';
import 'package:donezo/src/task_management/presentation/widgets/add_category_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/params.dart';
import '../../../../core/widgets/container_width_inherited.dart';
import '../../domain/entities/task_entity.dart';
import '../widgets/todo_card.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key});

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  TextEditingController todoController = TextEditingController();
  TextEditingController addCategoryFormController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? category;

  List<Map<String, dynamic>> todoList = [];

  String taskTitle = 'Task';
  List<String> categories = [];

  FocusNode todoFocusNode = FocusNode();
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [];

  @override
  void initState() {
    todoController = TextEditingController();
    todoFocusNode = FocusNode();
    taskTitleController = TextEditingController();
    descriptionController = TextEditingController();

    _getCategoryList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCategoryList();
  }

  @override
  void dispose() {
    todoController.dispose();
    todoFocusNode.dispose();
    taskTitleController.dispose();
    descriptionController.dispose();
    todoList.clear();

    super.dispose();
  }

  void _getCategoryList() {
    context.read<TaskFormBloc>().add(TaskFormGetCategories());
  }

  @override
  Widget build(BuildContext context) {
    log("TaskFormPage build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<TaskFormValidationBloc,
                        TaskFormValidationState>(
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state is TaskFormValidationInvalid &&
                                      state.message['taskTitle']!.isNotEmpty
                                  ? Colors.red
                                  : Colors.black,
                              width: 1.3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: state is TaskFormValidationInvalid &&
                                        state.message['taskTitle']!.isNotEmpty
                                    ? Colors.red
                                    : Colors.black,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: taskTitleController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  color: state is TaskFormValidationInvalid &&
                                          state.message['taskTitle']!.isNotEmpty
                                      ? Colors.red
                                      : Colors.black54),
                              hintText: 'Enter task title',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.only(left: 12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                taskTitle = value;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    BlocBuilder<TaskFormValidationBloc,
                        TaskFormValidationState>(
                      builder: (context, state) {
                        if (state is TaskFormValidationInvalid &&
                            state.message['taskTitle']!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              state.message['taskTitle']!.first,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildCalendarDialogButton(),
                    BlocBuilder<TaskFormValidationBloc,
                        TaskFormValidationState>(
                      builder: (context, state) {
                        if (state is TaskFormValidationInvalid &&
                            state.message['taskDueDate']!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              state.message['taskDueDate']!.first,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocListener<TaskFormBloc, TaskFormState>(
                      listener: (context, state) {
                        if (state is TaskFormCategorySuccess) {
                          setState(() {
                            categories = state.categories;
                          });
                        }
                      },
                      child: BlocBuilder<TaskFormValidationBloc,
                          TaskFormValidationState>(
                        builder: (context, state) {
                          return AppDropdownFormField(
                            isValid: state is TaskFormValidationInvalid &&
                                    state.message['taskCategory']!.isNotEmpty
                                ? false
                                : true,
                            hint: 'Select Category',
                            items: categories
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    alignment: Alignment.center,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              log('Category selected: $value');
                              setState(() {
                                category = value!;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    BlocBuilder<TaskFormValidationBloc,
                        TaskFormValidationState>(
                      builder: (context, state) {
                        if (state is TaskFormValidationInvalid &&
                            state.message['taskCategory']!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              state.message['taskCategory']!.first,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<TaskFormValidationBloc,
                        TaskFormValidationState>(
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state is TaskFormValidationInvalid &&
                                      state.message['description']!.isNotEmpty
                                  ? Colors.red
                                  : Colors.black,
                              width: 1.3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: state is TaskFormValidationInvalid &&
                                        state.message['description']!.isNotEmpty
                                    ? Colors.red
                                    : Colors.black,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: descriptionController,
                            minLines: 4,
                            maxLines: 12,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  color: state is TaskFormValidationInvalid &&
                                          state.message['description']!
                                              .isNotEmpty
                                      ? Colors.red
                                      : Colors.black54),
                              hintText: 'Add note /description here...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, top: 12),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<TaskFormValidationBloc,
                        TaskFormValidationState>(
                      builder: (context, state) {
                        if (state is TaskFormValidationInvalid &&
                            state.message['description']!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              state.message['description']!.first,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocListener<TaskFormBloc, TaskFormState>(
                      listener: (context, state) {
                        if (state is TaskFormAddCategoryError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              width: constraints.maxWidth,
                            ),
                          );
                        } else if (state is TaskFormAddCategorySuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${state.category} category is added'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              width: constraints.maxWidth,
                            ),
                          );
                        }
                      },
                      child: AppButton(
                        width: kIsWeb
                            ? ContainerWidthInherited.of(context).containerWidth
                            : null,
                        child: const Text(
                          'Add Category',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AddCategoryDialog(
                                controller: addCategoryFormController,
                                onTap: () {
                                  if (addCategoryFormController
                                      .text.isNotEmpty) {
                                    context
                                        .read<TaskFormBloc>()
                                        .add(TaskFormAddCategory(
                                          addCategoryFormController.text,
                                        ));
                                    addCategoryFormController.clear();
                                    _getCategoryList();
                                    Navigator.of(context).pop();
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text('Add Todo List',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.3,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            context.read<AddTodoListBloc>().add(
                                AddTodoStoreToListEvent(
                                    todo: todoController.text));
                            todoController.clear();
                            todoFocusNode.requestFocus();
                          }
                        },
                        controller: todoController,
                        focusNode: todoFocusNode,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.black54),
                          hintText: 'Enter a todo',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.only(left: 12),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (todoController.text.isNotEmpty) {
                                context.read<AddTodoListBloc>().add(
                                    AddTodoStoreToListEvent(
                                        todo: todoController.text));
                                todoController.clear();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(8),
                                    left: Radius.circular(0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('List of Todos'),
                    const SizedBox(height: 12),
                    BlocBuilder<AddTodoListBloc, AddTodoState>(
                        builder: (context, state) {
                      if (state is AddTodoInitial) {
                        return Column(
                          children: List<Widget>.generate(state.todoList.length,
                              (index) {
                            var todo = state.todoList[index];
                            var title = todo['title'];
                            return TodoCard(
                              index: index,
                              title: title,
                              taskTitle: taskTitle.isEmpty ? 'Task' : taskTitle,
                            );
                          }),
                        );
                      }
                      if (state is AddTodoList) {
                        return Column(
                          children: List<Widget>.generate(
                            state.todoList.length,
                            (index) {
                              var todo = state.todoList[index];
                              var title = todo['title'];
                              return TodoCard(
                                index: index,
                                title: title,
                                taskTitle:
                                    taskTitle.isEmpty ? 'Task' : taskTitle,
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddTodoListBloc, AddTodoState>(
            listener: (context, state) {
              if (state is AddTodoList) {
                setState(() {
                  todoList = state.todoList;
                });
              }
            },
          ),
          BlocListener<TaskFormValidationBloc, TaskFormValidationState>(
            listener: (context, state) {
              if (state is TaskFormValidationValid) {
                log("is valid");
                // get AddTaskParams from the di
                final addTaskParams = sl<AddTaskParams>()
                  ..task = sl<TaskEntity>()
                  ..task.title = taskTitleController.text
                  ..task.category = category!
                  ..task.description = descriptionController.text
                  ..task.dueDate =
                      _singleDatePickerValueWithDefaultValue.isNotEmpty
                          ? _singleDatePickerValueWithDefaultValue[0]!
                          : DateTime.now()
                  ..todo = todoList;

                context
                    .read<TaskFormBloc>()
                    .add(TaskFormAddTask(addTaskParams));
              }
            },
          ),
          BlocListener<TaskFormBloc, TaskFormState>(
            listener: (context, state) {
              if (state is TaskFormAddTaskSuccess) {
                context.pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Task \"${state.task.title}\" Successfully Added"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    width: MediaQuery.of(context).size.width > 600
                        ? 430.0 - 12
                        : MediaQuery.of(context).size.width - 12,
                  ),
                );
              } else if (state is TaskFormAddTaskError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    width: MediaQuery.of(context).size.width > 600
                        ? 430.0 - 12
                        : MediaQuery.of(context).size.width - 12,
                  ),
                );
              }
            },
          ),
        ],
        child: GestureDetector(
          onTap: () {
            context
                .read<TaskFormValidationBloc>()
                .add(TaskFormValidationValidate(
                  taskTitle: taskTitleController.text,
                  taskDueDate: _singleDatePickerValueWithDefaultValue,
                  taskCategory: category,
                  description: descriptionController.text,
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(60),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 4.5),
                ),
              ],
            ),
            child: const Icon(
              Icons.save,
              size: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Colors.purple[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return GestureDetector(
      onTap: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: context,
          config: config,
          dialogSize: const Size(325, 370),
          borderRadius: BorderRadius.circular(15),
          value: _singleDatePickerValueWithDefaultValue,
          dialogBackgroundColor: Colors.white,
        );
        if (values != null) {
          // ignore: avoid_print
          print(_getValueText(
            config.calendarType,
            values,
          ));
          setState(() {
            _singleDatePickerValueWithDefaultValue = values;
          });
        }
      },
      child: BlocBuilder<TaskFormValidationBloc, TaskFormValidationState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(12),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: state is TaskFormValidationInvalid &&
                        state.message['taskDueDate']!.isNotEmpty
                    ? Colors.red
                    : Colors.black,
                width: 1.3,
              ),
              boxShadow: [
                BoxShadow(
                  color: state is TaskFormValidationInvalid &&
                          state.message['taskDueDate']!.isNotEmpty
                      ? Colors.red
                      : Colors.black,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _singleDatePickerValueWithDefaultValue.isEmpty
                      ? 'Select due date'
                      : _getValueText(
                          CalendarDatePicker2Type.single,
                          _singleDatePickerValueWithDefaultValue,
                        ),
                  style: TextStyle(
                    color: state is TaskFormValidationInvalid &&
                            state.message['taskDueDate']!.isNotEmpty
                        ? Colors.red
                        : _singleDatePickerValueWithDefaultValue.isEmpty
                            ? Colors.black54
                            : Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                _singleDatePickerValueWithDefaultValue.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            _singleDatePickerValueWithDefaultValue = [];
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: state is TaskFormValidationInvalid &&
                                  state.message['taskDueDate']!.isNotEmpty
                              ? Colors.red
                              : Colors.black,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
