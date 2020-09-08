import 'sp.dart';

typedef TypeSerialize<T> = dynamic Function(T value);
typedef TypeDeserialize<T> = T Function(dynamic value);

class CacheData<T> {
  final TypeSerialize<T> _serialize;
  final TypeDeserialize<T> _deserialize;

  CacheData(this._tag,
      {T defaultValue,
      TypeSerialize<T> serialize,
      TypeDeserialize<T> deserialize})
      : _serialize = serialize,
        _deserialize = deserialize {
    _data = _load(defaultValue);
  }

  final String _tag;
  T _data;

  T get data {
    return _data;
  }

  set data(T data) {
    _data = data;
    _save();
  }

  T _load(T defaultValue) {
    final data = SP.instance?.get(_tag);
    if (null == data) {
      return defaultValue;
    }

    if (null != _deserialize) {
      try {
        return _deserialize(data) ?? defaultValue;
      } catch (e) {
        return _data;
      }
    }
    return data ?? defaultValue;
  }

  Future<bool> _save() async {
    if (_data != null) {
      var data;

      if (null != _serialize) {
        try {
          data = _serialize(_data);
        } catch (e) {
          data = null;
        }
      } else {
        data = _data;
      }

      if (data is double) {
        return SP.instance.setDouble(_tag, data);
      } else if (data is int) {
        return SP.instance.setInt(_tag, data);
      } else if (data is String) {
        return SP.instance.setString(_tag, data);
      } else if (data is bool) {
        return SP.instance.setBool(_tag, data);
      } else {
        return false;
      }
    } else {
      return SP.instance.remove(_tag);
    }
  }
}
