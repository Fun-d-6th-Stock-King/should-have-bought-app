import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:should_have_bought_app/providers/dummy.dart';

List<SingleChildWidget> kProviders = [
  // Example
  ChangeNotifierProvider(
    create: (context) => Dummy(),
  ),
];
