class CountryModel {
  final String name;
  final String flag;

  CountryModel({required this.name, required this.flag});

 

  static final List<CountryModel> countries = [
    CountryModel(name: 'United States', flag: '🇺🇸'),
    CountryModel(name: 'Egypt', flag: '🇪🇬'),
    CountryModel(name: 'Malaysia', flag: '🇲🇾'),
    CountryModel(name: 'Singapore', flag: '🇸🇬'),
    CountryModel(name: 'Indonesia', flag: '🇮🇩'),
    CountryModel(name: 'Philippines', flag: '🇵🇭'),
    CountryModel(name: 'Polandia', flag: '🇵🇱'),
    CountryModel(name: 'India', flag: '🇮🇳'),
    CountryModel(name: 'Vietnam', flag: '🇻🇳'),
    CountryModel(name: 'China', flag: '🇨🇳'),
    CountryModel(name: 'Canada', flag: '🇨🇦'),
    CountryModel(name: 'Saudi Arabia', flag: '🇸🇦'),
    CountryModel(name: 'Argentina', flag: '🇦🇷'),
    CountryModel(name: 'Brazil', flag: '🇧🇷'),
  ];
}
