import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final TextEditingController _textEditingController = TextEditingController();

  Box? _todosBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox("todo box").then((_box) {
      setState(() {
        _todosBox = _box;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note It!!!",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context), 
        child: const Icon(
        Icons.add,
      ),),
    );
  }

  Widget _buildUI() {
    if (_todosBox == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ValueListenableBuilder(
      valueListenable: _todosBox!.listenable(), 
      builder: (context, box, widget) {
        final todosKeys = box.keys.toList();
        return SizedBox.expand(
          child: ListView.builder(
            itemCount: todosKeys.length,
            itemBuilder: (context, index) {
              Map todo = _todosBox!.get(
                todosKeys[index],
              );
              return ListTile(
                title: Text(
                  todo["content"],
                ),
                subtitle: Text(
                  todo["time"]
                ),
                onLongPress: () async {
                  await _todosBox!.delete(todosKeys[index]);
                },
                trailing: Checkbox(
                  value: todo["isDone"],
                  onChanged: (value) async {
                    todo["isDone"] = value;
                    await _todosBox!.put(todosKeys[index], todo);
                  },
                ),
              );
            }
          ),
        );
      });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async{
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text("Add a todo"),
            content: TextField(controller: _textEditingController,
            decoration: const InputDecoration(hintText: "todo..."),
          ),
          actions: [
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text("ok"),
              onPressed: () {
                _todosBox?.add({
                  "content": _textEditingController.text,
                  "time": DateTime.now().toIso8601String(),
                  "isDone": false,
                });
                Navigator.pop(context);
                _textEditingController.clear();
              }
            )
          ],
        );
      }
    );
  }
}