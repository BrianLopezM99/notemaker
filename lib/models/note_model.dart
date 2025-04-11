class Note {
  final int? id;
  final String title;
  final String content;
  final String date;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // Método toMap para convertir el objeto a Map (para la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  // Método factory para convertir el Map a un objeto Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }

  // Método copyWith para crear una nueva instancia con valores modificados
  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
