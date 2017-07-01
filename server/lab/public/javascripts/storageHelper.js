/**
 * Created by sjg on 2017/7/1.
 */

//===================== cookie ==============================
// cookie 定义: (https://zh.wikipedia.org/wiki/Cookie)
//===========================================================
// 1. cookie 数据始终在同源的http请求中携带（即使不需要）
// 2. cookie 数据不能超过4k
// 3. cookie 只在设置的cookie过期时间之前一直有效，即使窗口或浏览器关闭
// 4. cookie 数据还有路径（path）的概念，可以限制cookie只属于某个路径下
// 5. cookie 在所有同源窗口中都是共享的
// 6. cookie 格式: value[; expires=date][; domain=domain][; path=path][; secure] 详见:(http://bubkoo.com/2014/04/21/http-cookies-explained/)
//        6.1. value: 通常为 name=value 格式的字符串, 但浏览器并不会做检测
//        6.2. expires: cookie 有效期, 值应为 Wdy, DD-Mon-YYYY HH:MM:SS GMT 格式字符串, 常用 date.toUTCString();
//                      若设置, cookie 则在有效期内保留, 超出即被删除.
//                      若设置一个已经过去的时间, 则会被立刻删除
//                      若不设置, 则 cookie 的生命周期仅为当前会话, 浏览器关闭后即被删除
//        6.3. domain: 指定了请求时 cookie 发送的地方, 默认为创建 cookie 的页面所在的域名, 且 domain 必须为该页面的主机名的一部分
//        6.4. path: cookie 路径, 只有当请求地址与 包含 path 时 cookie 才会被发送
//        6.5. secure: 若标记, 则只有请求通过 ssl/https 时 cookie 才会被发送
//        6.6. SameSite: Strict/Lax (http://bobao.360.cn/learning/detail/2844.html)
//===========================================================
/**
 * 新增/修改/删除 cookie 的简单方法
 *
 * @param key cookie key 字符串类型
 * @param value cookie value, 字符串类型
 * @param expiresSecond cookie 多少秒后过期(存入cookie的格式为: Wdy, DD-Mon-YYYY HH:MM:SS GMT 字符串), 默认生命周期仅为当前会话中, 关闭浏览器 cookie 丢失
 * @param path cookie 限制路径, 默认根目录
 * @param domain cookie 将要被发送到的域名, 默认创建该 cookie 的页面所在的域名, domain 可用来扩充cookie 可发送域的数量
 * @param secure 安全标记, true/false 若标记则只有 ssl/https cookie 才会被发送
 * @param sameSite 跨域安全机制, Strict/Lax 详见(http://bobao.360.cn/learning/detail/2844.html)
 *
 * 注意: 修改和删除时, key path domain 字段必须一致, 否则 cookie 不会被更新/删除, 而是新建一条记录
 * */
function wj_setCookie(key, value, expiresSecond, path, domain, secure, sameSite) {

    if(!key || key.length == 0) return;
    if(!value || value.length == 0) return;

    // 拼接 cookie
    var cookieString = key+"="+value;

    // 设置超时时间
    if(expiresSecond && expiresSecond > 0) {
        var expires = new Date(new Date().getTime() + expiresSecond * 1000).toUTCString();
        cookieString += "; expires="+expires;
    }

    // 设置域名
    if(domain && domain.length > 0) {
        cookieString += "; domain="+domain;
    }
    // 设置路径
    if(path && path.length > 0) {
        cookieString += "; path="+path;
    }

    // 设置 安全标记
    if(secure) {
        cookieString += "; secure"
    }
    // 设置 sameSite
    if(sameSite && sameSite.length > 0 && (sameSite == "Strict" || sameSite == "Lax")) {
        cookieString += "; SameSite=" + sameSite;
    }
    document.cookie=cookieString;
}

/**
 * 获取指定 key 对应的 cookie
 * @param key 想要获取的 cookie 对应的 key, 若不存在则返回所有 cookie
 *
 * cookie 格式为 key1=value1;key2=value2;key3=value3格式, 故获取指定 key 的 cookie 需要特殊处理
 * */
function wj_getCookie(key) {
    if(!key || key.length == 0) return document.cookie;
    var name = key + "=";
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i].trim();
        if (cookie.indexOf(name) == 0) {
            return cookie.substring(name.length, cookie.length);
        }
    }
    return null;
}


//================= session storage =========================




//================== local storage ==========================