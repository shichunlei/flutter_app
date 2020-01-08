package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import me.yohom.amap_core_fluttify.AmapCoreFluttifyPlugin;
import me.yohom.amap_location_fluttify.AmapLocationFluttifyPlugin;
import xyz.luan.audioplayers.AudioplayersPlugin;
import com.apptreesoftware.barcodescan.BarcodeScanPlugin;
import net.goderbauer.flutter.contactpicker.ContactPickerPlugin;
import io.flutter.plugins.deviceinfo.DeviceInfoPlugin;
import com.chingsoft.flutter_jd_address_selector.FlutterJdAddressSelectorPlugin;
import io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin;
import com.dooboolab.fluttersound.FlutterSoundPlugin;
import com.flutter_webview_plugin.FlutterWebviewPlugin;
import me.yohom.foundation_fluttify.FoundationFluttifyPlugin;
import vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin;
import com.example.imagegallerysaver.ImageGallerySaverPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
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
    AmapCoreFluttifyPlugin.registerWith(registry.registrarFor("me.yohom.amap_core_fluttify.AmapCoreFluttifyPlugin"));
    AmapLocationFluttifyPlugin.registerWith(registry.registrarFor("me.yohom.amap_location_fluttify.AmapLocationFluttifyPlugin"));
    AudioplayersPlugin.registerWith(registry.registrarFor("xyz.luan.audioplayers.AudioplayersPlugin"));
    BarcodeScanPlugin.registerWith(registry.registrarFor("com.apptreesoftware.barcodescan.BarcodeScanPlugin"));
    ContactPickerPlugin.registerWith(registry.registrarFor("net.goderbauer.flutter.contactpicker.ContactPickerPlugin"));
    DeviceInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.deviceinfo.DeviceInfoPlugin"));
    FlutterJdAddressSelectorPlugin.registerWith(registry.registrarFor("com.chingsoft.flutter_jd_address_selector.FlutterJdAddressSelectorPlugin"));
    FlutterAndroidLifecyclePlugin.registerWith(registry.registrarFor("io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin"));
    FlutterSoundPlugin.registerWith(registry.registrarFor("com.dooboolab.fluttersound.FlutterSoundPlugin"));
    FlutterWebviewPlugin.registerWith(registry.registrarFor("com.flutter_webview_plugin.FlutterWebviewPlugin"));
    FoundationFluttifyPlugin.registerWith(registry.registrarFor("me.yohom.foundation_fluttify.FoundationFluttifyPlugin"));
    ImageCropperPlugin.registerWith(registry.registrarFor("vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin"));
    ImageGallerySaverPlugin.registerWith(registry.registrarFor("com.example.imagegallerysaver.ImageGallerySaverPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
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
