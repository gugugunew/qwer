import 'package:flutter/material.dart';

void main() {
  runApp(const WordLearningApp());
}

// 获取当前应该使用的主题亮度
Brightness _getEffectiveBrightness(BuildContext context, ThemeMode themeMode) {
  if (themeMode == ThemeMode.system) {
    return MediaQuery.of(context).platformBrightness;
  } else if (themeMode == ThemeMode.light) {
    return Brightness.light;
  } else {
    return Brightness.dark;
  }
}

class WordLearningApp extends StatefulWidget {
  const WordLearningApp({super.key});

  @override
  State<WordLearningApp> createState() => _WordLearningAppState();
}

class _WordLearningAppState extends State<WordLearningApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '背单词',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Poppins',
      ),
      themeMode: _themeMode,
      home: HomeScreen(
        onThemeModeChanged: (mode) {
          setState(() {
            _themeMode = mode;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeModeChanged;

  const HomeScreen({super.key, required this.onThemeModeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _showTranslation = false;
  bool _isAmericanAccent = true;
  ThemeMode _themeMode = ThemeMode.system;
  String _currentWordBook = 'CC';

  final Map<String, List<WordData>> wordBooks = {
    'CC': [
      WordData(word: 'abandon', definition: 'v. 放弃；遗弃', pronunciation: 'ə-ˈbæn.dən'),
      WordData(word: 'ability', definition: 'n. 能力；才能', pronunciation: 'ə-ˈbɪl.ə.ti'),
      WordData(word: 'abroad', definition: 'adv. 在国外；到国外', pronunciation: 'ə-ˈbrɔːd'),
      WordData(word: 'absence', definition: 'n. 缺席；不在', pronunciation: 'ˈæb.səns'),
      WordData(word: 'absolute', definition: 'adj. 绝对的；完全的', pronunciation: 'ˈæb.sə.luːt'),
      WordData(word: 'absorb', definition: 'v. 吸收；吸引', pronunciation: 'əb-ˈzɔːrb'),
      WordData(word: 'abstract', definition: 'adj. 抽象的', pronunciation: 'ˈæb.strækt'),
      WordData(word: 'abundant', definition: 'adj. 丰富的；充裕的', pronunciation: 'ə-ˈbʌn.dənt'),
      WordData(word: 'abuse', definition: 'v. 滥用；虐待', pronunciation: 'ə-ˈbjuːz'),
      WordData(word: 'academic', definition: 'adj. 学术的', pronunciation: 'ˌæk.əˈdem.ɪk'),
    ],
  };

  late List<WordData> _currentWords;

  @override
  void initState() {
    super.initState();
    _currentWords = wordBooks[_currentWordBook]!;
  }

  void _nextWord() {
    if (_currentIndex < _currentWords.length - 1) {
      setState(() {
        _currentIndex++;
        _showTranslation = false;
      });
    }
  }

  void _showTrans() {
    setState(() {
      _showTranslation = true;
    });
  }

  void _changeWordBook(String bookName) {
    setState(() {
      _currentWordBook = bookName;
      _currentWords = wordBooks[bookName]!;
      _currentIndex = 0;
      _showTranslation = false;
    });
  }

  void _changeThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
    widget.onThemeModeChanged(mode);
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = _currentWords[_currentIndex];
    final isDarkMode =
        _getEffectiveBrightness(context, _themeMode) == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF0F1012) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF0F1012) : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.menu),
            itemBuilder: (context) => [
              // 美/英音切换
              PopupMenuItem(
                enabled: false,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('发音', style: TextStyle(
                      fontSize: 13, 
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    )),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAmericanAccent = true;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _isAmericanAccent
                                  ? (isDarkMode ? const Color(0xFF18191B) : const Color(0xFF82C1AA))
                                  : Colors.transparent,
                              border: Border.all(
                                color: _isAmericanAccent
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.transparent)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '美音',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _isAmericanAccent
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.white)
                                    : (isDarkMode ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAmericanAccent = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: !_isAmericanAccent
                                  ? (isDarkMode ? const Color(0xFF18191B) : const Color(0xFF82C1AA))
                                  : Colors.transparent,
                              border: Border.all(
                                color: !_isAmericanAccent
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.transparent)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '英音',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: !_isAmericanAccent
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.white)
                                    : (isDarkMode ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 主题外观
              PopupMenuItem(
                enabled: false,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('主题外观', style: TextStyle(
                      fontSize: 13, 
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    )),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _changeThemeMode(ThemeMode.system);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _themeMode == ThemeMode.system
                                  ? (isDarkMode ? const Color(0xFF18191B) : const Color(0xFF82C1AA))
                                  : Colors.transparent,
                              border: Border.all(
                                color: _themeMode == ThemeMode.system
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.transparent)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '跟随系统',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _themeMode == ThemeMode.system
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.white)
                                    : (isDarkMode ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            _changeThemeMode(ThemeMode.light);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _themeMode == ThemeMode.light
                                  ? (isDarkMode ? const Color(0xFF18191B) : const Color(0xFF82C1AA))
                                  : Colors.transparent,
                              border: Border.all(
                                color: _themeMode == ThemeMode.light
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.transparent)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '日间',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _themeMode == ThemeMode.light
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.white)
                                    : (isDarkMode ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            _changeThemeMode(ThemeMode.dark);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _themeMode == ThemeMode.dark
                                  ? (isDarkMode ? const Color(0xFF18191B) : const Color(0xFF82C1AA))
                                  : Colors.transparent,
                              border: Border.all(
                                color: _themeMode == ThemeMode.dark
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.transparent)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '夜间',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _themeMode == ThemeMode.dark
                                    ? (isDarkMode ? const Color(0xFF91B9B2) : Colors.white)
                                    : (isDarkMode ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Text('选择单词书', 
                  style: TextStyle(
                    fontSize: 13, 
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  )
                ),
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('选择单词书'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: wordBooks.keys
                              .map((book) => ListTile(
                                    title: Text(book),
                                    trailing: _currentWordBook == book
                                        ? const Icon(Icons.check)
                                        : null,
                                    onTap: () {
                                      _changeWordBook(book);
                                      Navigator.pop(context);
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  });
                },
              ),
              // 查看全部单词
              PopupMenuItem(
                child: Text('查看全部单词',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  )
                ),
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WordListPage(
                          words: _currentWords,
                          currentIndex: _currentIndex,
                          isDarkMode: isDarkMode,
                          onWordTapped: (index) {
                            setState(() {
                              _currentIndex = index;
                              _showTranslation = true;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!_showTranslation) {
            _showTrans();
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentWord.word,
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : const Color(0xFF222B45),
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      Visibility(
                        visible: _showTranslation,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Column(
                          children: [
                            Text(
                              currentWord.definition,
                              style: TextStyle(
                                fontSize: 18,
                                color: isDarkMode
                                    ? const Color(0xFFA0A0A0)
                                    : const Color(0xFF7B8794),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentWord.pronunciation,
                              style: TextStyle(
                                fontSize: 15,
                                color: isDarkMode
                                    ? const Color(0xFF888888)
                                    : const Color(0xFFB0BEC5),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _showTranslation,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? const Color(0xFF18191B)
                                  : const Color(0xFF82C1AA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: isDarkMode
                                      ? const Color(0xFF91B9B2)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _nextWord,
                            child: Text(
                              '认识',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? const Color(0xFF91B9B2)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? const Color(0xFF18191B)
                                  : const Color(0xFFEB9E28),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: isDarkMode
                                      ? const Color(0xFFCE9E43)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _nextWord,
                            child: Text(
                              '模糊',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? const Color(0xFFCE9E43)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordData {
  final String word;
  final String definition;
  final String pronunciation;

  WordData({
    required this.word,
    required this.definition,
    required this.pronunciation,
  });
}

class WordListPage extends StatefulWidget {
  final List<WordData> words;
  final int currentIndex;
  final bool isDarkMode;
  final Function(int) onWordTapped;

  const WordListPage({
    super.key,
    required this.words,
    required this.currentIndex,
    required this.isDarkMode,
    required this.onWordTapped,
  });

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  final Set<int> _selectedIndices = {};
  final Set<int> _blurredWords = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isDarkMode ? const Color(0xFF1B1F29) : const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor:
            widget.isDarkMode ? const Color(0xFF1B1F29) : const Color(0xFFFFFFFF),
        elevation: 0,
        title: const Text('单词列表'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(
              widget.isDarkMode ? const Color(0xFF1B1F29) : const Color(0xFFFFFFFF),
            ),
            trackColor: WidgetStateProperty.all(
              widget.isDarkMode ? const Color(0xFF1B1F29) : const Color(0xFFFFFFFF),
            ),
          ),
        ),
        child: Container(
          color: widget.isDarkMode ? const Color(0xFF1B1F29) : const Color(0xFFFFFFFF),
          child: ListView.builder(
            primary: true,
            itemCount: widget.words.length,
            itemBuilder: (context, index) {
              final word = widget.words[index];
              final isSelected = _selectedIndices.contains(index);
            final isBlurred = _blurredWords.contains(index);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF2A2F3C)
                  : const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isDarkMode
                    ? Colors.grey[800]!
                    : Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // 左边序号标记区 - 点击切换模糊
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_blurredWords.contains(index)) {
                        _blurredWords.remove(index);
                      } else {
                        _blurredWords.add(index);
                      }
                    });
                  },
                  child: Container(
                    width: 32,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isBlurred
                          ? (widget.isDarkMode
                              ? const Color(0xFF553910)
                              : const Color(0xFFEB9E28))
                          : (widget.isDarkMode
                              ? const Color(0xFF444D61)
                              : const Color(0xFFEAEFF2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isBlurred
                              ? Colors.white
                              : (widget.isDarkMode ? Colors.white : Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
                // 中间单词区域
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word.word,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: widget.isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          word.pronunciation,
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.isDarkMode ? Colors.grey[500] : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 右边翻译/提示区域
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndices.contains(index)) {
                          _selectedIndices.remove(index);
                        } else {
                          _selectedIndices.add(index);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: !isSelected
                            ? (widget.isDarkMode
                                ? const Color(0xFF444D61)
                                : const Color(0xFFEAEFF2))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: isSelected
                            ? Text(
                                word.definition,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.isDarkMode ? Colors.white : Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                '点击显示',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.isDarkMode ? const Color(0xFF97A0B4) : const Color(0xFFA0A4AC),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          },
        ),
      ),
      ),
    );
  }
}
