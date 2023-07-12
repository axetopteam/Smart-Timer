## Flutter wrapper
-keepattributes Signature
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class com.google.firebase.** { *; }
-keepattributes JavascriptInterface
-keepattributes Annotation
-optimizations !method/inlining/
-dontwarn io.flutter.embedding.**
# Chat Lib requirement
-keep class androidx.lifecycle.DefaultLifecycleObserver
