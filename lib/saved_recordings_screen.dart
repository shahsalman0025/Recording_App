import 'package:flutter/material.dart';

class SavedRecordingsScreen extends StatefulWidget {
  @override
  _SavedRecordingsScreenState createState() => _SavedRecordingsScreenState();
}

class _SavedRecordingsScreenState extends State<SavedRecordingsScreen> {
  List<String> _recordings = []; // List of saved recordings
  bool _selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recordings'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _selectAll ? _deleteSelected : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Storage Usage: 50%'), // Replace with actual storage usage
                ElevatedButton(
                  onPressed: _toggleSelectAll,
                  child: Text(_selectAll ? 'Deselect All' : 'Select All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _recordings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_recordings[index]),
                  leading: Checkbox(
                    value: _selectAll || _recordings[index].endsWith('selected'),
                    onChanged: (value) {
                      setState(() {
                        _recordings[index] = value! ? '${_recordings[index]} selected' : _recordings[index].replaceAll(' selected', '');
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _recordings = _recordings.map((recording) => '${recording} selected').toList();
      } else {
        _recordings = _recordings.map((recording) => recording.replaceAll(' selected', '')).toList();
      }
    });
  }

  void _deleteSelected() {
    setState(() {
      _recordings.removeWhere((recording) => recording.endsWith('selected'));
    });
  }
}
