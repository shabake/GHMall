import 'dart:convert';
import 'Storage.dart';
import '../config/Config.dart';

class CartServices {
  static addCart(item) async {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    /*
      1、获取本地存储的cartList数据
      2、判断cartList是否有数据
            有数据：
                1、判断购物车有没有当前数据：
                        有当前数据：
                            1、让购物车中的当前数据数量 等于以前的数量+现在的数量
                            2、重新写入本地存储

                        没有当前数据：
                            1、把购物车cartList的数据和当前数据拼接，拼接后重新写入本地存储。

            没有数据：
                1、把当前商品数据以及属性数据放在数组中然后写入本地存储



                List list=[
                  {"_id": "1",
                    "title": "磨砂牛皮男休闲鞋-有属性",
                    "price": 688,
                    "selectedAttr": "牛皮 ,系带,黄色",
                    "count": 4,
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  },
                    {"_id": "2",
                    "title": "磨xxxxxxxxxxxxx",
                    "price": 688,
                    "selectedAttr": "牛皮 ,系带,黄色",
                    "count": 2,
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  }

                ];


      */

    try {
      List cartListData = json.decode(await Storage.getString('cartList'));

      //判断购物车有没有当前数据
      bool hasData = cartListData.any((value) {
        return value['_id'] == item['_id'] &&
            value['seletecAttr'] == item['seletecAttr'];
      });

      if (hasData) {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == item['_id'] &&
              cartListData[i]['seletecAttr'] == item['seletecAttr']) {
            cartListData[i]["count"] = cartListData[i]["count"] + 1;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (e) {
      List tempList = [];
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  //过滤数据
  static formatCartData(item) {
    //处理图片
    String pic = item.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['seletecAttr'] = item.seletecAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    data['checked'] = true;
    return data;
  }
}
