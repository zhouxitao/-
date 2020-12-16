import 'package:scoped_model/scoped_model.dart';
import 'package:hook_rent/model/general_type.dart';

class CityModel extends Model {
  GeneralType _city;

  set city(GeneralType data){
    _city = data;

    notifyListeners();
  }

  GeneralType get city{
    return _city;
  }
}