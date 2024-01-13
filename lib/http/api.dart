import 'package:flutter/material.dart';
enum Api {

  channelOptions('渠道配置','v1/channel/options'),
  newUserCheck('新版撞库','v2/user/check'),


  theLast('','');
  final String desc;
  final String path;
  const Api(this.desc,this.path);

}