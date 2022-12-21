import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io'show Platform ;//show demeki bu paketen sadece bu class(Platform) bize goser yada kullanmaya izin ver
import 'coin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'crypto+card.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
CoinData getJsonData=CoinData( );
String selectedCurrency = 'USD';
String rate='?';

//value had to be updated into a Map to store the values of all three cryptocurrencies.
  //gelen key ve value'lar Map turunden oldugu icin burda da Map degiskene atmamiz lazim
Map<String, String> coinValues = {};
//7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
bool isWaiting = false;


void upDateUI() async{
  bool isWaiting=true;//degerlerin gelmesini bekleyince true yapcz
  try {
    var data=await getJsonData.getCoinData(selectedCurrency);//Coin bilgileri beklememiz lazim sonra bi degiskene atiyoz yoksa calismaz
  //We can't await in a setState(). So you have to separate it out into two steps.
    isWaiting=false;//degerler geldikten sonra false yapiyoz
    setState(() {
      // a map containing the values/rates
      coinValues = data;
      print(coinValues);
    });
  }
  catch(e) {
    print(e);
  }

}

  void initState() {//ekrani aciktan yada calistirdiktan sonra icndeki kod direk calisir
    // TODO: implement initState
    super.initState();
    upDateUI();//bu fonksyunu direk calistirmak icin initState icinde koyariz


  }

/*  Column makeCards() {
   List<CryptoCard> cryptoCards = [];
   for (String crypto in cryptoList) {
     //bu dongu her dondugunde cryptoCards listesine bi widget ekleycz ve her widget icin sirayla key=BTC ve valuse=curency boylece 3 widget yazdirack
     cryptoCards.add(
       CryptoCard(
         cryptoCurrency: crypto,
         selectedCurrency: selectedCurrency,
         value: isWaiting ? '?' : coinValues[crypto],
       ),
     );
   }
   return Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: cryptoCards,
   );
 }*/

DropdownButton getButtonAndroid() {

  //bu List DropdownMenuItems tipinden degisken almasi lazim ve bu DropItems String turunden deger almasi lazim yoksa bu fonks calismaz
  List<DropdownMenuItem<String>> dropDownItems = [];
  for (String eleman in currenciesList) {
    /*  //for dongusu icinde her calistiginda dizinin elemanlari tek tek bi string degiskene atiyoz
    //bu String degisken drpoDownItem icinde yazdiroyz Text icin ve value icin ayni olmasi lazim sonra newItem degiskene atioz
    //widget tipinden bi List olusturduk yukrda ve ona DropDounItems elemnlari add fonks ile For dongusu her donudugunde ona ekleyoz/atiyoz
    //ve boylece Liste'nin elemanlari/para adilari tek tek ekleyebiliriz sonra bu widget tipinden list'nin degiskeni
    for(int i=0 ; i<currenciesList.length;i++) {
           String tempValue=currenciesList[i];*/
    var newItem = DropdownMenuItem(
      child: Text(eleman),
      value: eleman,
    ); //secenekler icn Text icindeki adi ve Value adi ayni olmasi lazim yoksa calismaz
    //value  secince value deger onChange'e gider ve orda degeri yazdirabiliyoz yada baska yere atabilyoz
    dropDownItems.add(newItem);
  }

  return DropdownButton<String>(
      value: selectedCurrency, //Listenin basinda hem baslangic hemde son sectigmiz deger gostercek .we can specify a starting value
      dropdownColor: Colors.lightBlueAccent,
      elevation: 5,
      icon: Icon(Icons.monetization_on_sharp),
      items: dropDownItems,
//onChage ozelligi yazmazsak list icindeki secenekler cikmaz ekranda
//value  secince value degeri onChange'e gider ve orda degeri yazdirabiliyoz yada baska yere atabilyoz
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          upDateUI();
        });
      });
}



CupertinoPicker getPickerIOS() {
  List<Text> pickerItems = [];
  //bu for dongusu her seferde 1'den fazla Text widgeti yazmamak icin kullaniyoz
  for (String eleman in currenciesList) {
    dynamic newItem = Text(eleman);
    pickerItems.add(newItem);
  }

  return CupertinoPicker(
//iphone widgetleri boyle kullanilir
    itemExtent: 50.0, //listenin ekranda uzunlugu
    onSelectedItemChanged: (selectedImdex) {
//sectigmiz secenegin indexi '0dan basliyo
    setState(() {
      //boyle tip widgetlar index veriyo oYuzden lise icinde koyariz ona gore liste icndeki degerleri alip baska degiskene atabiliriz
    selectedCurrency= currenciesList[selectedImdex];
    upDateUI();
    });

    },
    children:pickerItems,
    backgroundColor: Colors.lightBlueAccent,
  );

}


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('💰 Coin Ticker'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        CryptoCard(
          cryptoCurrency: 'BTC',
          //Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
          value: isWaiting ? '?' : coinValues['BTC'],
          selectedCurrency: selectedCurrency,
        ),
        CryptoCard(
          cryptoCurrency: 'ETH',
          value: isWaiting ? '?' : coinValues['ETH'],
          selectedCurrency: selectedCurrency,
        ),
        CryptoCard(
          cryptoCurrency: 'LTC',
          value: isWaiting ? '?' : coinValues['LTC'],
          selectedCurrency: selectedCurrency,
        )

          ],
        ),
        bottomSheet: Container(
            alignment: Alignment.center,
            color: Colors.blue[400],
            height: 150,
            child:getButtonAndroid()
        ) ,
      ),
    );
  }


}
