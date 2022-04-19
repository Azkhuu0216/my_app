import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  int _point;
  bool _isClick;
  String _selectAnswerId;
  String _uid;
  int _check;

  MainProvider(
      this._point, this._isClick, this._selectAnswerId, this._uid, this._check);

  getPoint() => _point;
  getIsClick() => _isClick;
  getSelectAnswerId() => _selectAnswerId;
  getUid() => _uid;
  getCheck() => _check;

  setPoint(int point) {
    _point = point;
    notifyListeners();
  }

  setIsClick(bool isClick) {
    _isClick = isClick;
    notifyListeners();
  }

  setSelectAnswerId(String selectAnswerId) {
    _selectAnswerId = selectAnswerId;
    notifyListeners();
  }

  setUId(String uid) {
    _uid = uid;
    notifyListeners();
  }

  setCheck(int check) {
    _check = check;
    notifyListeners();
  }
}
