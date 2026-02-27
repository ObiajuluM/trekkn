package com.walkitapp.walkitapp

import android.app.Activity
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView

class PrivacyPolicyActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val scrollView = ScrollView(this)
        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(32, 32, 32, 32)
        }
        scrollView.addView(container)

        val title = TextView(this).apply {
            text = "Walk It Privacy Policy"
            textSize = 20f
        }
        container.addView(title)

        val content = TextView(this).apply {
            text = (
                """
                This is the Walk It Privacy Policy.

                1. Data Collection:
                We may collect basic health and activity information via Health Connect,
                such as step count, to provide core app functionality.

                2. Data Sharing:
                We do not share, sell, or disclose your health data to third parties.

                3. Data Usage:
                Information collected is used to improve your in-app experience
                and provide activity insights.

                4. Contact:
                For questions, contact support@walkitapp.com.
                """
            ).trimIndent()
            textSize = 16f
        }
        container.addView(content)

        setContentView(scrollView)
    }
}
