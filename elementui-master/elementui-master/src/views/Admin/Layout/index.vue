<template>
    <div>
        <el-container style="height: 100vh">

            <el-header>
                <div class="bg-header">
                    <div class="flex align-center">
                        <img :src="require('@/assets/logo.png')" style="width: 50px; height: 50px;">
                        <span style="margin-left:10px">management system</span>
                    </div>
                    <div style="display: flex;align-items: center">
                        <el-avatar :size="60" :src="UserInfo.ImageUrls" size="medium">
                            <img :src="require('@/assets/默认头像.png')" />
                        </el-avatar>
                        <div style="margin-left:10px">
                            <el-dropdown>
                                <span class="el-dropdown-link" style="color:white">
                                    {{ UserInfo.Name }}<i class="el-icon-arrow-down el-icon--right"></i>
                                </span>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item>
                                        <div @click="ToPath('/Admin/UserPerson')">personal information</div>

                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <div @click="ToPath('/Admin/PasswordEdit')">Change Password</div>

                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <div @click="LoginOut()">quit</div>
                                    </el-dropdown-item>

                                </el-dropdown-menu>
                            </el-dropdown>
                        </div>

                    </div>
                </div>


            </el-header>


            <el-container>
                <el-aside width="200px">

                    <el-menu class="menu-list" :router="true" active-text-color="var(--primary-color)">

                        <template v-if="RoleType == 'admin'||'user'">
                            <el-submenu index="/Admin/UserList">
                                <template slot="title">
                                    <img class="meun-ico" :src="require('@/assets/用户 (1).png')"></img>
                                    <span>user management</span>
                                </template>
                                <el-menu-item index="/Admin/UserList">
                                    <img class="meun-ico" :src="require('@/assets/用户.png')"></img>
                                    <span>user information</span>
                                </el-menu-item>
                            </el-submenu>
                        </template>
                    </el-menu>
                </el-aside>

                <el-main class="admin-main">
                    <el-breadcrumb separator-class="el-icon-arrow-right" class="margin-bottom-xs">
                        <el-breadcrumb-item v-for="(item, index) in breadList" :key="index" :to="item.path">{{
                            item.meta.title
                        }}</el-breadcrumb-item>
                    </el-breadcrumb>

                    <transition>
                        <router-view></router-view>
                    </transition>

                </el-main>

            </el-container>
        </el-container>
    </div>
</template>

<script>

import { adminRouters } from "@/router/index";
import { mapGetters } from "vuex";
export default {
    name: 'Layout',
    data() {
        return {
            routerMenu: [],
            breadList: [],
            warehouseList: [],
            "CurrentWarehouseId": null,

        }
    },
    computed: {
        ...mapGetters([
            'Token', 'UserInfo', 'RoleType', 'RoleTypeFormat', 'HasUserInfo', 'ColumnType', "UserId",
        ])
    },
    watch: {
        $route() {
            this.getBreadcrumb();
        },
    },

    created() {
        this.CurrentWarehouseId = this.$store.getters.CurrentWarehouseId;

        this.routerMenu = adminRouters;
        this.getBreadcrumb();
        this.GetWarehouseList();
    },
    methods: {
        //跳转
        async ToPath(url) {
            this.$router.push({
                path: url
            })
        },
        async GetWarehouseList() {
            let { Data: { Items } } = await this.$Post("/WarehouseRelativeUser/List", { UserId: this.UserId })
            let list = Items.map(item => item.WarehouseDto);
            for (let item of list) {
                item.Id = item.Id.toString();
            }
            this.warehouseList = list;
            if (!this.CurrentWarehouseId) {

                this.CurrentWarehouseId = this.warehouseList[0].Id;
                this.$store.dispatch("SetCurrentWarehouseId", this.warehouseList[0].Id);
            }
        },
        async ChangeWarehouse(id) {

            this.$store.dispatch("SetCurrentWarehouseId", id);
            window.location.reload();
        },
        async LoginOut() {

            await this.$store.dispatch('Logout')
            window.location.reload('/Login')
        },
        isHome(route) {
            return route.path === "/Admin";
        },
        getBreadcrumb() {
            let matched = this.$route.matched;
            if (!this.isHome(matched[0])) {
                matched = [{ path: "/Admin", meta: { title: "控制台" } }].concat(matched);
            }
            this.breadList = matched;

        }
    }
}
</script>

<style>
.el-header,
.el-footer {

    text-align: center;
    line-height: 60px;
    padding: 0px !important;
}

.el-aside {

    color: #333;
    text-align: center;
    line-height: 200px;
}


.menu-list {
    height: calc(100vh - 60px);
}

.el-submenu__title {
    text-align: left
}

.el-menu-item {
    text-align: left;
}

.admin-main {
    height: calc(100vh - 60px) !important;
}

.meun-ico {
    width: 25px;
    height: 25px;
    margin-right: 5px;
}
</style>