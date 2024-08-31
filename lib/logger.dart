const loggingEnabled = String.fromEnvironment("LOGGING_ENABLED") == "true";

void log(Object? o) {
  if (loggingEnabled) {
    print(o);
  }
}
