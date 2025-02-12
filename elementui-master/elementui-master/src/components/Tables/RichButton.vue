<template>
    <span style="margin-left:10px;margin-right: 10px;">
        <el-button type="text" icon="el-icon-tickets" @click="ShowImport()">内容浏览</el-button>
        <el-dialog title="内容查看" :visible.sync="contentShow" width="40%" :lock-scroll="true" height="800px">
            <div class="rich_content_button" v-html="content"></div>

        </el-dialog>
    </span>
</template>

<script>
export default {

    props: {

        content: {
            type: String,//默认显示内容
            default: "",
        },
    },
    watch: {

    },
    data() {
        return {
            contentShow: false,
        }
    },
    created() {



    },
    methods: {
        ShowImport() {
            this.contentShow = true;
        }

    }
}

</script>
<style >
.rich_content_button {
    height: 600px;
    overflow-y: scroll;
    font-family: 微软雅黑;
    font-size: 14px;
    letter-spacing: 0.2em;
    line-height: 1.5em;
    color: #666161;
    box-sizing: content-box;
    text-align: left;
}

.rich_content_button img {
    width: 100%;
}
</style>