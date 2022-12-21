import 'dart:io';
void main() {

  List<int> ticket1=[12,2,0,18,12,33];
  List<int> ticket2=[41,17,26,32,7,35];

  checkNumbers(ticket1);


  //pieMaker();
  // buyMilk(1);

}



List<int> winingNumbers=[12,6,34,22,41,9];

void checkNumbers(List<int> myNumbers) {
    //parametre olark dizi degerleri atiyoz ve burda kontrol ediyoz ve  eger iki dizid'de benzer sayilar varsa kac tane yazdirsin
    int matches=0;
    for(int myNum in myNumbers) {
      for(int winingNum in winingNumbers) {
        if(myNum==winingNum) {
          matches++;

        }
      }
    }
    print('you got ${matches} matches');

    //iki farkli dizilerde esit sayilari bulmak icin 2. yolu asgada
/*  int b=0;
  for(int i=0; i< winingNumbers.length;i++ ){
    for(int j=0; j< myNumbers.length;j++ )
    {
        if(winingNumbers[i] == myNumbers[j]) {
     b++;
    }
    }

    }

   print('you got $b matches');*/


}



List<String> fruits=[
  'apple',
  'pear',
  'orange',
  'grape'
];

void pieMaker() {
  for(String fruit in fruits) {
    print(fruit + ' pie');
  }
}



void buyMilk(int days) {
  for(int i=10;i>days;i--){

    print('$i bottles of beer on the wall, $i bottles of beer.Take one down and pass it around, ${i-1} bottles of beer on the wal ');
    if(i==2) {
      print('bottles finished');
    }

  }
}