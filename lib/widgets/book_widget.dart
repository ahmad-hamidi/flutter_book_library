import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  final String? _title, _description, _thumbnail;

  BookWidget(this._title, this._description, this._thumbnail);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      elevation: 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.network(
              _thumbnail ?? "",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(_title ?? "-"),
                SizedBox(height: 8),
                Text(_description ?? "-", maxLines: 2),
                SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
