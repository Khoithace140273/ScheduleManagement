import 'package:untitled/page/Models/Task.dart';

class TaskDAO {
  late String _errorMsg;
  late bool _isLoading;
  late Task _task;
  TaskDAO() {
    _errorMsg = '';
    _isLoading = false;
    _task = new Task('', false, '', '', '');
  }

  get task => this._task;

  set task(value) => this._task = value;

  bool get isLoading => this._isLoading;

  set isLoading(bool value) => this._isLoading = value;

  String get errorMsg => this._errorMsg;

  set errorMsg(String value) => this._errorMsg = value;
}
