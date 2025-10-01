class Task {
  final int? id;
  final String title;
  final String description;
  final String priority; // 'high' | 'medium' | 'low'
  final String category; // 'work' | 'personal' | 'shopping'
  final DateTime? startDate;
  final DateTime? endDate;
  final String status; // 'pending' | 'completed'

  const Task({
    this.id,
    required this.title,
    required this.description,
    this.priority = 'medium',
    this.category = 'personal',
    this.startDate,
    this.endDate,
    this.status = 'pending',
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? priority,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: (map['description'] ?? '') as String,
      priority: (map['priority'] ?? 'medium') as String,
      category: (map['category'] ?? 'personal') as String,
      startDate: map['startDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['endDate']) : null,
      status: (map['status'] ?? 'pending') as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'category': category,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'status': status,
    };
  }
}
