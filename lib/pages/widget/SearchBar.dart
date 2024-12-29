import 'package:epitech/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarUI extends StatefulWidget {
  SearchBarUI({super.key, required this.text});
  final Function(String) text;

  @override
  State<SearchBarUI> createState() => _SearchBarUIState();
}

class _SearchBarUIState extends State<SearchBarUI> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width:
                _controller.text.isEmpty ? dw(context) - 40 : dw(context) - 116,
            child: CupertinoTextField(
              controller: _controller,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              placeholder: 'Recherche',
              onChanged: (value) {
                setState(() {
                  widget.text(value);
                });
              },
              cursorColor: Colors.blue,
              placeholderStyle: TextStyle(color: Colors.grey),
              style: TextStyle(color: Colors.white),
              prefix: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
              ),
              decoration: BoxDecoration(
                color:
                    isDarkMode(context) ? Color(0xff1c1c1e) : Color(0xffe4e3e9),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _controller.text.isNotEmpty ? 1 : 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _controller.clear();
                    widget.text('');
                  });
                },
                icon: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
