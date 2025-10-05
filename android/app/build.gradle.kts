plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.walkitapp.walkit"
    compileSdk = 36
    //  compileSdk = flutter.compileSdkVersion
    // ndkVersion = "27.0.12077973"
    // ndkVersion = "29.0.14033849"
     ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        //  Flag to enable support for the new language APIs
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.walkitapp.walkit"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 26     
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // multiDexEnabled = true
    
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}


dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
    
}
// dependencies {
    // classpath("com.android.tools.build:gradle:8.9.1")
    // implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.22")
    // implementation("androidx.core:core-ktx:1.12.0")


    // coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")


    // implementation("androidx.appcompat:appcompat:1.6.1") // ✅ this fixes AppCompatActivity
    // implementation ("androidx.fragment:fragment:1.7.1")
// }
