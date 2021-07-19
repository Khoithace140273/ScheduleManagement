import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidgetNote<T> extends StatelessWidget {
  final Widget child;
  final Function() onTapUpdate;
  final Function() onTapDelete;
  const SlidableWidgetNote({required this.child, required this.onTapUpdate,
    required this.onTapDelete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: child,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      actions: [
        IconSlideAction(
          caption: "Edit",
          color:  Colors.white,
          icon: Icons.edit,
          onTap: (){
            onTapUpdate();
          },
        ),
        IconSlideAction(
          caption: "Delete",
          color:  Colors.redAccent,
          icon: Icons.delete,
          onTap: (){
            onTapDelete();
          },
        ),
      ],
    );
  }
}
