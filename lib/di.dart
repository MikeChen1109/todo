import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_example/domain/entity/todo.dart';
import 'package:todo_example/presentation/todo/notifier/todo_list_notifier.dart';

final todoListProvider =
    NotifierProvider<TodoListNotifier, List<Todo>>(TodoListNotifierImpl.new);
