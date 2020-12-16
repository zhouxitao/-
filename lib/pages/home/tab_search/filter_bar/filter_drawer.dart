import 'package:flutter/material.dart';
import 'package:hook_rent/model/general_type.dart';
import 'package:hook_rent/pages/scoped_model/room_filter.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/widgets/common_title.dart';

class FilterDrawer extends StatefulWidget {
  FilterDrawer({Key key}) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {

    var dataList = ScopedModelHelper.getModel<FilterBarModel>(context).dataList;
    // print('dataList--$dataList');
    var roomTypeList = dataList['roomTypeList'];
    var orientedList = dataList['orientedList'];
    var floorList = dataList['floorList'];

    var selectedIds = ScopedModelHelper.getModel<FilterBarModel>(context).selectedList.toList();

    _onChange(String val){
      ScopedModelHelper.getModel<FilterBarModel>(context).selectedListToggleItem(val);
    }
    return Drawer(
      elevation: 0.0,
      child: SafeArea(
        child: ListView(
          children: [
            CommonTitle('户型'),
            FilterDrawerItem(
              list: roomTypeList,
              selectedIds: selectedIds,
              onChange: _onChange,
            ),
            CommonTitle('朝向'),
            FilterDrawerItem(
              list: orientedList,
              selectedIds: selectedIds,
              onChange: _onChange,
            ),
            CommonTitle('楼层'),
            FilterDrawerItem(
              list: floorList,
              selectedIds: selectedIds,
              onChange: _onChange,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterDrawerItem extends StatelessWidget {

  final List<GeneralType> list;
  final List<String> selectedIds;
  final ValueChanged<String> onChange;

  const FilterDrawerItem({
    Key key, this.list, this.selectedIds, this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: list.map((item){
          var  isActive = selectedIds.contains(item.id);
          return GestureDetector(
            onTap: (){
              if(onChange != null ){
                onChange(item.id);
              }
            },
            child: Container(
              width: 100.0,
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                ),
                color: isActive?Colors.green:Colors.white,
              ),
              child: Center(
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: isActive? Colors.white: Colors.green,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}