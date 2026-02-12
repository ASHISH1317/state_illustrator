# Changelog

## [2.0.0] - 2026-02-12

- Added option to add config 
- Custom height, width and padding options

## [1.0.0] - 2026-02-12

### Initial Release

- Added `StateIllustrator` widget for handling screen states:
    - Loading
    - Empty
    - Error
    - Success
- Supports built-in assets:
    - Lottie (`.json`) for loading
    - SVG for empty
    - PNG for error
- Fully configurable via `IllustrationConfig` and `GlobalIllustratorConfig`.
- Retry button support for error states.
- Animated transitions between states using `AnimatedSwitcher`.
- Customizable theme via `IllustratorTheme`.
- Asset auto-detection by file extension.
- Supports custom widgets in place of assets.
- Documentation added for all classes and enums.
