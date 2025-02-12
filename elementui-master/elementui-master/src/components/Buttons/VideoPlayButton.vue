
  <template>
    <div>
        <div @click="ShowVideoWindows()">
            <slot name="content" :data="options"></slot>
        </div>

        <el-dialog :title="title ? title : fileName" :visible.sync="show" width="50%" :lock-scroll="true"
            height="400px">

            <video controls muted width="100%" height="400px" v-if="show">
                <source :src="url" type="video/webm" />
            </video>
        </el-dialog>
    </div>
</template>

<script>

import {
    GetFileNameByPath
} from "@/utils/comm"
import store from "@/store";
export default {

    props: {

        url: {
            type: String,//默认的请求路径
            default: "",
        },
        title: {
            type: String,//文件名称
            default: "",
        }
    },

    data() {
        return {
            show: false,
            files: [],
            fileName: ""

        }
    },
    created() {


    },
    methods: {
        ShowVideoWindows() {
            if (!this.url) {
                this.$message({
                    message: '请先完成资源上传!',
                    type: 'warning'
                });
                return;
            }
            this.fileName = GetFileNameByPath(this.url);
            this.show = true;
        },

    }
}

</script>

