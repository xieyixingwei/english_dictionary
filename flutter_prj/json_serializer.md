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
字符串型 | "name": "" | String name = "" | "name": "String=null"
整数型 | "age": 0 | num age = 0 | "age": "num=null"
double型 | "score": 0.0 | double score = 0.0 | "score": "double=null"
bool型 | "gender": false | bool gender = false | "gender": "bool=null"
List型 | "subjects": [""] | List<String> subjects = [] | 

List类型的成员类型也是从复制中推断的，其支持以下基础类型: 字符串型、整数型、double型、bool型。例如：`"scores": [92.5, 87.2]`等。

## 2.4 序列化类类型的成员

json对象中也可以定义json对象类型的成员，编译后将生成对应的序列化类类型的成员。

例如：有两个json对象`teacher`和`class`:

``` json
// teacher.json
{
    "name": "",
    "subject": ""
}
```

``` json
// class.json
{
    "label": "",
    "mainTeacher": "$teacher"  // 在序列化类中的成员 mainTeacher 的类型是 Teacher
}
```

当然`List`的成员类型也支持json对象类型，例如：

``` json
// class.json
{
    "label": "",
    "teachers": ["$teacher"]  // 在序列化类中的成员 teachers 的类型是 List<Teacher>
}
```

## 2.5 文件类型

客户端需要上传文件（普通文件、图片、视频、音频），服务器端返回的json中就会包含文件的超链接（字符串型），可以如下指定文件类型的字段：

``` json
{
    "image": "$SingleFile image", 
    "vedio": "$SingleFile video"
}
```

## 2.6 和数据库表的对应

我们知道数据库表之间有三种关系：多对一（many to one）、多对多（many to many）、一对一（one to one）。

为了序列化服务器直接返回的数据库表，`json_serializer.dart`提供了4个装饰器来装饰成员：

1. 主键: `@pk`，标识该成员是主键，并会自动产生一个加了下划线的同名成员。
2. 外键(多对一): `@fk_mo`，标识该成员是多对一外键，例如：`"mainTeacher @fk_mo": "$teacher"`，其对应的类型为`teacher`的主键类型。
3. 外键(多对多): `@fk_mm`，标识该成员是多对多外键，例如：`"teachers @fk_mm": ["$teacher"]`，其对应的类型为`teacher`的主键类型列表。
4. 外键(一对一): `@fk_oo`，标识该成员是一对一外键，例如：`"detail @fk_oo": "$information"`，其对应的类型为`information`的主键类型。

举例说明:

``` json
// teacher.json
{
    "name @pk": "",
    "subject": ""
}
```

``` json
// class.json
{
    "id @pk": "num=null",
    "label": "",
    "mainTeacher @fk_mo": "$teacher",  // 在序列化类中的成员mainTeacher的类型是teacher的主键类型 String
    "teachers @fk_mm": ["$teacher"],   // 在序列化类中的成员teachers的类型是teacher的主键类型String的列表 List<String>
}
```

``` json
// information.json
{
    "id @pk"
    "count": 0,
    "class @fk_oo": "$class", // 在序列化类中的成员class的类型是class的主键类型 num
}
```

有时服务器返回的数据库表中的外键是对应的数据表，而不是数据表的主键，这时就需要在数据表关系装饰器的基础上使用`@nested`装饰器。

- `@nested`标识成员是嵌套数据结构的外键，例如：
  - `"mainTeacher @fk_mo @nested": "$teacher"`，mainTeacher 的类型为 `Teacher`。
  - `"teachers @fk_mm @nested": ["$teacher"]`，teachers 的类型为 `List<Teacher>`。
  - `"detail @fk_oo @nested": "$information"`，detail 的类型为 `Information`。

## 2.7 序列化类方法

将json对象序列化为dart类后，自动提供了以下三个方法：

1. `TSerializer fromJson(Map<String, dynamic> json)`: 用于序列化服务器返回的json数据。
2. `Map<String, dynamic> toJson()`: 反序列化，用于将序列化类的数据反序列化为服务器需要的json数据。
3. `TSerializer from(TSerializer instance)`: 深拷贝赋值，用于同类型的不同序列化类实例之间的深拷贝赋值。

默认所有的数据成员都会在以上三个函数中，为了提高灵活性，方便控制数据成员是否需要序列化、反序列化、深拷贝？

例如为数据对象添加一些额外的数据成员，而这些成员又不需要与服务器进行交互，所以就不需要序列化和反序列化这种数据成员，即函数`fromJson()`和`toJson()`中不需要包含这种数据成员。

1. 名字以一个下划线`_`开头的数据成员将不被反序列化，即`toJson()`中不包含该成员。
2. 名字以两个下划线`__`开头的数据成员将不被反序列化和序列化，即`fromJson()`和`toJson()`中都不包含该成员。

> 注意：建议不要直接使用等号`=`赋值，而要使用函数`from()`深拷贝赋值，例如，当序列化类之间有循环引用的时候，`=`赋值会导致再使用`from()`进入死循环。

## 2.8 为序列化类添加http方法

除了将服务器返回的json对象数据序列化为dart数据对象外，还提供了一个提高前端代码内聚性的特性：为序列化类添加http方法。

方法是在json对象中添加名为`__http__`的子对象，例如：

``` json
// teacher.json
{
    "name": "",
    "subject": "",
    "__http__": { // 为序列化类添加http方法
        "url": "/api/teachers/", // 该资源的url
        "methods": [             // 方法列表
            {
                "name": "create"    // create 方法，默认使用 POST 请求，如果没有指定url，则使用父url
            },
            {
                "name": "update",   // update 方法，默认使用 PUT 请求，如果有指定url，则使用 父url + 指定的url
                "url": "$name/"
            },
            {
                "name": "retrieve", // retrieve 方法，默认使用 GET 请求，如果有指定url，则使用 父url + 指定的url
                "url": "$name/"
            },
            {
                "name": "list",     // list 方法，默认使用 GET 请求，如果没有指定url，则使用 父url
            },
            {
                "name": "delete",   // delete 方法，默认使用 DELETE 请求，如果有指定url，则使用 父url + 指定的url
                "url": "$name/"
            },
            {
                "name": "save"     // save 方法，前提是添加了 create 或 update 方法之一，或两个都添加了。
            }
        ]
    }
}
```

> 注意: 根据需求添加 http方法，移出不必要的方法。

当然除了`create`、`update`、`retrieve`、`list`、`delete`、`save`标准命令的方法外，还可以添加自命名的其它方法，例如考虑到 `user.json`可以提供`register`和`login`两个方法：

``` json
// user.json
{
    "uname": "",
    "passwd": "",
    "__http__": {
        "url": "/api/users/",
        "methods": [
            {
                "name": "register",   // 方法名为 register，使用 POST 请求，如果有指定url，则使用 父url + 指定的url
                "requst": "post",     // 指定使用 POST 请求
                "url": "register/"
            },
            {
                "name": "login", // 方法名为 login，使用 GET 请求，如果有指定url，则使用 父url + 指定的url
                "requst": "get", // 指定使用 GET 请求
                "url": "login/"
            },
            {
                "name": "list",     // list 方法，默认使用 GET 请求，如果没有指定url，则使用 父url
            },
            {
                "name": "delete",   // delete 方法，默认使用 DELETE 请求，如果有指定url，则使用 父url + 指定的url
                "url": "$uname/"
            }
        ]
    }
}
```

> 注意：自命名方法需要使用 `requst` 指定请求类型，有 get, post, put, delete等。

## 2.9 过滤器

为了支持对服务端数据的条件查询，可以使用`__filter__`字段指定过滤器，过滤器的字段名字必须能和父json对象的字段名字对应。
过滤器字段的值是列表型，通过`"exact"`，`"icontains"`等来指定字段支持的过滤条件。

``` json
{
    "name @pk": "",
    "age": 0,
    "gender": false,
    "__filter__": {
        "__serializer__": "$word",
        "name": ["exact","icontains"], // 在序列化类中将生成 String name 和 String name_icontains 字段，其类型是父json对象的name字段的类型。
        "age": ["lte", "gte"],         // 在序列化类中将生成 num age_lte 和 age_gte 字段
        "gender": ["exact"]            // 在序列化类中将生成 gender 字段
    }
}
```
