import 'package:flutter/material.dart';
import '../state_illustrator.dart';

/// Configuration for a single screen state illustration.
///
/// This defines the visual and interactive elements for a particular state
/// such as loading, empty, or error.
class IllustrationConfig {
  /// Title text to display above the illustration.
  final String? title;

  /// Subtitle text to display below the title.
  final String? subtitle;

  /// The path of the asset to display (SVG, Lottie, PNG, etc.).
  ///
  /// Must correspond to the [assetType]. For example:
  /// - `AssetType.lottie` → `assets/animations/loading.json`
  /// - `AssetType.svg` → `assets/images/empty.svg`
  /// - `AssetType.png` → `assets/images/error.png`
  final String? assetPath;

  /// The type of asset to render.
  ///
  /// Required if [assetPath] is provided to determine which widget to use
  /// for rendering (Lottie.asset, SvgPicture.asset, or Image.asset).
  final AssetType? assetType;

  /// Optional custom widget that overrides the default asset rendering.
  final Widget? customWidget;

  /// Optional custom button style for the retry button.
  final ButtonStyle? buttonStyle;

  /// Optional custom button widget for the retry button.
  final Widget? button;

  /// Optional asset height
  final double? assetHeight;

  /// Optional asset width
  final double? assetWidth;

  /// Creates an [IllustrationConfig].
  ///
  /// All parameters are optional; you can provide only the elements
  /// you want to show for a particular state.
  const IllustrationConfig({
    this.title,
    this.subtitle,
    this.assetPath,
    this.assetType,
    this.customWidget,
    this.buttonStyle,
    this.assetHeight,
    this.assetWidth,
    this.button,
  });
}

/// Theme customization for the [StateIllustrator] widget.
///
/// Allows overriding colors and text styles globally for all illustrations.
class IllustratorTheme {
  /// Background color for the illustration screen.
  final Color? backgroundColor;

  /// Text style for the title.
  final TextStyle? titleStyle;

  /// Text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Creates an [IllustratorTheme].
  ///
  /// All parameters are optional. If not provided, defaults will be used.
  const IllustratorTheme({
    this.backgroundColor,
    this.titleStyle,
    this.subtitleStyle,
  });
}

/// Global configuration for [StateIllustrator].
///
/// Holds default illustrations and themes for various view states.
/// Can be overridden per widget via [customLoadingConfig],
/// [customEmptyConfig], or [customErrorConfig].
class GlobalIllustratorConfig {
  /// Illustration configuration to show while the screen is loading.
  final IllustrationConfig loadingConfig;

  /// Illustration configuration to show when the screen is empty.
  final IllustrationConfig emptyConfig;

  /// Illustration configuration to show when an error occurs.
  final IllustrationConfig errorConfig;

  /// Optional theme customization for all illustrations.
  final IllustratorTheme? theme;

  /// Creates a [GlobalIllustratorConfig].
  ///
  /// All of [loadingConfig], [emptyConfig], and [errorConfig] are required.
  const GlobalIllustratorConfig({
    required this.loadingConfig,
    required this.emptyConfig,
    required this.errorConfig,
    this.theme,
  });
}
