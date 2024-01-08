package com.example.flutter_application_template

import android.app.AlertDialog
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private  var ChannelName = "NativeChannel";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // 创建MethodChannel对象
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ChannelName)

        // 注册MethodChannel的回调方法
        channel.setMethodCallHandler { call, result ->
            if (call.method == "showAlert") {
                showAlert(call,result);
            } else {
                result.notImplemented()
            }
        }


    }


    private fun showAlert(call: MethodCall, result:MethodChannel.Result) {
        val title = call.argument<String>("title")?:"标题"
        val content = call.argument<String>("content")?:"内容"
        val builder = AlertDialog.Builder(this)
        builder.setTitle(title)
        builder.setMessage(content)
        builder.setPositiveButton("确定"){dialog,which ->
            result.success("安卓用户点击了确定")
        }
        builder.show()
    }

}
