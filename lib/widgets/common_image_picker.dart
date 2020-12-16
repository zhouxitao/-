import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const List<String> defautImages = [
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tdgve1j30ku0bsn75.jpg',
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2whp87sj30ku0bstec.jpg',
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tl1v3bj30ku0bs77z.jpg',
];
// 图片宽750px，高424px；
var imageWidth = 750.0;
var imageHeight = 424.0;
var imageWidthHeightRatio = imageWidth / imageHeight;

class CommonImagePicker extends StatefulWidget {
  final ValueChanged <List <File>> onChange;

  const CommonImagePicker({Key key, this.onChange}) : super(key: key);

  @override
  _CommonImagePickerState createState() => _CommonImagePickerState();
}



class _CommonImagePickerState extends State<CommonImagePicker> {
  List<File> files=[];

  final picker = ImagePicker();

  _pickerImage () async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // if (pickedFile == null) return 加上这一句，会添加不成功

    setState(() {
      if (pickedFile != null) {
        files = files..add(File(pickedFile.path));
        // print(files);
      } else {
        print('No image selected.');
      }
    });
    if(widget.onChange != null){
      widget.onChange(files);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = (MediaQuery.of(context).size.width -10.0*4) / 3;
    var height = width / imageWidthHeightRatio;

    Widget addBtn = GestureDetector(
      onTap: (){
        _pickerImage();
      },
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Center(
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    Widget wrapper (File file){
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Image.file(
            file,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: IconButton(
              icon:Icon(Icons.delete_forever),
              color: Colors.red,
              onPressed: (){
                setState(() {
                  files = files..remove(file);
                });
                if(widget.onChange != null ){
                  widget.onChange(files);
                }
              },
            ),
            right:-5.0,
            top:-20.0,
          ),
        ],
      );
    }

    List<Widget> list = files.map((item) => wrapper(item)).toList()..add(addBtn);

    return Container(
      padding: EdgeInsets.only(left:10.0),
      child: Wrap(
        runSpacing: 10.0,
        spacing: 10.0,
        children: list,
      ),
    );
  }
}