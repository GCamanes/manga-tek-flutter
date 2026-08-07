package com.groupany.mangatek_flutter.pigeon

import android.content.Context
import com.groupany.mangatek_flutter.BuildConfig
import com.groupany.mangatek_flutter.R

class FlavorApiImpl(private val context: Context) : FlavorApi {
    override fun getFlavor(): String = BuildConfig.FLAVOR

    override fun getAppName(): String = context.getString(R.string.app_name)

    override fun isProd(): Boolean = getFlavor() == "prod"
}
