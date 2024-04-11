enum TodoPriority {
  none,
  low,
  medium,
  high,
}

class Todo {
  final String content;
  final bool isDone;
  final TodoPriority priority;
  Todo({
    required this.content,
    required this.isDone,
    required this.priority,
  });

  String get priorityText {
    switch (priority) {
      case TodoPriority.low:
        return '!';
      case TodoPriority.medium:
        return '!!';
      case TodoPriority.high:
        return '!!!';
      default:
        return '';
    }
  }

  Todo copyWith({
    String? content,
    bool? isDone,
    TodoPriority? priority,
  }) {
    return Todo(
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }
}
