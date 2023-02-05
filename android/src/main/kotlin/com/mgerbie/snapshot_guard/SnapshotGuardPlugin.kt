package com.mgerbie.snapshot_guard

import android.app.Activity
import android.view.Display
import android.view.WindowManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SnapshotGuardPlugin */
class SnapshotGuardPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    private var flag = WindowManager.LayoutParams.FLAG_SECURE
    private var hide = false

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "snapshot_guard")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "toggleGuard" -> {
                this.toggleGuard(result)
                return
            }
            "switchGuardStatus" -> {
               val arg :Boolean = call.arguments<Boolean>() == true
                switchGuardStatus(arg,result)
                return
            }
            else -> {
                result.notImplemented()
                return
            }
        }
    }

    private fun switchGuardStatus(status: Boolean, result: Result) {
        if (status) {
            activity?.window?.addFlags(flag)
        } else {
            activity?.window?.clearFlags(flag)
        }
        if (activity != null) {
            hide = status
            result.success(hide)

        } else {
            result.success(!status)
        }
    }

    private fun toggleGuard(result: Result) {
        hide = !hide
        if (hide) {
            activity?.window?.addFlags(flag)
        } else {
            activity?.window?.clearFlags(flag)
        }
        if (activity != null) {
            result.success(hide)

        } else {
            result.success(false)
        }
    }


    override fun onDetachedFromEngine( binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.onAttachedToActivity(binding)
    }

}
