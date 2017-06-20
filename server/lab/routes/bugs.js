/**
 * Created by sjg on 2017/6/19.
 */
var express = require('express');
var router = express.Router();
var path = require('path');

/* GET bugs page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'bugs' });
});

/**
 * bug 概述
 *
 * 设备: iPhone 6s, 10.2.1, iPhone 6. 10.3.1, UIWebView
 * 现象: 当页面有输入, 弹出键盘后, 再次调用 UIWebView 事件时崩溃(js 调用原生分享, 原生使用了 sharesdk 进行分享操作)
 * 崩溃原因: iOS 输出日志: -[UIKeyboardTaskQueue waitUntilAllTasksAreFinished] may only be called from the main thread.
 * log 分析: 经检测, 当键盘弹起后, 交互事件的回调在 iOS 的分线程中, 由于执行了 UI 操作, 导致闪退(后检测正常直接调用也是在分线程中, 但并不崩溃)
 * 奇怪的现象: 当调用原生方法前使用 alert 就不会崩溃
 * 解决方案: 由于 app 发布较慢, 由嵌入网页修复, 根据 alert 不崩溃查询 alert 的操作, 暂时处理方式为 console + 延时调用, 实际现象, 延时并未起作用, 但是 app 不再崩溃
 *
 * */
function bugs_001(req, res, next) {

    var r = { root: path.resolve(__dirname+'/../public/bugs') };
    res.sendFile('bugs_001.html', r);
}
router.get('/bugs_001', bugs_001);
router.post('/bugs_001', bugs_001);

module.exports = router;
