import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';
import 'package:sembast/sembast.dart';

class OpenDatabase {
  final LocalRepository localRepository;
  OpenDatabase({
    required this.localRepository,
  });

  Future<Database> call() {
    return localRepository.openDatabase();
  }
}
