//  for release
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// for release
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}


// 

android {
    namespace = "com.walkitapp.walkitapp"
    compileSdk = 36
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
        applicationId = "com.walkitapp.walkitapp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 26     
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // multiDexEnabled = true
    
    }

//  for release
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }


    buildTypes {
        release {
            // Signing with the debug keys for now, so `flutter run --release` works.
            // signingConfig = signingConfigs.getByName("debug")
            signingConfig = signingConfigs.getByName("release")
            // isMinifyEnabled = false
            // isShrinkResources = false
        }
    }

    flavorDimensions += "default"
    productFlavors{
        create("prod"){
            dimension = "default"
            resValue(type="string", name="app_name", value="Walk It")
        }
        create("dev"){
            dimension = "default"
            resValue(type="string", name="app_name", value="Walk It.dev")
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
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
