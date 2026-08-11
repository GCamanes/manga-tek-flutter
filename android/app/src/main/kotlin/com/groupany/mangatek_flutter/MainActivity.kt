package com.groupany.mangatek_flutter

import com.groupany.mangatek_flutter.pigeon.FlavorApi
import com.groupany.mangatek_flutter.pigeon.FlavorApiImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        FlavorApi.setUp(flutterEngine.dartExecutor.binaryMessenger, FlavorApiImpl(this))
    }
}
