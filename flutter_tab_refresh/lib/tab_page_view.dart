/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/2 0002
/// email: maoqitian068@163.com
/// des:  
import 'package:flutter/material.dart';
import 'package:flutter_tab_refresh/list_view_item.dart';
import 'package:flutter_tab_refresh/refresh/refresh_page.dart' as listComp;
import 'package:flutter_tab_refresh/refresh/refresh_page.dart';

import 'bean/article_data.dart';


class TabPageView extends StatefulWidget {

  final String title;

  TabPageView(this.title);

  @override
  _TabPageViewState createState() => _TabPageViewState();
}

class _TabPageViewState extends State<TabPageView> with AutomaticKeepAliveClientMixin<TabPageView>{

  // 加入AutomaticKeepAliveClientMixin 防止页面重绘
  @override
  bool get wantKeepAlive => true;

  Widget buildCard(index,data){

    return ListViewItem(articleData: data);
  }

  //构造假数据
  Future<Map> getPageListData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    bool isRefresh = (params is Map) ? params['isRefresh'] : false;

    if(pageIndex == 0&& !isRefresh){ //置顶 数据 正常列表数据 同时请求 第一次请求
      List<ArticleData> articleAllList = [];

      for(int i = 0; i<=10;i++){
        ArticleData articleData = new ArticleData();
        articleData.title = widget.title+"总冠军"+i.toString();
        articleData.des = widget.title+"总灌军描述"+i.toString();
        articleAllList.add(articleData);
      }
      pageIndex++;
      //延迟3秒
      await Future.delayed(Duration(seconds: 2), () {
        return [];
      });
      return  {"list":articleAllList, 'total':2, 'pageIndex':pageIndex};
    }else if(pageIndex == 0 && isRefresh){ //模拟下拉刷新数据
      List<ArticleData> articleAllList = [];

      for(int i = 0; i<=10;i++){
        ArticleData articleData = new ArticleData();
        articleData.title = widget.title+"总冠军 下拉刷新数据"+i.toString();
        articleData.des = widget.title+"总灌军描述 下拉刷新数据"+i.toString();
        articleAllList.add(articleData);
      }
      pageIndex++;
      //延迟3秒
      await Future.delayed(Duration(seconds: 2), () {
        return [];
      });
      return  {"list":articleAllList, 'total':2, 'pageIndex':pageIndex};
    } else{
      //正常列表数据 加载更多
      List<ArticleData> articleAllList = [];
      for(int i = 0; i<=10;i++){
        ArticleData articleData = new ArticleData();
        articleData.title = widget.title+"总冠军 加载更多数据 "+i.toString();
        articleData.des = widget.title+"总灌军描述 加载更多数据"+i.toString();
        articleAllList.add(articleData);
      }
      //延迟3秒
      await Future.delayed(Duration(seconds: 2), () {
        return [];
      });
      Map<String, dynamic> result = {"list":articleAllList, 'total':2, 'pageIndex':pageIndex++};
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return /*Container(
        child: Center(
          child: Text(widget.title),
        ),
    );*/
     Column(
      children: <Widget>[
        new Expanded(
          //child: listComp.ListRefresh(getIndexListData,makeCard,headerView)
            child: RefreshPage(requestApi: getPageListData,renderItem: buildCard) //不需要头部
        )
      ],
    );
  }
}




