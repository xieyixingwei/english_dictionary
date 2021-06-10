# json_serializer guidance

json_serializer.dart将json数据对象编译为dart数据对象，目的是用于将后端提供的数据序列化为前端Flutter的dart对象，提高前端Flutter代码的内聚性。

## 1. 使用示例

命令: `dart json_serializer.dart -src ./jsons -dist ./lib/serializers`

参数`-src`指定存放json文件的目录，推荐将所有json文件存放在统一的目录中。
参数`-dist`指定存放编译后的dart对象的目录，推荐将所有dart对象文件存放在统一的目录中。

> 全局配置文件: `json_serializer.dart`会自动加载`-src`指定的目录中的全局配置文件`_config.json`

典型的全局配置文件如下:

``` json
{  // 全局配置
    "http_package": "package:flutter_prj/common/http.dart" // 配置http文件
}
```

## 2. json文件

### 2.1 json文件的命名

json文件的命名需使用下划线`_`分隔单词，后缀名必须为`.json`, 例如：`_local_store.json`。

如果json文件名以下划线`_`开头，则该文件不会被编译，例如：`_local_store.json`。

