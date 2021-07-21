import 'package:untitled/page/Models/Note.dart';

class NoteDAO {
  late String _errorMsg;
  late bool _isLoading;
  late Note _note;
  NoteDAO() {
    _errorMsg = '';
    _isLoading = false;
    _note = new Note('', '', '', '');
  }

  get task => this._note;

  set task(value) => this._note = value;

  bool get isLoading => this._isLoading;

  set isLoading(bool value) => this._isLoading = value;

  String get errorMsg => this._errorMsg;

  set errorMsg(String value) => this._errorMsg = value;
}
