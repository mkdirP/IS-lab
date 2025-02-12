import store from "@/store";
import { getToken } from "@/utils/cache";
import AdminLayout from "@/views/Admin/Layout/index.vue";
import NProgress from "nprogress"; // progress bar
import "nprogress/nprogress.css"; // progress bar style
import Vue from "vue";
import VueRouter from "vue-router";
NProgress.inc(0.2);
NProgress.configure({
  easing: "ease",
  speed: 1000,
  showSpinner: false,
  trickle: false,
});
Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/Login",
  },
  {
    path: "/Login",
    component: () => import("@/views/Login.vue"),
  },

  {
    path: "/ForgetPassword",
    component: () => import("@/views/ForgetPassword.vue"),
  },
];

export const adminRouters = [
  {
    path: "/Admin",
    redirect: "/Admin/UserPerson",
    component: AdminLayout,
    meta: {
      title: "menu",
      isAdmin: false,
      requiresAdmin: false,
    },
    children: [
      {
        path: "/Admin/UserList",
        meta: {
          title: "UserList",
          isAdmin: true,
          requiresAdmin: true, // 仅管理员访问
        },
        component: () => import("@/views/Admin/adminList"),
      },
      {
        path: "/Admin/UserPerson",
        meta: {
          title: "personal id",
          isAdmin: true,
          requiresAdmin: false,
        },
        component: () => import("@/views/Admin/UserPerson"),
      },
      {
        path: "/Admin/PasswordEdit",
        meta: {
          title: "PasswordEdit",
          isAdmin: true,
          requiresAdmin: true, // 仅管理员访问
        },
        component: () => import("@/views/Admin/PasswordEdit"),
      },


      {
        path: "/Admin/UserList",
        meta: {
          title: "UserList",
          isAdmin: true,
        },
        component: () => import("@/views/Admin/adminList"),
      },
      {
        path: "/Admin/UserPerson",
        meta: {
          title: "personal id",
          isAdmin: true,
          requiresAdmin: false,
        },
        component: () => import("@/views/Admin/UserPerson"),
      },
      {
        path: "/Admin/PasswordEdit",
        meta: {
          title: "PasswordEdit",
          isAdmin: true,
        },
        component: () => import("@/views/Admin/PasswordEdit"),
      },
    ],
  },
];

    export const userRouters = [
  {
    path: "/Admin",
    redirect: "/Admin/UserPerson", // 用户默认重定向到 UserList
    component: AdminLayout,
    meta: {
      title: "menu",
      isAdmin: false , // 标记为非管理员
      requiresAdmin: false,
    },
    children: [
      {
        path: "/Admin/UserList",
        meta: {
          title: "UserList",
          isAdmin: false, // 用户可以访问
        },
        component: () => import("@/views/Admin/userList"), // 用户列表
      },
      {
        path: "/Admin/UserPerson",
        meta: {
          title: "personal id",
          isAdmin: true,
          requiresAdmin: true,
        },
        component: () => import("@/views/Admin/UserPerson"),
      },
      {
        path: "/Admin/PasswordEdit",
        meta: {
          title: "PasswordEdit",
          isAdmin: true,
        },
        component: () => import("@/views/Admin/PasswordEdit"),
      },
    ],
  },
];

const router = new VueRouter({
  routes: [...routes, ...adminRouters], // (缩写) 相当于 routes: routes
});


router.beforeEach(async (to, from, next) => {
  NProgress.start();
  const hasToken = getToken();

  if (hasToken) {
    if (!store.getters.HasUserInfo) {
      await store.dispatch("GetInfo");
      if (!store.getters.UserId) {
        store.dispatch("Logout");
      }
    }

    const roleType = store.getters.RoleType;

    if (roleType === "user") {
      // 允许 user 访问 userRouters 里的页面
      const allowedPaths = userRouters.flatMap(route => route.children.map(child => child.path));

      if (!allowedPaths.includes(to.path)) {
        next({ path: "/Admin/UserList" });
      } else {
        next();
      }
    } else if (roleType === "admin") {
      // 管理员角色正常访问
      if (to.meta?.requiresAdmin && roleType !== "admin") {
        next({ path: "/" });
      } else {
        next();
      }
    }
  } else {
    if (to.meta?.isAdmin) {
      next({ path: "/Login" });
    } else {
      next();
    }
  }

  NProgress.done();
});


export default router;
