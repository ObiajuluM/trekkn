package com.walkitapp.walkit


import io.flutter.embedding.android.FlutterFragmentActivity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterFragmentActivity(){

    private val CHANNEL = "com.walkitapp.walkit/navigation"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "openPrivacyPolicy") {
                    val intent = Intent(this, PrivacyPolicyActivity::class.java)
                    startActivity(intent)
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }
}




// package com.walkitapp.walkit

// import android.app.Activity
// import android.os.Bundle
// import android.widget.LinearLayout
// import android.widget.ScrollView
// import android.widget.TextView

// class PrivacyPolicyActivity : Activity() {

//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)

//         // Scrollable container
//         val scrollView = ScrollView(this)
//         val container = LinearLayout(this).apply {
//             orientation = LinearLayout.VERTICAL
//             setPadding(32, 32, 32, 32)
//         }
//         scrollView.addView(container)

//         // Title
//         val title = TextView(this).apply {
//             text = "Walk It Privacy Policy"
//             textSize = 20f
//         }
//         container.addView(title)

//         // Dummy Privacy Policy text
//         val content = TextView(this).apply {
//             text = """
//                 This is a sample Privacy Policy.

//                 1. Data Collection:
//                 We may collect basic health and activity information through Health Connect, 
//                 such as your step count. This data is only used to provide core app functionality.

//                 2. Data Sharing:
//                 We do not share, sell, or disclose your health data to third parties.

//                 3. Data Usage:
//                 Information collected is strictly for improving your in-app experience 
//                 and providing activity insights.

//                 4. Contact:
//                 If you have questions, please reach out to us at contact@walkitapp.com.

//                 (This is placeholder text for app review purposes.)
//             """.trimIndent()
//             textSize = 16f
//         }
//         container.addView(content)

//         // Set the layout as content view
//         setContentView(scrollView)
//     }
// }
