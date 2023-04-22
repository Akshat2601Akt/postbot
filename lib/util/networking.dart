import 'package:flutter/foundation.dart';

class PostData extends ChangeNotifier{
  String platform = '';
  String topic = '';

  void setPlatform(String newPlatform) {
    platform = newPlatform;
    notifyListeners();
  }

  void setTopic(String newTopic) {
    topic = newTopic;
    notifyListeners();
  }
}