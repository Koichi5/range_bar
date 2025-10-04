/// Enumeration for specifying label position
enum LabelPosition {
  /// Above the bar
  above,

  /// Below the bar
  below,

  /// Center of the bar
  center,

  /// No label
  none,
}

/// Enumeration for specifying detailed position of individual value labels (for individual offsets)
enum IndividualValueLabelPosition {
  /// Above the bar
  above,

  /// Below the bar
  below,

  /// Center of the bar
  center,

  /// Hide label
  none,

  /// Custom position (with offset)
  custom,
}

/// Enumeration for specifying overall value label position (for startValueLabel, endValueLabel)
enum ValueLabelPosition {
  /// Above the bar
  above,

  /// Below the bar
  below,

  /// Center of the bar
  center,

  /// Hide label
  none,
}

/// Enumeration for specifying behavior when value labels overlap
enum ValueLabelOverlapBehavior {
  /// Hide both labels when overlapping (default)
  hide,

  /// Hide only start label when overlapping
  hideStart,

  /// Hide only end label when overlapping
  hideEnd,

  /// Allow overlap and show both
  showBoth,

  /// Show only end label when overlapping
  showOnlyEnd,

  /// Show only start label when overlapping
  showOnlyStart,
}
