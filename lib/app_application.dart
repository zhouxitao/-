import 'package:flutter/material.dart';
import 'package:hook_rent/config/application.dart';
import 'package:fluro/fluro.dart';
import 'package:hook_rent/config/routes.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/pages/scoped_model/city.dart';
import 'package:hook_rent/pages/scoped_model/room_filter.dart';
import 'package:scoped_model/scoped_model.dart';


class ApplicationPage extends StatefulWidget {
  ApplicationPage({Key key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {

  @override
  Widget build(BuildContext context) {

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return  ScopedModel(
      model: CityModel(),
      child: ScopedModel<AuthModel>(
        model: AuthModel(),
        child: ScopedModel<FilterBarModel>(
          model: FilterBarModel(),
          child: MaterialApp(
            title: 'Fluro',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Application.router.generator,
            theme: ThemeData(
              primaryColor: Colors.green,
            ),
            initialRoute: Routes.loading,
          )
        )
      )
    );
  }
}