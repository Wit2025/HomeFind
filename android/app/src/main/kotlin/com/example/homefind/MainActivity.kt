package com.example.homefind

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		// Ensure plugins (including google_maps) are registered with the engine
		GeneratedPluginRegistrant.registerWith(flutterEngine)
	}
}
