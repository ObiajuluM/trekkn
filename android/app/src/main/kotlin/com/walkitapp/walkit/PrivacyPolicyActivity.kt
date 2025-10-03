package com.walkitapp.walkit


import android.app.Activity
import android.graphics.Typeface
import android.graphics.Color
import android.os.Bundle
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView

class PrivacyPolicyActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Root container
        val rootLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            
        }

        // "App Bar"
        val appBar = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setBackgroundColor(Color.parseColor("#00ee3bff")) // Purple like Material default
            setPadding(32, 32, 32, 32) // top padding for status bar area
        }

        val appBarTitle = TextView(this).apply {
            text = "Privacy Policy"
            textSize = 20f
            setTypeface(null, Typeface.BOLD)            
            gravity = Gravity.CENTER_VERTICAL
        }
        appBar.addView(appBarTitle)
        rootLayout.addView(appBar)

        // Scrollable content
        val scrollView = ScrollView(this)
        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(48, 48, 48, 48)
        }
        scrollView.addView(container)

        // Helper function to add sections
        fun addSection(header: String, body: String) {
            val headerView = TextView(this).apply {
                text = header
                textSize = 18f
                setTypeface(null, Typeface.BOLD)
                setPadding(0, 16, 0, 8)
                setTextColor(Color.BLACK)
            }
            container.addView(headerView)

            val bodyView = TextView(this).apply {
                text = body
                textSize = 16f
                setLineSpacing(4f, 1.2f)
                setTextColor(Color.DKGRAY)
            }
            container.addView(bodyView)
        }

        // Sections
        addSection("Last Updated", "January 2025")

        addSection(
            "1. Data Collection",
            "We may collect health data such as step count through Health Connect. " +
                    "This information is used only to provide activity insights and improve your experience."
        )

        addSection(
            "2. Data Sharing",
            "We do not share, sell, or disclose your health data to third parties."
        )

        addSection(
            "3. Data Usage",
            "Your health data is strictly used to enable features within the app, " +
                    "such as step tracking, progress monitoring, and activity insights."
        )

        addSection(
            "4. Contact",
            "If you have any questions, please reach out to us at hi@walkitapp.com."
        )

        rootLayout.addView(scrollView)

        // Final set content
        setContentView(rootLayout)
    }
}
