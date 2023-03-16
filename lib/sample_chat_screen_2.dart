import 'package:flutter/material.dart';

class SampleChatScreen extends StatefulWidget {
  const SampleChatScreen({super.key});

  @override
  State<SampleChatScreen> createState() => _SampleChatScreenState();
}

class _SampleChatScreenState extends State<SampleChatScreen> {
  TextEditingController chatData = TextEditingController();
  List<Widget> a = List.generate(
      30,
      (index) => Padding(
            padding: const EdgeInsets.all(38.0),
            child: Text(index.toString()),
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Space')),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: a.length,
                  itemBuilder: (BuildContext context, int index) {
                    return a[index];
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 5, 10),
                  padding: const EdgeInsets.only(left: 15),
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: const Color(0xFF52AD62),
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: chatData,
                    decoration: const InputDecoration(
                      iconColor: Color(0xFF52AD62),
                      hintText: 'Type here..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {},
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
