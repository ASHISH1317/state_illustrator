# state_illustrator 🎨

[![pub.dev](https://img.shields.io/pub/v/state_illustrator.svg)](https://pub.dev/packages/state_illustrator)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Flutter helper widget to display **loading**, **empty**, **error**, and **success** screen states with customizable illustrations and smooth transitions.

---

## 🚀 Features

- 📦 Built‑in support for **loading**, **empty**, **error**, and **success** states
- 🎨 Supports Lottie (`.json`), SVG (`.svg`), and PNG (`.png`) assets
- 🔁 Smooth fade transition between states
- 🔧 Easily customizable themes, titles, subtitles, and retry button
- 🧩 Use custom widgets in place of illustrations

---

## 📌 Screenshots

*(Add screenshots or GIFs showing each state)*

---

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  state_illustrator: ^1.0.0
```

Then run:

```markdown
flutter pub get
```

---

🧠 How It Works

StateIllustrator observes a view state and shows the appropriate UI:

| ViewState | Displays                   |
| --------- | -------------------------- |
| `initial` | Empty placeholder          |
| `loading` | Loading animation or asset |
| `empty`   | Empty illustration         |
| `error`   | Error illustration + retry |
| `success` | Your content (`child`)     |

---

📘 Usage

Basic Example

```dart
StateIllustrator(
  state: _state,
  onRetry: () => _fetchData(),
  child: Center(
    child: Text(
      'Data Loaded Successfully!',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
)
```

---

🎨 Customization

You can override all visuals using GlobalIllustratorConfig:

```dart
final globalConfig = GlobalIllustratorConfig(
  loadingConfig: IllustrationConfig(
    assetPath: 'assets/animations/loading.json',
    assetType: AssetType.lottie,
    title: 'Loading...',
    subtitle: 'Fetching data, please wait...',
  ),
  emptyConfig: IllustrationConfig(
    assetPath: 'assets/images/empty.svg',
    assetType: AssetType.svg,
    title: 'No Items',
    subtitle: 'Try adding some items!',
  ),
  errorConfig: IllustrationConfig(
    assetPath: 'assets/images/error.png',
    assetType: AssetType.png,
    title: 'Something went wrong',
    subtitle: 'Please try again later.',
    buttonStyle: ElevatedButton.styleFrom(primary: Colors.red),
  ),
  theme: IllustratorTheme(
    backgroundColor: Colors.white,
    titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    subtitleStyle: TextStyle(fontSize: 16),
  ),
);
```

Then apply it in your widget:

```dart
StateIllustrator(
  state: _state,
  config: globalConfig,
  onRetry: _fetchData,
  child: YourContentWidget(),
)
```

---

🧩 Custom Widgets Support

If you want complete control, provide customWidget:

```dart
IllustrationConfig(
  customWidget: YourCustomWidget(),
)
```
This overrides any asset.

---

🛠 Defaults

The package includes default assets and texts:

| State   | Asset Path                    | Title        | Subtitle              |
| ------- | ----------------------------- | ------------ | --------------------- |
| Loading | `assets/default/loading.json` | Loading...   | Please wait a moment. |
| Empty   | `assets/default/empty.svg`    | Nothing here | No data available.    |
| Error   | `assets/default/error.png`    | Oops!        | Something went wrong. |

---

📦 Contributing

Contributions are welcome! To contribute:

1. 🍴 Fork this repo
2. 🧩 Create your feature branch (git checkout -b feature/AmazingFeature)
3. 📝 Commit your changes (git commit -m "Add AmazingFeature")
4. 🚀 Push (git push origin feature/AmazingFeature)
5. 🔃 Open a Pull Request

---

📝 License

This project is licensed under the MIT License. © [ASHISH1317]
