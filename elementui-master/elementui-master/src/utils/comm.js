import { Message, MessageBox, Loading } from "element-ui"; //消息提示框
import store from "@/store";
import router from '@/router'

/**
 * 公共确认提示框
 * @param {*} config
 * @returns
 */
export function ConfirmMessageBox(config) {
    let _config = {
        title: config.title || "提示",
        content: config.content || "",
    };
    return new Promise(function (resolve, reject) {
        MessageBox.confirm(_config.content, _config.title, {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
        })
            .then(() => {
                resolve(true);
            })
            .catch(() => {
                resolve(false);
            });
    });
}


/**
 * 获取路径中的文件名称
 */
export function GetFileNameByPath(path) {
    if (!path) {
        return "";
    }
    var pos1 = path.lastIndexOf('/');
    var pos2 = path.lastIndexOf('\\');
    var pos = Math.max(pos1, pos2);
    if (pos < 0) {
        return path;
    }
    else {
        return path.substring(pos + 1);
    }
}
/**
 * 获取路径中的文件格式
 */
export function GetFileTypeByPath(path) {
    if (!path) {
        return "";
    }
    var pos = path.lastIndexOf('.');
    if (pos < 0) {
        return "";
    }
    else {
        return path.substring(pos + 1);
    }
}
/**
 * 切割字段返回一个集合
 * @param {*} value 需要切割字段
 * @param {*} cutting 切割的符号
 */
export function ConvertArray(value = '', cutting = ',') {

    if (!value) {
        return [];
    }

    let array = value.split(cutting);

    return array;
}
/**
 * 根据路径获取文件的详细信息
 */
export function FullConvertUrlArray(value = '', cutting = ',') {
    var arr = ConvertArray(value, cutting);

    arr = arr.map(x => { return { url: ReplaceImageHttp(x), name: GetFileNameByPath(x), type: GetFileTypeByPath(x) }; });
    return arr;

}
/**
 * 处理图片路径
 * @param {*} value
 * @returns
 */
export function ReplaceImageHttp(value) {

    if (value == null || value == "") {
        return "";
    }
    //判断是不是数组 参数归一化
    if (Array.isArray(value)) {
        let temp = [];
        value.forEach((item) => {
            temp.push(ReplaceImageHttp(item))
        })

        return temp;
    }
    return value;
}

/**
 * 得到完整的时间格式 年-月-日 时分秒
 */
export function YMDHMSFormat(val) {
    if (!val) return "";
    let date = new Date(val);
    if (!date) return "";

    var y = date.getFullYear();
    var m = (date.getMonth() + 1).toString();
    m = parseInt(m) < 10 ? "0" + m : m;
    var d = date.getDate().toString();
    d = parseInt(d) < 10 ? "0" + d : d;
    var h = date.getHours().toString();
    h = parseInt(h) < 10 ? "0" + h : h;
    var minute = date.getMinutes().toString();
    minute = parseInt(minute) < 10 ? "0" + minute : minute;
    var second = date.getSeconds().toString();
    second = parseInt(second) < 10 ? "0" + second : second;
    return y + "-" + m + "-" + d + " " + h + ":" + minute + ":" + second;
}
/**
 * 得到完整的时间格式 年-月-日
 */
export function YMDFormat(val) {
    if (!val) return "";
    let date = new Date(val);
    if (!date) return "";

    var y = date.getFullYear();
    var m = (date.getMonth() + 1).toString();
    m = parseInt(m) < 10 ? "0" + m : m;
    var d = date.getDate().toString();
    d = parseInt(d) < 10 ? "0" + d : d;
    var h = date.getHours().toString();
    h = parseInt(h) < 10 ? "0" + h : h;
    var minute = date.getMinutes().toString();
    minute = parseInt(minute) < 10 ? "0" + minute : minute;
    var second = date.getSeconds().toString();
    second = parseInt(second) < 10 ? "0" + second : second;
    return y + "-" + m + "-" + d + " ";
}

/**
 * 得到时分秒格式
 */
export function HMSFormat(val) {
  if (!val) return "";
  let date = new Date(val);
  if (!date) return "";

  var y = date.getFullYear();
  var m = (date.getMonth() + 1).toString();
  m = parseInt(m) < 10 ? "0" + m : m;
  var d = date.getDate().toString();
  d = parseInt(d) < 10 ? "0" + d : d;
  var h = date.getHours().toString();
  h = parseInt(h) < 10 ? "0" + h : h;
  var minute = date.getMinutes().toString();
  minute = parseInt(minute) < 10 ? "0" + minute : minute;
  var second = date.getSeconds().toString();
  second = parseInt(second) < 10 ? "0" + second : second;
  return h + ":" + minute + ":" + second;
}
/**
 * 获取相对时间描述
 * @param {Date|string|number} date 要比较的时间
 * @returns {string} 返回相对时间描述
 */
export function GetRelativeTimeDesc(date) {
  const now = new Date();
  const targetDate = new Date(date);
  const diff = now - targetDate; // 时间差（毫秒）

  // 转换为各个时间单位
  const minutes = Math.floor(diff / (1000 * 60));
  const hours = Math.floor(diff / (1000 * 60 * 60));
  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
  const weeks = Math.floor(days / 7);
  const months = Math.floor(days / 30);
  const years = Math.floor(days / 365);

  if (minutes < 1) return "刚刚";
  if (minutes < 60) return "最近1分钟";
  if (hours < 24) return "最近1小时";
  if (days < 7) return "最近1天";
  if (weeks < 4) return "最近1周";
  if (months < 12) return "最近1月";
  return "最近1年";
}


/**
 * 检查是否登录状态
 * @returns
 */
export function CheckIsLogin() {
    if (!store.getters.Token) {

        setTimeout(() => {
            router.push("/login")
        }, 500)
        Message(
            {
                showClose: true,
                message: '请先登录后,再操作',
                type: 'error'
            }
        )
        return false;
    }
    return true;
}

export default {
    CheckIsLogin,
    ConfirmMessageBox,
    ConvertArray,
    FullConvertUrlArray,
    GetFileNameByPath,
    GetFileTypeByPath,
    ReplaceImageHttp,
    YMDHMSFormat,
    YMDFormat,
 	  HMSFormat,
  GetRelativeTimeDesc,
};
