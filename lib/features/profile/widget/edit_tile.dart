import 'package:flutter/material.dart';

class EditTile extends StatefulWidget {
  EditTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onSave,
  });

  final IconData icon;
  final String title;
  final String value;
  final Function(String value) onSave;

  @override
  State<EditTile> createState() => _EditTileState();
}

class _EditTileState extends State<EditTile> {
   bool isEditingTile = false;



  @override
 
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, size: 30),
      title: Text(widget.title, style: TextStyle(fontSize: 20)),

      subtitle: isEditingTile? TextField(
      onChanged: (value) => widget.onSave(value),
      onSubmitted: (value) => widget.onSave(value),
      ) : Text(widget.value),
    

      trailing: TextButton(onPressed: (){
        setState(() {
          isEditingTile = !isEditingTile;

        });
      }, child: isEditingTile? Text("Save") :Text("Edit") ),
    );
  }
}
