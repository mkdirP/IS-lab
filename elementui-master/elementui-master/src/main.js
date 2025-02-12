import Vue from 'vue'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

import store from "./store"

import App from './App.vue'
import router from './router'
import comm from "@/utils/comm.js"


/**
 * 年月日时分秒格式过滤器
 */
Vue.filter('YMDHMSFormat', function (value) {
  return comm.YMDHMSFormat(value);
})
/**
 * 年月日格式过滤器
 */
Vue.filter('YMDFormat', function (value) {

  return comm.YMDFormat(value);
})
/**
 * 时分秒格式过滤器
 */
Vue.filter("HMSFormat", function (value) {
  return comm.HMSFormat(value);
});

  
/**
 * 保留2位小数
 */
Vue.filter('ToFixed2', function (value) {
  if (value) {
    return value.toFixed(2);
  }
  return "0.00";

})
/**
 * 保留3位小数
 */
Vue.filter('ToFixed3', function (value) {
  if (value) {
    return value.toFixed(3);
  }
  return "0.000";

})
  
/**
 * 手机中间*号显示
 */
Vue.filter("PhoneFormat", function (value) {
  if (value) {
    return value.replace(/(\d{3})\d{4}(\d{4})/, "$1****$2");
  }
  return "";
});  
  
/**
 * 去除Html标签
 */
Vue.filter('RepalceHtml', function (value) {
  if (value) {
    return value.replace(/<[^>]+>|&[^>]+;/g, "").trim();
  }
})

import { Post, PostDelete, PostSigleUpdate } from "@/api/http"
//挂载Post请求到我们vue的原型链上
Vue.prototype.$Post = Post;
//挂载PostDelete请求到我们vue的原型链上
Vue.prototype.$PostDelete = PostDelete;
//PostSigleUpdate
Vue.prototype.$PostSigleUpdate = PostSigleUpdate;
//公共类
Vue.prototype.$Comm = comm;


import UploadImages from "@/components/Upload/UploadImages.vue"
//图片上传组件
Vue.component("UploadImages", UploadImages)


import UploadFiles from "@/components/Upload/UploadFiles.vue"
//通用文件上传组件
Vue.component("UploadFiles", UploadFiles)

import SigleSelect from "@/components/Select/SigleSelect.vue"
//通用单选框
Vue.component("SigleSelect", SigleSelect)

import QillRichText from "@/components/RichText/QillRichText.vue"
//通用富文本
Vue.component("QillRichText", QillRichText)


import PaginationTable from "@/components/Tables/PaginationTable.vue"
//分页表格组件
Vue.component("PaginationTable", PaginationTable)

import ExportButton from "@/components/Buttons/ExportButton.vue"
//导出按钮组件
Vue.component("ExportButton", ExportButton)

import RadioSelect from "@/components/Select/RadioSelect.vue"
//通用按钮单选框
Vue.component("RadioSelect", RadioSelect)
  

// 自定义混入
Vue.mixin({
  methods: {
    //返回上一个页面
    goBack() {
      this.$router.go(-1)
    },
    //检查是否登录
    CheckIsLogin() {
     return comm.CheckIsLogin();
    },

  }
})



Vue.use(ElementUI);
new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')

