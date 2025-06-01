# 🚀 部署指南

本文档详细说明了 Star Trek 应用在各个平台的部署流程和配置要求。

## 📋 目录

- [部署概述](#部署概述)
- [环境配置](#环境配置)
- [iOS 部署](#ios-部署)
- [Android 部署](#android-部署)
- [Web 部署](#web-部署)
- [桌面应用部署](#桌面应用部署)
- [CI/CD 配置](#cicd-配置)
- [监控和日志](#监控和日志)

## 🔍 部署概述

### 支持平台

- **移动端**: iOS (App Store), Android (Google Play)
- **Web端**: 现代浏览器支持
- **桌面端**: macOS, Windows, Linux

### 部署环境

- **开发环境**: 本地开发和测试
- **测试环境**: 内部测试和QA
- **预生产环境**: 生产前最终验证
- **生产环境**: 正式发布版本

## ⚙️ 环境配置

### 基础要求

```bash
# Flutter SDK
Flutter 3.16.0 或更高版本
Dart 3.2.0 或更高版本

# 开发工具
Xcode 15.0+ (iOS)
Android Studio 2023.1+ (Android)
VS Code (推荐)
```

### 环境变量配置

创建 `.env` 文件：

```bash
# API 配置
API_BASE_URL=https://api.startrek.app
API_VERSION=v1

# 第三方服务
FIREBASE_PROJECT_ID=star-trek-app
SENTRY_DSN=https://your-sentry-dsn
ANALYTICS_ID=your-analytics-id

# 功能开关
ENABLE_ANALYTICS=true
ENABLE_CRASH_REPORTING=true
DEBUG_MODE=false
```

### 配置文件管理

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.startrek.app',
  );
  
  static const String apiVersion = String.fromEnvironment(
    'API_VERSION',
    defaultValue: 'v1',
  );
  
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: true,
  );
}
```

## 📱 iOS 部署

### 开发环境设置

1. **安装 Xcode**
   ```bash
   # 检查 Xcode 版本
   xcode-select --version
   
   # 安装 Command Line Tools
   xcode-select --install
   ```

2. **配置开发者账号**
   - 登录 Apple Developer Portal
   - 配置 App ID 和证书
   - 设置 Provisioning Profiles

### 项目配置

1. **Bundle Identifier 设置**
   ```xml
   <!-- ios/Runner/Info.plist -->
   <key>CFBundleIdentifier</key>
   <string>com.startrek.app</string>
   ```

2. **版本号配置**
   ```yaml
   # pubspec.yaml
   version: 1.0.0+1
   ```

3. **权限配置**
   ```xml
   <!-- ios/Runner/Info.plist -->
   <key>NSCameraUsageDescription</key>
   <string>用于拍照和扫描功能</string>
   
   <key>NSMicrophoneUsageDescription</key>
   <string>用于语音交互功能</string>
   
   <key>NSPhotoLibraryUsageDescription</key>
   <string>用于选择和保存图片</string>
   ```

### 构建和发布

1. **开发版本构建**
   ```bash
   # 构建开发版本
   flutter build ios --debug
   
   # 在模拟器运行
   flutter run -d "iPhone 15 Pro"
   ```

2. **发布版本构建**
   ```bash
   # 构建发布版本
   flutter build ios --release
   
   # 构建 Archive
   flutter build ipa --release
   ```

3. **App Store 发布**
   ```bash
   # 使用 Xcode 上传到 App Store Connect
   open ios/Runner.xcworkspace
   
   # 或使用命令行工具
   xcrun altool --upload-app --type ios \
     --file build/ios/ipa/star_trek.ipa \
     --username "your-apple-id" \
     --password "app-specific-password"
   ```

### iOS 配置文件

```yaml
# ios/Flutter/Release.xcconfig
#include "Generated.xcconfig"

# 自定义配置
FLUTTER_BUILD_MODE=release
API_BASE_URL=https://api.startrek.app
ENABLE_ANALYTICS=true
```

## 🤖 Android 部署

### 开发环境设置

1. **Android Studio 配置**
   ```bash
   # 检查 Android SDK
   flutter doctor --android-licenses
   
   # 设置环境变量
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
   ```

2. **签名配置**
   ```bash
   # 生成签名密钥
   keytool -genkey -v -keystore ~/star-trek-key.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias star-trek
   ```

### 项目配置

1. **应用 ID 设置**
   ```gradle
   // android/app/build.gradle
   android {
       defaultConfig {
           applicationId "com.startrek.app"
           minSdkVersion 21
           targetSdkVersion 34
           versionCode 1
           versionName "1.0.0"
       }
   }
   ```

2. **签名配置**
   ```gradle
   // android/app/build.gradle
   android {
       signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
               minifyEnabled true
               proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
           }
       }
   }
   ```

3. **权限配置**
   ```xml
   <!-- android/app/src/main/AndroidManifest.xml -->
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

### 构建和发布

1. **开发版本构建**
   ```bash
   # 构建 APK
   flutter build apk --debug
   
   # 安装到设备
   flutter install
   ```

2. **发布版本构建**
   ```bash
   # 构建发布 APK
   flutter build apk --release
   
   # 构建 App Bundle (推荐)
   flutter build appbundle --release
   ```

3. **Google Play 发布**
   ```bash
   # 上传到 Google Play Console
   # 使用 Google Play Console 网页界面
   # 或使用 fastlane 自动化工具
   ```

### ProGuard 配置

```proguard
# android/app/proguard-rules.pro

# Flutter 相关
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# 第三方库
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
```

## 🌐 Web 部署

### 构建配置

1. **Web 构建**
   ```bash
   # 构建 Web 应用
   flutter build web --release
   
   # 指定基础路径
   flutter build web --base-href "/star-trek/"
   
   # 启用 PWA
   flutter build web --pwa-strategy offline-first
   ```

2. **PWA 配置**
   ```json
   // web/manifest.json
   {
     "name": "Star Trek - 儿童学习探险",
     "short_name": "Star Trek",
     "start_url": ".",
     "display": "standalone",
     "background_color": "#2196F3",
     "theme_color": "#2196F3",
     "description": "专为儿童设计的互动学习应用",
     "orientation": "portrait-primary",
     "prefer_related_applications": false,
     "icons": [
       {
         "src": "icons/Icon-192.png",
         "sizes": "192x192",
         "type": "image/png"
       },
       {
         "src": "icons/Icon-512.png",
         "sizes": "512x512",
         "type": "image/png"
       }
     ]
   }
   ```

### 服务器部署

1. **Nginx 配置**
   ```nginx
   # /etc/nginx/sites-available/startrek
   server {
       listen 80;
       server_name startrek.app www.startrek.app;
       
       # 重定向到 HTTPS
       return 301 https://$server_name$request_uri;
   }
   
   server {
       listen 443 ssl http2;
       server_name startrek.app www.startrek.app;
       
       # SSL 证书配置
       ssl_certificate /path/to/certificate.crt;
       ssl_certificate_key /path/to/private.key;
       
       # 网站根目录
       root /var/www/startrek/build/web;
       index index.html;
       
       # Flutter Web 路由配置
       location / {
           try_files $uri $uri/ /index.html;
       }
       
       # 静态资源缓存
       location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
           expires 1y;
           add_header Cache-Control "public, immutable";
       }
       
       # 安全头
       add_header X-Frame-Options "SAMEORIGIN" always;
       add_header X-Content-Type-Options "nosniff" always;
       add_header Referrer-Policy "no-referrer-when-downgrade" always;
   }
   ```

2. **Docker 部署**
   ```dockerfile
   # Dockerfile
   FROM nginx:alpine
   
   # 复制构建文件
   COPY build/web /usr/share/nginx/html
   
   # 复制 Nginx 配置
   COPY nginx.conf /etc/nginx/nginx.conf
   
   # 暴露端口
   EXPOSE 80
   
   # 启动 Nginx
   CMD ["nginx", "-g", "daemon off;"]
   ```

3. **CDN 配置**
   ```bash
   # 使用 AWS CloudFront 或其他 CDN
   # 配置缓存策略和压缩
   ```

## 🖥 桌面应用部署

### macOS 部署

1. **构建 macOS 应用**
   ```bash
   # 启用 macOS 支持
   flutter config --enable-macos-desktop
   
   # 构建应用
   flutter build macos --release
   ```

2. **代码签名**
   ```bash
   # 签名应用
   codesign --force --verify --verbose --sign "Developer ID Application: Your Name" \
     build/macos/Build/Products/Release/star_trek.app
   
   # 公证应用
   xcrun notarytool submit build/macos/Build/Products/Release/star_trek.app.zip \
     --apple-id "your-apple-id" \
     --password "app-specific-password" \
     --team-id "your-team-id"
   ```

### Windows 部署

1. **构建 Windows 应用**
   ```bash
   # 启用 Windows 支持
   flutter config --enable-windows-desktop
   
   # 构建应用
   flutter build windows --release
   ```

2. **创建安装包**
   ```bash
   # 使用 Inno Setup 或 NSIS 创建安装程序
   # 或使用 MSIX 打包
   flutter pub run msix:create
   ```

### Linux 部署

1. **构建 Linux 应用**
   ```bash
   # 启用 Linux 支持
   flutter config --enable-linux-desktop
   
   # 构建应用
   flutter build linux --release
   ```

2. **创建 AppImage**
   ```bash
   # 使用 AppImageTool 创建 AppImage
   # 或创建 Snap/Flatpak 包
   ```

## 🔄 CI/CD 配置

### GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Build and Deploy

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
    - run: flutter pub get
    - run: flutter test
    - run: flutter analyze

  build-ios:
    needs: test
    runs-on: macos-latest
    if: github.ref == 'refs/heads/main'
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
    - run: flutter pub get
    - run: flutter build ios --release --no-codesign
    - name: Upload iOS build
      uses: actions/upload-artifact@v3
      with:
        name: ios-build
        path: build/ios/iphoneos/

  build-android:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        distribution: 'zulu'
        java-version: '17'
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
    - run: flutter pub get
    - run: flutter build appbundle --release
    - name: Upload Android build
      uses: actions/upload-artifact@v3
      with:
        name: android-build
        path: build/app/outputs/bundle/release/

  build-web:
    needs: test
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
    - run: flutter pub get
    - run: flutter build web --release
    - name: Deploy to GitHub Pages
      if: github.ref == 'refs/heads/main'
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./build/web
```

### Fastlane 配置

```ruby
# fastlane/Fastfile
default_platform(:ios)

platform :ios do
  desc "Build and upload to TestFlight"
  lane :beta do
    build_app(
      scheme: "Runner",
      export_method: "app-store",
      output_directory: "./build/ios/"
    )
    upload_to_testflight(
      skip_waiting_for_build_processing: true
    )
  end
end

platform :android do
  desc "Build and upload to Google Play"
  lane :beta do
    gradle(
      task: "bundle",
      build_type: "Release",
      project_dir: "android/"
    )
    upload_to_play_store(
      track: "beta",
      aab: "../build/app/outputs/bundle/release/app-release.aab"
    )
  end
end
```

## 📊 监控和日志

### 错误监控

1. **Sentry 集成**
   ```dart
   // lib/main.dart
   import 'package:sentry_flutter/sentry_flutter.dart';
   
   Future<void> main() async {
     await SentryFlutter.init(
       (options) {
         options.dsn = 'YOUR_SENTRY_DSN';
         options.environment = 'production';
       },
       appRunner: () => runApp(MyApp()),
     );
   }
   ```

2. **Firebase Crashlytics**
   ```dart
   // lib/main.dart
   import 'package:firebase_crashlytics/firebase_crashlytics.dart';
   
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     
     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
     
     runApp(MyApp());
   }
   ```

### 性能监控

```dart
// lib/core/monitoring/performance_monitor.dart
class PerformanceMonitor {
  static void trackScreenView(String screenName) {
    FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }
  
  static void trackUserAction(String action, Map<String, dynamic> parameters) {
    FirebaseAnalytics.instance.logEvent(
      name: action,
      parameters: parameters,
    );
  }
}
```

### 日志管理

```dart
// lib/core/logging/app_logger.dart
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
  
  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
```

## 🔒 安全配置

### 网络安全

```dart
// lib/core/network/security_config.dart
class SecurityConfig {
  static const bool enableCertificatePinning = true;
  static const List<String> pinnedCertificates = [
    'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
  ];
  
  static const Duration requestTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
}
```

### 数据加密

```dart
// lib/core/security/encryption_service.dart
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static final _key = Key.fromSecureRandom(32);
  static final _iv = IV.fromSecureRandom(16);
  static final _encrypter = Encrypter(AES(_key));
  
  static String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }
  
  static String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
```

---

📝 **注意**: 部署前请确保所有配置文件中的敏感信息已正确设置，并遵循各平台的安全最佳实践。