/**
 * Created by sjg on 2017/7/1.
 */
/**
 * CONFIG 初始化构造函数, 会将传入的对象属性拷贝
 * */
var CONFIG = function (obj) {
    if(!obj) return;
    for (var key in obj){
        var value = obj[key];
        if(value!=null && (typeof value!=='function'))
            this[key] = value;
    }
};


//===================== 服务器运行模式配置 ======================
// 服务器运行模式枚举, 0: release 状态, 发布到服务器, 1: 本地开发状态, 2: 发布到测试服务器状态
CONFIG.SERVER_STATE_ENUM = {};
CONFIG.SERVER_STATE_ENUM.RELEASE        = 0;
CONFIG.SERVER_STATE_ENUM.DEBUG_LOCAL    = 1;
CONFIG.SERVER_STATE_ENUM.DEBUG_DEV      = 2;
CONFIG.SERVER_STATE = CONFIG.SERVER_STATE_ENUM.DEBUG_LOCAL;


// 服务器所在域名
CONFIG.SERVER_DOMAIN_ENUM = {};
CONFIG.SERVER_DOMAIN_ENUM.RELEASE       = "lab.wangjuncoder.cn";
CONFIG.SERVER_DOMAIN_ENUM.DEBUG_LOCAL   = "192.168.31.3";
CONFIG.SERVER_DOMAIN_ENUM.DEBUG_DEV     = "192.168.0.103";
// 设置服务器当前域名
CONFIG.SERVER_DOMAIN = CONFIG.SERVER_DOMAIN_ENUM.RELEASE;
if(CONFIG.SERVER_STATE == CONFIG.SERVER_STATE_ENUM.DEBUG_DEV)
    CONFIG.SERVER_DOMAIN = CONFIG.SERVER_DOMAIN_ENUM.DEBUG_DEV;
if(CONFIG.SERVER_STATE == CONFIG.SERVER_STATE_ENUM.DEBUG_LOCAL)
    CONFIG.SERVER_DOMAIN = CONFIG.SERVER_DOMAIN_ENUM.DEBUG_LOCAL;



module.exports = CONFIG;