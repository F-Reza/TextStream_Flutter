import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/text_repeater_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TextRepeaterModel>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF0e7dfb),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'TextStream',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Save to File successfully.\nrepeated_text.txt')),
              );
              model.saveToFile(model.getRepeatedText());
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Consumer<TextRepeaterModel>(
                    builder: (context, model, child) {
                      return SavedTextList(model: model);
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.library_books_sharp),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => model.setInputText(value),
              decoration: const InputDecoration(
                labelText: 'Enter Text to Repeat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Repeats:'),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 42,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) => model.setRepeatCount(value),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      const Text('Delimiter:'),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: model.selectedDelimiter,
                        onChanged: (value) => model.setDelimiter(value!),
                        items: const [
                          DropdownMenuItem(
                            value: ',',
                            child: Text('Comma'),
                          ),
                          DropdownMenuItem(
                            value: ' ',
                            child: Text('Space'),
                          ),
                          DropdownMenuItem(
                            value: '\n',
                            child: Text('Newline'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Font Size:'),
                Expanded(
                  child: Slider(
                    min: 10,
                    max: 30,
                    value: model.fontSize,
                    onChanged: (value) {
                      model.setFontSize(value);
                    },
                  ),
                ),
                Text(model.fontSize.toStringAsFixed(0)),
                const SizedBox(width: 18),
                const Text('Style:'),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: model.fontWeight == FontWeight.bold
                        ? 'Bold'
                        : model.fontStyle == FontStyle.italic
                        ? 'Italic'
                        : 'Normal',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        if (newValue == 'Normal') {
                          model.setFontStyle(FontStyle.normal);
                          model.setFontWeight(FontWeight.normal);
                        } else if (newValue == 'Italic') {
                          model.setFontStyle(FontStyle.italic);
                          model.setFontWeight(FontWeight.normal);
                        } else if (newValue == 'Bold') {
                          model.setFontStyle(FontStyle.normal);
                          model.setFontWeight(FontWeight.bold);
                        }
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'Normal',
                        child: Text('Normal'),
                      ),
                      DropdownMenuItem(
                        value: 'Italic',
                        child: Text('Italic'),
                      ),
                      DropdownMenuItem(
                        value: 'Bold',
                        child: Text('Bold'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Text copied successfully')),
                    );
                    model.copyToClipboard(model.getRepeatedText());
                  },
                  child: const Text('Copy'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => model.shareText(model.getRepeatedText()),
                  child: const Text('Share'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Text saved successfully to list')),
                    );
                    model.saveText();
                  },
                  child: const Text('Save Text'),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              '___________Live Preview___________',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF0e7dfb),
                child: ListView(
                  children: [
                    Text(
                      model.getRepeatedText(),
                      style: TextStyle(
                        fontSize: model.fontSize,
                        fontWeight: model.fontWeight,
                        fontStyle: model.fontStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedTextList extends StatelessWidget {
  final TextRepeaterModel model;

  const SavedTextList({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: model.savedTexts.isEmpty
          ? const Center(child: Text('No saved texts'))
          : ListView.builder(
        itemCount: model.savedTexts.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                ListTile(
                  title: Text(model.savedTexts[index]),
                ),
                Positioned(
                  right: 0,
                    top: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            model.copyToClipboard(model.savedTexts[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Text copied to clipboard')),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            model.shareText(model.savedTexts[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,color: Colors.red,),
                          onPressed: () {
                            model.savedTexts.removeAt(index); // Remove text
                            model.notifyListeners(); // Refresh UI
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Text deleted successfully')),
                            );
                          },
                        ),
                      ],
                    ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

