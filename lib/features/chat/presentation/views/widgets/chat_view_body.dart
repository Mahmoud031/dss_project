import 'package:dss_project/features/data_export/data/repositories/data_export_repository.dart';
import 'package:dss_project/features/home/presentation/views/home_view.dart';
import 'package:dss_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

// خدمة التعامل مع Gemini
class GeminiService {
  static final Gemini _gemini = Gemini.init(
    apiKey: 'AIzaSyCgrwPd8upWU7XTPl0AyBwgBryjkuJQ7Ak',
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
You are a virtual assistant specialized only in loan approval prediction.
You can receive the applicant's data either gradually (step-by-step) or all at once.

If the user sends you all their data at once (such as home ownership, loan purpose, marital status, etc.), immediately analyze the information and provide a prediction.

If the user does not provide all the data at once, collect the information interactively by asking one question at a time, in the following order:
1. Home Ownership
2. Loan Purpose
3. Marital Status
4. Dependents
5. Income Group
6. Loan Amount Group
7. Age Group
8. Credit History Category

Important notes:
- 'loan_status' is the prediction target. Do not ask the user for it.
- Always ask one question at a time and wait for the answer.

If the user asks you anything unrelated to loan prediction, reply with:
"Sorry, I specialize only in loan approval prediction and cannot assist with that topic."

Use simple and clear English when talking to the user.
''');

    for (final item in items) {
      item.forEach((key, value) {
        buffer.write('• ${key.toUpperCase()}: $value\n');
      });
    }

    return buffer.toString();
  }
}

// شاشة الدردشة
class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final List<Map<String, dynamic>> _messages = [];
  final Map<String, String> _userData = {};
  final ScrollController _scrollController = ScrollController();
  String? _currentQuestion;
  List<String> _currentOptions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _askNextQuestion();
  }

  Future<void> _askNextQuestion() async {
    if (_userData.length == 8) {
      _currentQuestion = null;
      _currentOptions = [];
      setState(() {});
      await _sendDataToGemini();
      return;
    }

    setState(() {
      _isLoading = false;
    });

    if (_userData['home_ownership'] == null) {
      _setQuestion("Please select your home ownership status:", [
        "OWN",
        "MORTGAGE",
        "RENT",
        "OTHER",
      ]);
    } else if (_userData['loan_purpose'] == null) {
      _setQuestion("Please select the purpose of the loan:", [
        "EDUCATION",
        "HOMEIMPROVEMENT",
        "VENTURE",
        "PERSONAL",
        "MEDICAL",
        "DEBTCONSOLIDATION",
      ]);
    } else if (_userData['Marital_Status'] == null) {
      _setQuestion("Are you married?", ["yes", "no"]);
    } else if (_userData['Dependents'] == null) {
      _setQuestion("How many dependents do you have?", [
        "0",
        "1",
        "2",
        "3",
        "3+",
      ]);
    } else if (_userData['income_group'] == null) {
      _setQuestion(
        "What is your income ?\n\nlow: less than 30,000\nmedium: (30,000 – 70,000)\nhigh: more than 70,000",
        ["low", "medium", "high"],
      );
    } else if (_userData['loan_amount_group'] == null) {
      _setQuestion(
        "What is your loan amount ?\n\nlow: less than 3,200\nmedium:  (3,200 – 9,450)\nhigh: more than 9,450",
        ["low", "medium", "high"],
      );
    } else if (_userData['age_group'] == null) {
      _setQuestion(
        "What is your age ?\n\nyoung: less than 22\nmiddle-aged: (22 – 50)\nold: more than 50",
        ["young", "middle-aged", "old"],
      );
    } else if (_userData['credit_history_category'] == null) {
      _setQuestion(
        "What is your credit history category?\n\nCredit Builder (0–3)\nDeveloping Credit (4–6)\nEstablished Credit (7–9)\nPrime Credit (10–13)",
        [
          "Credit Builder",
          "Developing Credit",
          "Established Credit",
          "Prime Credit",
        ],
      );
    }

    _scrollToBottom();
  }

  void _setQuestion(String question, List<String> options) {
    _currentQuestion = question;
    _currentOptions = options;
    _messages.add({"isUser": false, "message": question, "isQuestion": true});
    _scrollToBottom(); // بعد إضافة سؤال جديد
  }

  Future<void> _handleOptionSelected(String selectedOption) async {
    setState(() {
      _messages.add({"isUser": true, "message": selectedOption});
    });

    if (_userData['home_ownership'] == null) {
      _userData['home_ownership'] = selectedOption;
    } else if (_userData['loan_purpose'] == null) {
      _userData['loan_purpose'] = selectedOption;
    } else if (_userData['Marital_Status'] == null) {
      _userData['Marital_Status'] = selectedOption;
    } else if (_userData['Dependents'] == null) {
      _userData['Dependents'] = selectedOption;
    } else if (_userData['income_group'] == null) {
      _userData['income_group'] = selectedOption;
    } else if (_userData['loan_amount_group'] == null) {
      _userData['loan_amount_group'] = selectedOption;
    } else if (_userData['age_group'] == null) {
      _userData['age_group'] = selectedOption;
    } else if (_userData['credit_history_category'] == null) {
      _userData['credit_history_category'] = selectedOption;
    }

    await _askNextQuestion();
  }

  Future<void> _sendDataToGemini() async {
    setState(() {
      _isLoading = true;
      _messages.add({
        "isUser": false,
        "message": "Analyzing your information...",
      });
    });
    _scrollToBottom();

    try {
      final response = await GeminiService.sendQuery(
        data: [_userData],
        userQuery:
            "Please predict my loan approval status based on my information.",
      );

      // Convert the response to binary loan status
      final loanStatus = _convertToLoanStatus(response);

      // Add loan status to user data for Google Sheets
      _userData['loan_status'] = loanStatus.toString();

      // Export data to Google Sheets
      final repo = DataExportRepository(sheetsService);
      await repo.exportData(_userData);

      setState(() {
        _messages.add({
          "isUser": false,
          "message": response ?? "No answer, please try again later.",
          "loanStatus": loanStatus,
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "isUser": false,
          "message": "Error occurred, please try again later.",
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  int _convertToLoanStatus(String? response) {
    if (response == null) return -1; // Invalid response

    // Convert to lowercase for case-insensitive matching
    final lowerResponse = response.toLowerCase();

    // Check for positive indicators
    if (lowerResponse.contains('approved') ||
        lowerResponse.contains('approve') ||
        lowerResponse.contains('yes') ||
        lowerResponse.contains('positive') ||
        lowerResponse.contains('eligible')) {
      return 1;
    }

    // Check for negative indicators
    if (lowerResponse.contains('rejected') ||
        lowerResponse.contains('reject') ||
        lowerResponse.contains('no') ||
        lowerResponse.contains('negative') ||
        lowerResponse.contains('not eligible')) {
      return 0;
    }

    return -1; // Unable to determine status
  }

  void _startNewChat() {
    setState(() {
      _messages.clear();
      _userData.clear();
      _currentQuestion = null;
      _currentOptions = [];
      _isLoading = false;
    });
    _askNextQuestion();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 25,
          ),
        ),
        title: const Text(
          'Loan Prediction Assistant',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF85A59E),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _startNewChat),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isUser = message["isUser"] ?? false;
                final bool isQuestion = message["isQuestion"] ?? false;
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xffBBD3CD)
                          : const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message["message"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_currentOptions.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _currentOptions.map((option) {
                  return ElevatedButton(
                    onPressed: () => _handleOptionSelected(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF85A59E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(option),
                  );
                }).toList(),
              ),
            ),
          SizedBox(height: 5),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(color: Color(0xFF85A59E)),
            ),
        ],
      ),
    );
  }
}
