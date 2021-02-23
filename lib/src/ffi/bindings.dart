import 'package:meta/meta.dart';

import '../generated/abstract_bindings.dart';
import '../generated/lazy_bindings.dart';
import 'library.dart';

// Internal cached bindings.
AbstractBindings? _bindings;

/// Cached RTL-SDR library bindings.
@visibleForTesting
set bindings(AbstractBindings bindings) => _bindings = bindings;

/// Return the currently loaded RTL-SDR library bindings.
AbstractBindings get bindings => _bindings ??= LazyBindings(loadLibrary());
