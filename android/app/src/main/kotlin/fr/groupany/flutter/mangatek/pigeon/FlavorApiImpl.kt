package fr.groupany.flutter.mangatek.pigeon

import android.content.Context
import fr.groupany.flutter.mangatek.BuildConfig
import fr.groupany.flutter.mangatek.R

class FlavorApiImpl(private val context: Context) : FlavorApi {
    override fun getFlavor(): String = BuildConfig.FLAVOR

    override fun getAppName(): String = context.getString(R.string.app_name)

    override fun isProd(): Boolean = getFlavor() == "prod"
}
