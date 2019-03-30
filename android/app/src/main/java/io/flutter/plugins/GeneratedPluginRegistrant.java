package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.apptreesoftware.barcodescan.BarcodeScanPlugin;
import com.example.citypickers.CityPickersPlugin;
import net.goderbauer.flutter.contactpicker.ContactPickerPlugin;
import io.flutter.plugins.deviceinfo.DeviceInfoPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import com.dfa.introslider.IntroSliderPlugin;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;
import com.jhomlala.roundedletter.RoundedLetterPlugin;
import flutter.plugins.screen.screen.ScreenPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;
import io.flutter.plugins.videoplayer.VideoPlayerPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    BarcodeScanPlugin.registerWith(registry.registrarFor("com.apptreesoftware.barcodescan.BarcodeScanPlugin"));
    CityPickersPlugin.registerWith(registry.registrarFor("com.example.citypickers.CityPickersPlugin"));
    ContactPickerPlugin.registerWith(registry.registrarFor("net.goderbauer.flutter.contactpicker.ContactPickerPlugin"));
    DeviceInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.deviceinfo.DeviceInfoPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    IntroSliderPlugin.registerWith(registry.registrarFor("com.dfa.introslider.IntroSliderPlugin"));
    PackageInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
    RoundedLetterPlugin.registerWith(registry.registrarFor("com.jhomlala.roundedletter.RoundedLetterPlugin"));
    ScreenPlugin.registerWith(registry.registrarFor("flutter.plugins.screen.screen.ScreenPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
    VideoPlayerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.videoplayer.VideoPlayerPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
