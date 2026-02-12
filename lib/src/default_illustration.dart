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
/// ```
class DefaultIllustrations {
  /// Path to the default loading animation asset (Lottie `.json`).
  ///
  /// Typically displayed when the screen is fetching data.
  static const String loading = 'assets/default/loading.json';

  /// Path to the default empty state illustration (SVG).
  ///
  /// Typically displayed when there is no content to show.
  static const String empty = 'assets/default/empty.svg';

  /// Path to the default error state illustration (PNG).
  ///
  /// Typically displayed when an operation fails or content cannot load.
  static const String error = 'assets/default/error.png';

  /// Default title for the loading state.
  ///
  /// Shown above the loading illustration if no custom title is provided.
  static const String loadingTitle = 'Loading...';

  /// Default subtitle for the loading state.
  ///
  /// Shown below the loading illustration if no custom subtitle is provided.
  static const String loadingSubtitle = 'Please wait a moment.';

  /// Default title for the empty state.
  ///
  /// Shown above the empty state illustration if no custom title is provided.
  static const String emptyTitle = 'Nothing here';

  /// Default subtitle for the empty state.
  ///
  /// Shown below the empty state illustration if no custom subtitle is provided.
  static const String emptySubtitle = 'No data available.';

  /// Default title for the error state.
  ///
  /// Shown above the error illustration if no custom title is provided.
  static const String errorTitle = 'Oops!';

  /// Default subtitle for the error state.
  ///
  /// Shown below the error illustration if no custom subtitle is provided.
  static const String errorSubtitle = 'Something went wrong.';
}
