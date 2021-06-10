# json_serializer guidance

`json_serializer.dart`的功能是将json数据对象编译为dart数据对象，目的是将后端提供的数据序列化为前端Flutter的dart对象，提高前端Flutter代码的内聚性。

## 1. 使用示例

命令: `dart json_serializer.dart -src ./jsons -dist ./lib/serializers`

参数`-src`指定存放json文件的目录，推荐将所有json文件存放在统一的目录中。
参数`-dist`指定存放编译后的dart对象的目录，推荐将所有dart对象文件存放在统一的目录中。

> 全局配置文件: `json_serializer.dart`会自动加载`-src`指定的目录中的全局配置文件`_config.json`

典型的全局配置文件`_config.json`如下:

``` json
{  // 全局配置
    "http_package": "package:flutter_prj/common/http.dart" // 配置http文件
}
```

## 2. json文件

### 2.1 json文件的命名

json文件的命名需使用下划线`_`分隔单词，后缀名必须为`.json`, 例如：`local_store.json`。

如果json文件名以下划线`_`开头，则该文件不会被编译，例如：`_local_store.json`。

### 2.2 json对象

一般一个json文件里只有一个json对象，但是一个json文件也可以包含多个json对象。一个json对象将被编译为一个对应的dart序列化类。

当一个json文件只有一个json对象时，对应的dart序列化类的类名为该json文件名，例如：json文件`local_store.json`对应的dart序列化类的类名将为`LocalStore`。

当一个json文件包含多个json对象时，需要在json对象中使用`"__name__"`来指定序列化类名，`"__name__"`的命名规则和json文件名的命名规则一样。例如：

``` json
// student.json
{
    "name": "",
    "age": 0
}

{
    "__name__": "teacher",
    "name": "",
    "subject": ""
}
```

> 注意：当一个json文件包含多个json对象时，只能有一个没有`"__name__"`的对象，其序列化类的类名为该json文件名转化而来。

## 2.3 json普通数据成员

json对象中的普通数据成员将被编译为序列化类的普通数据成员，将从普通数据成员的赋值中推断出数据类型。

支持如下类型的普通数据成员:

普通数据成员的类型 | 示例 |  序列化类中的类型 | 设置为null
:-- | :-- | :-- | :--
字符串型 | "name": "" | String name = "" | "name":"String=null"
整数型 | "age": 0 | num age = 0 | "age":"num=null"
double型 | "score": 0.0 | double score = 0.0 | "score":"double=null"
bool型 | "gender": false | bool gender = false | "gender":"bool=null"


