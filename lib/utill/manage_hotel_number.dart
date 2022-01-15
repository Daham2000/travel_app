import 'package:shared_preferences/shared_preferences.dart';

class ManageHotelNumber{

  void saveNumber()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int hotelNumber = (prefs.getInt('hotelNumber') ?? 0) + 1;
    print('Pressed $hotelNumber times.');
    if(hotelNumber>4){
      await prefs.setInt('hotelNumber', 0);
    }else{
      await prefs.setInt('hotelNumber', hotelNumber);
    }
  }

  Future<int> getNumber()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int hotelNumber = prefs.getInt('hotelNumber') ?? 0;
    return hotelNumber;
  }

}