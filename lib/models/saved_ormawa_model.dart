class SavedOrmawaModel {
  final int? id;
  final String studentNim;
  final int ormawaId;
  final String ormawaName;
  final String category;
  final String targetDivision;
  final String note;
  final int priority; // Skala 1 - 5
  final DateTime? createdAt;

  SavedOrmawaModel({
    this.id,
    required this.studentNim,
    required this.ormawaId,
    required this.ormawaName,
    required this.category,
    required this.targetDivision,
    required this.note,
    required this.priority,
    this.createdAt,
  });

  factory SavedOrmawaModel.fromJson(Map<String, dynamic> json) {
    return SavedOrmawaModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      studentNim: json['student_nim']?.toString() ?? '',
      ormawaId: json['ormawa_id'] is int
          ? json['ormawa_id']
          : int.tryParse(json['ormawa_id']?.toString() ?? '0') ?? 0,
      ormawaName: json['ormawa_name']?.toString() ?? '',
      category: json['category']?.toString() ?? 'UKM',
      targetDivision: json['target_division']?.toString() ?? 'Anggota Umum',
      note: json['note']?.toString() ?? '',
      priority: json['priority'] is int
          ? json['priority']
          : int.tryParse(json['priority']?.toString() ?? '3') ?? 3,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'student_nim': studentNim,
      'ormawa_id': ormawaId,
      'ormawa_name': ormawaName,
      'category': category,
      'target_division': targetDivision,
      'note': note,
      'priority': priority,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'target_division': targetDivision,
      'note': note,
      'priority': priority,
    };
  }
}
