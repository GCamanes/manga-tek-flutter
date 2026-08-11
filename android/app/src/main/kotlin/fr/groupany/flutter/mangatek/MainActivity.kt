package fr.groupany.flutter.mangatek

import fr.groupany.flutter.mangatek.pigeon.FlavorApi
import fr.groupany.flutter.mangatek.pigeon.FlavorApiImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        FlavorApi.setUp(flutterEngine.dartExecutor.binaryMessenger, FlavorApiImpl(this))
    }
}
