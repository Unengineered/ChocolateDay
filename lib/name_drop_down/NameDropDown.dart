import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NameDropDown extends StatefulWidget {
  final ValueChanged<String> valueReturned;

  ///Constructor that accepts a list of elements to be the data source for the dropdown
  NameDropDown.withData(
      {@required this.dataSource,
      @required this.defaultOptionText,
      @required this.valueReturned,
      @required key})
      : urlToFetchData = null,
        super(key: key);

  ///Constructor that accepts an endpoint in URI form to fetch the data from
  NameDropDown.withEndpoint(
      {@required this.defaultOptionText,
      @required this.urlToFetchData,
      @required this.valueReturned})
      : dataSource = null;

  /// Holds the default text to show when nothing is selected in the dropdown
  final String defaultOptionText;

  /// The endpoint to fetch the data that gets used by the dropdown
  final Uri urlToFetchData;

  /// A list which holds the data if we don't want to make a network request
  final List<String> dataSource;

  @override
  _NameDropDownState createState() => _NameDropDownState();
}

class _NameDropDownState extends State<NameDropDown> {
  List<DropdownMenuItem<String>> _data = [];
  String _selected = "Choose Email";

  @override
  void initState() {
    super.initState();
    _loadDataForDropdown();
  }

  /// Responsible for loading the data that the dropdown uses
  void _loadDataForDropdown() async {
    _data = const [];

    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(new DropdownMenuItem(
      child: new Text(_selected),
      value: _selected,
    ));

    if (widget.urlToFetchData != null) {
      var response = await http.get(widget.urlToFetchData);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        jsonResponse.forEach((key, value) {
          menuItems.add(new DropdownMenuItem(
            child: new Text(value.toString()),
            value: value.toString(),
          ));
        });
        setState(() {
          _data = menuItems;
        });
      } else {
        print(
            "EnhancedDropDownWidget Request failed with status: ${response.statusCode}.");
      }
    } else if (widget.dataSource != null) {
      for (int i = 0; i < widget.dataSource.length; i++) {
        menuItems.add(new DropdownMenuItem(
          child: new Text(widget.dataSource[i]),
          value: widget.dataSource[i],
        ));
      }
      setState(() {
        _data = menuItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return new Container();
    } else {
      return new Container(
          height: 100,
          child: new Column(
            children: <Widget>[
              DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == "Choose Email" || value == null || value == '')
                      return "Please choose an email";
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  )),
                  value: _selected,
                  items: _data,
                  hint: new Text(widget.defaultOptionText),
                  onChanged: (value) {
                    _selected = value as String;
                    widget.valueReturned(_selected);
                    setState(() {});
                  })
            ],
          ));
    }
  }
}
