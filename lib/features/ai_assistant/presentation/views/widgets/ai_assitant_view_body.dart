import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static final Gemini _gemini = Gemini.init(
    apiKey: 'AIzaSyAqoA51Cu9--jMJfwr_9i-LsFlp30ASAPw',
  );

  static Future<String?> sendQuery({
    required List<Map<String, dynamic>> data,
    required String userQuery,
  }) async {
    try {
      final prompt = _buildSystemPrompt(items: data);

      final response = await _gemini.prompt(
        parts: [Part.text(prompt), Part.text(userQuery)],
      );
      debugPrint(response?.output);

      return response?.output;
    } catch (e) {
      debugPrint('Gemini Error: ${e.toString()}');
      return null;
    }
  }

  static String _buildSystemPrompt({
    required List<Map<String, dynamic>> items,
  }) {
    final buffer = StringBuffer();

    buffer.write('''
You are a virtual financial assistant specialized in providing instant answers and consultations about loans without asking follow-up questions.

Always speak in simple, clear, and friendly language.

When the user asks about any loan-related topic (such as requirements, interest rates, repayment terms, available types, estimated eligibility, or credit qualification), provide a direct and informative answer based on the available information.

If essential details are missing to give a reliable answer, mention that briefly (e.g., "I need more details about ...") but do not ask a list of questions. Let the user provide what they think is relevant.
''');

    for (final item in items) {
      item.forEach((key, value) {
        if (value is List) {
          for (int i = 0; i < value.length; i++) {
            buffer.write('• ${key.toUpperCase()}_${i + 1}: ${value[i]}\n');
          }
        } else {
          buffer.write('• ${key.toUpperCase()}: $value\n');
        }
      });
    }

    return buffer.toString();
  }
}

class chat_screen extends StatefulWidget {
  const chat_screen({super.key});

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add({"isUser": true, "message": input});
      _isLoading = true;
    });
    _controller.clear();

    try {
      final response = await GeminiService.sendQuery(
        data: [], // لسه فاضي لإنك مش تبعت داتا حالياً
        userQuery: input,
      );

      setState(() {
        _messages.add({
          "isUser": false,
          "message": response ?? "There was no response. Please try again later.",
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "isUser": false,
          "message": "An error occurred while processing your request. Please try again later.",
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 196, 214),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'AI Assistant',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 254, 196, 214),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Align(
                      alignment:
                          message["isUser"]
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              message["isUser"]
                                  ? Color.fromARGB(255, 254, 196, 214)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message["message"],
                          style: TextStyle(
                            color:
                                message["isUser"]
                                    ? Colors.black
                                    : Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type....',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 255, 127, 168),
                      ),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
