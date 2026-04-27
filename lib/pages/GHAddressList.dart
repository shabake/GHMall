import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../services/httptool.dart';
//import 'package:common_utils/common_utils.dart';
import '../model/GHAddressModel.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 收货地址列表
class GHAddressList extends StatefulWidget {
  const GHAddressList({Key? key}) : super(key: key);

  @override
  State<GHAddressList> createState() => _GHAddressListState();
}

class _GHAddressListState extends State<GHAddressList> {
  List<Results?> _list = [];

  _getAddressList() async {
    //addressDetails
    //shopAddress
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopAddress";
    var c = Uri.encodeComponent('-createdAt');
    var d = Uri.encodeComponent('李');

    //   --data-urlencode 'scan_key=score' \   \
    //%7Bname:%20%E6%9D%8E%7D
    //%7b%22name%22%3a+%22%e6%9d%8e%22%7d
//    var b = Uri.encodeQueryComponent(map.toString());
    //where={"score": 100}
    //    url = url+'?'+ "limit="+c + "&" + "where="+b;

    url = url + '?' + "order=" + c;

    HttpRequest.request(url, method: 'GET').then((res) {
      var list = new GHAddressModel.fromJson(res).results;
      setState(() {
        this._list = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAddressList();
  }

  @override
  void deactivate() {
    final bool isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    if (isCurrent) {
      _getAddressList();
    }
    super.deactivate();
  }

  Widget ListItem(Results results) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        width: ScreenAdaper.getScreenWidth(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row (
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width:50,
                                child: Text(
                                  results.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style:TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  results.phone ?? "",
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenAdaper.getScreenWidth() - 20 - 20 - 30,
                          child: Text(
                            (results.province ?? "") +
                                (results.city ?? "") +
                                (results.area ?? "") +
                                (results.detailsAddress ?? ""),
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
                GestureDetector(

                  onTap: () {
                    Navigator.pushNamed(context, '/GHAddressEdit', arguments: {
                      'name': "${results.name ?? ""}",
                      'zone': "${results.zone}",
                      'detailsAddress': "${results.detailsAddress ?? ""}",
                      'phoneNumber': results.phone ?? "",
                      'objectId': results.objectId,
                    });
                  },
                  child: Container(
                    child: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/GHAddressEdit');
            },
            child: Icon(Icons.add),
          )
        ],
        title: Text("地址管理"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: () async {
            await _getAddressList();
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListItem(_list[index]!);
            },
            itemCount: _list.length,
          ),
        ),
      ),
    );
  }
}
