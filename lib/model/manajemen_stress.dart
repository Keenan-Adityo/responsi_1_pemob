class ManajemenStress {
  int? id;
  String? stress_factor;
  String? coping_strategy;
  int? stress_level;

  ManajemenStress(
      {this.id, this.stress_factor, this.coping_strategy, this.stress_level});

  factory ManajemenStress.fromJson(Map<String, dynamic> obj) {
    return ManajemenStress(
      id: obj['id'],
      stress_factor: obj['stress_factor'],
      coping_strategy: obj['coping_strategy'],
      stress_level: obj['stress_level'],
    );
  }

  static List<ManajemenStress> fromJsonList(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return list
        .map((stressData) => ManajemenStress.fromJson(stressData))
        .toList();
  }
}
