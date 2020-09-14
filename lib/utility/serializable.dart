import 'dart:convert' as Json;

abstract class Serializable<T> {
  T deserialize(dynamic data);

  String serialize(T obj) {
    return "";
  }
}

abstract class CustomSerializable<T> extends Serializable<T> {}

class StringSerializable implements Serializable<String> {
  @override
  String deserialize(data) {
    if (data is String) {
      return data;
    }
    try {
      return Json.json.encode(data);
    } catch (e) {
      print("Serializable deserialize failed ${e?.toString()}");
    }
    return null;
  }

  @override
  String serialize(String data) {
    return data;
  }
}

final Serializable<String> stringSerialize = StringSerializable();
