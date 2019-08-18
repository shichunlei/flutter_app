package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import me.yohom.amapbaselocation.AMapBaseLocationPlugin;
import com.apptreesoftware.barcodescan.BarcodeScanPlugin;
import com.example.citypickers.CityPickersPlugin;
import net.goderbauer.flutter.contactpicker.ContactPickerPlugin;
import io.flutter.plugins.deviceinfo.DeviceInfoPlugin;
import com.mtechviral.musicfinder.MusicFinderPlugin;
import com.chingsoft.flutter_jd_address_selector.FlutterJdAddressSelectorPlugin;
import com.flutter_webview_plugin.FlutterWebviewPlugin;
import vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import io.flutter.plugins.imagepickersaver.ImagePickerSaverPlugin;
import com.dfa.introslider.IntroSliderPlugin;
import com.vitanov.multiimagepicker.MultiImagePickerPlugin;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import com.jhomlala.roundedletter.RoundedLetterPlugin;
import flutter.plugins.screen.screen.ScreenPlugin;
import io.flutter.plugins.share.SharePlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.tekartik.sqflite.SqflitePlugin;
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
    AMapBaseLocationPlugin.registerWith(registry.registrarFor("me.yohom.amapbaselocation.AMapBaseLocationPlugin"));
    BarcodeScanPlugin.registerWith(registry.registrarFor("com.apptreesoftware.barcodescan.BarcodeScanPlugin"));
    CityPickersPlugin.registerWith(registry.registrarFor("com.example.citypickers.CityPickersPlugin"));
    ContactPickerPlugin.registerWith(registry.registrarFor("net.goderbauer.flutter.contactpicker.ContactPickerPlugin"));
    DeviceInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.deviceinfo.DeviceInfoPlugin"));
    MusicFinderPlugin.registerWith(registry.registrarFor("com.mtechviral.musicfinder.MusicFinderPlugin"));
    FlutterJdAddressSelectorPlugin.registerWith(registry.registrarFor("com.chingsoft.flutter_jd_address_selector.FlutterJdAddressSelectorPlugin"));
    FlutterWebviewPlugin.registerWith(registry.registrarFor("com.flutter_webview_plugin.FlutterWebviewPlugin"));
    ImageCropperPlugin.registerWith(registry.registrarFor("vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    ImagePickerSaverPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepickersaver.ImagePickerSaverPlugin"));
    IntroSliderPlugin.registerWith(registry.registrarFor("com.dfa.introslider.IntroSliderPlugin"));
    MultiImagePickerPlugin.registerWith(registry.registrarFor("com.vitanov.multiimagepicker.MultiImagePickerPlugin"));
    PackageInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
    RoundedLetterPlugin.registerWith(registry.registrarFor("com.jhomlala.roundedletter.RoundedLetterPlugin"));
    ScreenPlugin.registerWith(registry.registrarFor("flutter.plugins.screen.screen.ScreenPlugin"));
    SharePlugin.registerWith(registry.registrarFor("io.flutter.plugins.share.SharePlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
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
