class LanguageModel {
  
  final String countryFlag;
  final String languageName;

  LanguageModel({required this.countryFlag,required this.languageName});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      countryFlag: json['countryCode'],
      languageName: json['languageName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'countryCode': countryFlag,
        'languageName': languageName,
      };

  @override
  String toString() {
    return 'LanguageModel{countryCode: $countryFlag, languageName: $languageName}';
  }
}
