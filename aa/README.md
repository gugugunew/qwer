# 背单词 - Word Learning App

一个使用 Flutter 开发的跨平台背单词学习应用，支持 iOS、Android 和 Windows 平台。

## 功能特性

- **简洁界面**: 采用 Material Design 3 设计规范，清爽简约的 UI
- **单词卡片**: 点击卡片查看单词翻译
- **进度跟踪**: 实时显示学习进度和已掌握单词数
- **直观导航**: 支持上一个、下一个和已掌握按钮
- **跨平台支持**: 支持 iOS、Android 和 Windows 系统

## 项目结构

```
├── android/          # Android 平台特定代码
├── ios/              # iOS 平台特定代码
├── windows/          # Windows 平台特定代码
├── lib/              # Dart 源代码
│   └── main.dart     # 应用入口和主要 UI 代码
├── pubspec.yaml      # 项目配置文件
└── README.md         # 本文件
```

## 快速开始

### 环境要求

- Flutter SDK 3.11.4 或更高版本
- Dart SDK

### 安装依赖

```bash
flutter pub get
```

### 运行应用

#### 选项 1: 运行到默认设备

```bash
flutter run
```

#### 选项 2: 指定平台运行

```bash
# 运行到 Android 设备
flutter run -d android

# 运行到 iOS 设备
flutter run -d ios

# 运行到 Windows 应用
flutter run -d windows
```

## 开发指南

### 项目架构

该项目采用简单的 Material Design 架构：

- **HomeScreen**: 主要学习界面，包含单词卡片、进度条和操作按钮
- **状态管理**: 使用 StatefulWidget 管理应用状态

### 自定义单词库

编辑 `lib/main.dart` 中的 `wordList` 和 `translationList`：

```dart
final List<String> wordList = [
  'Apple',
  'Banana',
  'Cherry',
  // 添加更多单词
];

final List<String> translationList = [
  '苹果',
  '香蕉',
  '樱桃',
  // 添加对应翻译
];
```

### 代码风格

遵循 [Dart 官方风格指南](https://dart.dev/guides/language/analysis-options)。

## 构建生产版本

### Android

```bash
flutter build apk
```

### iOS

```bash
flutter build ios
```

### Windows

```bash
flutter build windows
```

## 常见问题

### Q: 如何添加更多功能？
A: 可以扩展应用的功能，例如：
- 添加单词分类
- 实现本地数据持久化
- 添加发音功能
- 实现学习统计

### Q: 如何修改应用主题？
A: 编辑 `lib/main.dart` 中的 `ThemeData` 配置：

```dart
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,  // 修改主色调
  ),
),
```

## 许可证

MIT License

## 贡献

欢迎提交 Pull Request 或报告 Issue！
