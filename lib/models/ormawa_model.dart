class OrmawaModel {
  final int id;
  final String name;
  final String shortName;
  final String category; // Contoh: BEM, MPM, UKM, HMJ
  final String faculty;  // Contoh: Universitas, FTK, FIP, FMIPA, dll.
  final String description;
  final String vision;
  final String logoUrl;
  final String instagram;
  final bool isOpenRecruitment;

  OrmawaModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.category,
    required this.faculty,
    required this.description,
    required this.vision,
    required this.logoUrl,
    required this.instagram,
    required this.isOpenRecruitment,
  });

  factory OrmawaModel.fromJson(Map<String, dynamic> json) {
    return OrmawaModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? 'Nama Ormawa Tidak Tersedia',
      shortName: json['short_name']?.toString() ?? '-',
      category: json['category']?.toString() ?? 'UKM',
      faculty: json['faculty']?.toString() ?? 'Universitas',
      description: json['description']?.toString() ?? 'Belum ada deskripsi.',
      vision: json['vision']?.toString() ?? '-',
      logoUrl: json['logo_url']?.toString() ?? '',
      instagram: json['instagram']?.toString() ?? '@ormawa_undiksha',
      isOpenRecruitment: json['is_open_recruitment'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'category': category,
      'faculty': faculty,
      'description': description,
      'vision': vision,
      'logo_url': logoUrl,
      'instagram': instagram,
      'is_open_recruitment': isOpenRecruitment,
    };
  }
}