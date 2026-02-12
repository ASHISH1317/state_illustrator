import 'package:flutter/material.dart';

import '../state_illustrator.dart';

/// Default built-in illustrations shipped with the `state_illustrator` package.
///
/// Provides asset paths and default titles/subtitles for common screen states:
/// - Loading
/// - Empty
/// - Error
///
/// These defaults are used when the user does not provide a custom
/// [IllustrationConfig] for a particular [ViewState].
///
/// Example usage:
/// ```dart
/// final config = IllustrationConfig(
///   assetPath: DefaultIllustrations.loading,
///   assetType: AssetType.lottie,
///   title: DefaultIllustrations.loadingTitle,
///   subtitle: DefaultIllustrations.loadingSubtitle,
/// );

/// A widget that displays different illustrations based on the current [ViewState].
///
/// The [StateIllustrator] is useful for showing loading, empty, or error states
/// with optional retry buttons. It can also display a custom widget or asset
/// (Lottie animation, SVG, PNG) for each state. When the state is [ViewState.success],
/// the provided [child] widget is displayed.
///
/// Animated transitions are used when switching between states.
///
/// Example usage:
/// ```dart
/// StateIllustrator(
///   state: viewState,
///   child: ListView(...),
///   onRetry: () => fetchData(),
/// );
/// ```
class StateIllustrator extends StatelessWidget {
  /// The current view state to display.
  ///
  /// Determines which illustration or content is rendered.
  final ViewState state;

  /// The child widget to display when [state] is [ViewState.success].
  final Widget child;

  /// Callback triggered when retry button is pressed in the error state.
  ///
  /// Only applicable for [ViewState.error].
  final VoidCallback? onRetry;

  /// Optional global configuration containing default illustrations and theme.
  ///
  /// If not provided, the widget uses built-in default assets and titles.
  final GlobalIllustratorConfig? config;

  /// Creates a [StateIllustrator].
  ///
  /// The [state] and [child] are required. Optional [onRetry] callback is used
  /// for error states. Optional [config] allows customization of illustrations,
  /// titles, subtitles, button styles, and theme.
  const StateIllustrator({
    super.key,
    required this.state,
    required this.child,
    this.onRetry,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the current content based on the state
    Widget currentChild;
    switch (state) {
      case ViewState.loading:
        currentChild =
            _buildIllustration(_getEffectiveConfig(ViewState.loading));
        break;
      case ViewState.empty:
        currentChild = _buildIllustration(_getEffectiveConfig(ViewState.empty));
        break;
      case ViewState.error:
        currentChild = _buildIllustration(
          _getEffectiveConfig(ViewState.error),
          onRetry: onRetry,
        );
        break;
      case ViewState.success:
        currentChild = child;
        break;
      case ViewState.initial:
        currentChild = const SizedBox.shrink();
        break;
    }

    // Wrap content in AnimatedSwitcher for smooth state transitions
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: currentChild,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  /// Returns the effective [IllustrationConfig] for the given [state].
  ///
  /// Combines user-provided configuration from [config] with built-in defaults.
  IllustrationConfig _getEffectiveConfig(ViewState state) {
    IllustrationConfig? cfg;

    switch (state) {
      case ViewState.loading:
        cfg = config?.loadingConfig;
        return cfg ??
            IllustrationConfig(
              assetPath: DefaultIllustrations.loading,
              assetType: AssetType.lottie,
              title: DefaultIllustrations.loadingTitle,
              subtitle: DefaultIllustrations.loadingSubtitle,
            );
      case ViewState.empty:
        cfg = config?.emptyConfig;
        return cfg ??
            IllustrationConfig(
              assetPath: DefaultIllustrations.empty,
              assetType: AssetType.svg,
              title: DefaultIllustrations.emptyTitle,
              subtitle: DefaultIllustrations.emptySubtitle,
            );
      case ViewState.error:
        cfg = config?.errorConfig;
        return cfg ??
            IllustrationConfig(
              assetPath: DefaultIllustrations.error,
              assetType: AssetType.png,
              title: DefaultIllustrations.errorTitle,
              subtitle: DefaultIllustrations.errorSubtitle,
            );
      default:
        return const IllustrationConfig();
    }
  }

  /// Builds the illustration widget based on the provided [config].
  ///
  /// Supports custom widgets via [IllustrationConfig.customWidget] or assets
  /// (Lottie, SVG, PNG). Optionally displays a retry button for error states.
  Widget _buildIllustration(
    IllustrationConfig config, {
    VoidCallback? onRetry,
  }) {
    Widget? assetWidget;

    // Use custom widget if provided
    if (config.customWidget != null) {
      assetWidget = config.customWidget!;
    } else if (config.assetPath != null) {
      // Render asset based on type
      final AssetType type =
          config.assetType ?? _detectAssetType(config.assetPath!);

      bool isPackageAsset(String assetPath) {
        return identical(assetPath, DefaultIllustrations.loading) ||
            identical(assetPath, DefaultIllustrations.empty) ||
            identical(assetPath, DefaultIllustrations.error);
      }

      try {
        switch (type) {
          case AssetType.lottie:
            assetWidget = Lottie.asset(
              config.assetPath!,
              package: _package(isPackageAsset, config),
              height: config.assetHeight ?? 150,
              width: config.assetWidth ?? 150,
              errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 48),
            );
            break;
          case AssetType.svg:
            assetWidget = SvgPicture.asset(
              config.assetPath!,
              package: _package(isPackageAsset, config),
              height: config.assetHeight ?? 150,
              width: config.assetWidth ?? 150,
            );
            break;
          case AssetType.png:
            assetWidget = Image.asset(
              config.assetPath!,
              package: _package(isPackageAsset, config),
              height: config.assetHeight ?? 150,
              width: config.assetWidth ?? 150,
            );
            break;
        }
      } catch (_) {
        assetWidget = const Icon(Icons.error, size: 48);
      }
    }

    return Semantics(
      liveRegion: true,
      label: config.title ?? "Screen state",
      child: Container(
        width: config.width ?? double.infinity,
        height: config.height ?? double.infinity,
        color: configTheme?.backgroundColor ?? Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: config.padding ?? EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (assetWidget != null) assetWidget,
                if (config.hasTitle) ...[
                  SizedBox(
                    height: config.titleSpacing ?? 16,
                  ),
                  Text(
                    config.title!,
                    style: configTheme?.titleStyle ??
                        const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
                if (config.hasSubtitle) ...[
                  SizedBox(
                    height: config.subtitleSpacing ?? 8,
                  ),
                  Text(
                    config.subtitle!,
                    textAlign: TextAlign.center,
                    style: configTheme?.subtitleStyle ??
                        const TextStyle(fontSize: 16),
                  ),
                ],
                if (state == ViewState.error && onRetry != null)
                  config.button ??
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          onPressed: onRetry,
                          style: config.buttonStyle ??
                              ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Package check
  String? _package(
    bool Function(String assetPath) isPackageAsset,
    IllustrationConfig config,
  ) {
    return isPackageAsset(config.assetPath!) ? 'state_illustrator' : null;
  }

  /// Returns the theme from global config if provided.
  IllustratorTheme? get configTheme => config?.theme;

  /// Auto-detects asset type by file extension.
  ///
  /// `.json` → Lottie, `.svg` → SVG, others → PNG.
  AssetType _detectAssetType(String path) {
    if (path.endsWith('.json')) return AssetType.lottie;
    if (path.endsWith('.svg')) return AssetType.svg;
    return AssetType.png;
  }
}
