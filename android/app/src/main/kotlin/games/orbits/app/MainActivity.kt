package games.orbits.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createAlertsChannel()
    }

    // Firebase posts every push to the channel the manifest names. Without
    // one it falls back to its own "Miscellaneous" channel at default
    // importance, so a match alert never pops up over what the player is
    // doing. Creating a channel that exists already changes nothing, and the
    // player can still turn it down in the system settings.
    private fun createAlertsChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val channel = NotificationChannel(
            getString(R.string.default_notification_channel_id),
            getString(R.string.alerts_channel_name),
            NotificationManager.IMPORTANCE_HIGH,
        ).apply { description = getString(R.string.alerts_channel_description) }
        getSystemService(NotificationManager::class.java)
            .createNotificationChannel(channel)
    }
}
