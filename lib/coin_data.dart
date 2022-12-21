import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinData {
  var coinApiUrl='https://rest.coinapi.io/v1/exchangerate';
  var apikey = 'YOUR API KEY';



  Future<dynamic> getCoinData(dynamic currency ) async {
//Map turunden bi degisken olusturyoz iki tane parametere alack ikisi String tipinden biri key/anahtar karşısında value/deger olack
    Map<String,String> cryptoPrices={};
    for(String crypto in cryptoList) {
      var urL = Uri.parse('$coinApiUrl/$crypto/$currency?apikey=$apikey');
      http.Response response = await http.get(urL);//Response classi bilgi almak icin zaman alabilir oYuzden Future ile yazilmis ve oYuzden get fonks await ile calismasi lazim
      if (response.statusCode == 200) {
        var data = response.body;
        var jsonData = jsonDecode(data); //kodCozucu/ Json'dan bilgi almak icin
        double rateValue = jsonData['rate'];

        // key value pair , key(crypto symbol) and value(lastPrice)
        // the values of each cryto will be stored in a map(cryptoPrices)
        //dongu her dondugunde 1. eleman/cryptoType map'a atilack onun karşisinda value/degeri olack curencey/paraBirimi.ve iki input String olack map gore
        //the key being the crypto symbol and the value being the lastPrice of that crypto currency.
       cryptoPrices[crypto]=rateValue.toStringAsFixed(0);

      } else {
        print(response.statusCode);
        throw'Problem with the get request';
      }
    }
    print('nothing wrong');
    //bu Map degiskeninde 3 tur coin tipi var anahtar olark ve parabirmi/curencey degsince ona gore deger/value alacz ona gore
return cryptoPrices;
  }
}
const List<String> currenciesList =[
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList =[
  'BTC',
  'ETH',
  'LTC',
];
