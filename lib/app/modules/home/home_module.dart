import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/home/home_page.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_controller.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (contect) => HomeController(),
            ),
          ],
          routers: {
            '/home': (context) => HomePage(),
          },
        );
}
