package com.walkitapp.walkit

import android.app.Activity
import android.content.res.Configuration
import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.util.TypedValue
import android.view.Gravity
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView
import android.widget.FrameLayout

class PrivacyPolicyActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Detect if system is in dark mode
        val isDarkMode =
            (resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES

        // Define colors depending on theme
        val backgroundColor = if (isDarkMode) Color.BLACK else Color.WHITE
        val primaryTextColor = if (isDarkMode) Color.WHITE else Color.BLACK
        val secondaryTextColor = if (isDarkMode) Color.LTGRAY else Color.DKGRAY
        val appBarColor = if (isDarkMode) Color.parseColor("#222222") else Color.parseColor("#00ee3bff")

        // Root container
        val rootLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(backgroundColor)
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        }

        // App Bar
        val appBar = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setBackgroundColor(appBarColor)
            setPadding(48, 96, 48, 48)
            elevation = 8f
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
            )
        }

        val appBarTitle = TextView(this).apply {
            text = "Privacy Policy"
            textSize = 22f
            setTypeface(null, Typeface.BOLD)
            setTextColor(if (isDarkMode) Color.WHITE else Color.BLACK)
            gravity = Gravity.CENTER_VERTICAL
        }

        appBar.addView(appBarTitle)
        rootLayout.addView(appBar)

        // Scrollable content
        val scrollView = ScrollView(this).apply {
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
        }

        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(64, 48, 64, 96)
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
            )
        }

        scrollView.addView(container)

        // Helper function to add sections
        fun addSection(header: String, body: String) {
            val headerView = TextView(this).apply {
                text = header
                textSize = 18f
                setTypeface(null, Typeface.BOLD)
                setPadding(0, 24, 0, 8)
                setTextColor(primaryTextColor)
            }

            val bodyView = TextView(this).apply {
                text = body
                textSize = 16f
                setLineSpacing(6f, 1.3f)
                setTextColor(secondaryTextColor)
            }

            container.addView(headerView)
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
            "If you have any questions, please reach out to us at gm@walkitapp.com."
        )

        rootLayout.addView(scrollView)
        setContentView(rootLayout)
    }
}
