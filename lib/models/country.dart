class Country{
  late String name;
  late String urlFlag;
  late String currency;
  Country({required this.name,required this.urlFlag,required this.currency});
}

final List<Country> datas = [
  Country(
    name: 'RU', 
    urlFlag: 'russia.png', 
    currency: 'RUB'
  ),
  Country(
    name: 'USA', 
    urlFlag: 'russia.png', 
    currency: 'USD'
  ),
  Country(
    name: 'EU', 
    urlFlag: 'russia.png', 
    currency: 'EUR')
];