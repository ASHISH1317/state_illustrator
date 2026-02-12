/// Represents the current state of a screen or view.
///
/// Used by [StateIllustrator] to determine which illustration or content
/// to display.
enum ViewState {
  /// Initial state before any action has been taken.
  /// Typically shows nothing or a placeholder.
  initial,

  /// Loading state while data or content is being fetched.
  /// Displays a loading illustration or animation.
  loading,

  /// Empty state when there is no data to show.
  /// Displays an empty illustration or message.
  empty,

  /// Error state when an operation fails.
  /// Displays an error illustration and optionally a retry button.
  error,

  /// Success state when content is available.
  /// Displays the normal child widget.
  success,
}

/// Defines the type of asset to display in an illustration.
///
/// Determines how the asset is rendered in [StateIllustrator].
enum AssetType {
  /// A Scalable Vector Graphic file (`.svg`).
  svg,

  /// A Lottie animation file (`.json`).
  lottie,

  /// A raster image file such as PNG or JPG.
  png,
}
