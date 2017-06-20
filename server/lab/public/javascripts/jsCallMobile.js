/**
 * Created by sjg on 2017/6/19.
 */
jsCallMobileErr = function jsCallMobileErr() {
    alert("此功能即将开放");
}

/**
 * js 调用iOS wkwebview 的方法 (支持安卓 webview 调用)
 *
 * @param  funcName 交互事件方法名
 * @param  para     交互事件约定参数
 *
 * 注意: 从 iOS8.0 开始, iOS 推出 WKWebView 对于html5, 以及js 等执行效率比 UIWebView 高很多, 强烈建议使用 wkwebview
 * */
function jsCallWkWebView(funcName, para) {
    try {
        // 判断手机类型
        var ua = navigator.userAgent.toLowerCase();
        if (/iphone|ipad|ipod/.test(ua)) {
            para.funcName = funcName;
            window.webkit.messageHandlers.JSCallMobile.postMessage(para);
        } else if (/android/.test(ua)) {
            var json = JSON.stringify(para);
            window.JSCallMobile[funcName](json);
        }
    } catch (e) {
        jsCallMobileErr();
    }
}

/**
 * js 调用iOS  UIWebView 的方法 (支持安卓 webview 调用)
 *
 * @param  funcName 交互事件方法名
 * @param  para     交互事件约定参数
 *
 * 注意: 由于 iOS UIWebView 性能较差, 从 iOS8.0 开始推出 wkwebview, 虽然依然存在不少 bug, 但从性能考虑, 强烈不建议使用 UIWebView
 * */
function jsCallUIWebView(funcName, para) {
    try {
        return window.JSCallMobile[funcName](para);
    } catch (e) {
        jsCallMobileErr();
    }
}