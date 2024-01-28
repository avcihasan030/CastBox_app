import 'package:final_year_project/DATA/Models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User>(
    (ref) => User(name: 'Tommy Angelo', email: 'username@gmail.com'));
