
  <template>
    <span style="">
        <el-button type="warning" size="mini" icon="el-icon-upload" @click="ShowImport()">{{ title }}</el-button>
        <el-dialog :title="title" :visible.sync="importShow" width="40%" :lock-scroll="true" height="800px">
            <el-form v-if="importShow == true" label-width="80px" size="mini">
                <el-row :gutter="10">
                    <el-col :span="24">
                        <el-form-item label="模板地址" prop="userName">
                            <DownloadLink :url="templeteUrl"></DownloadLink>

                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item label="资源" prop="avatar">

                            <UploadExcelImport @importSuccess="ImportSuccess" :limit="1" :url="uploadUrl">
                            </UploadExcelImport>

                        </el-form-item>
                    </el-col>
                </el-row>

            </el-form>
        </el-dialog>
    </span>
</template>

<script>

import store from "@/store";
import DownloadLink from "@/components/DownLoad/DownloadLink.vue";
import UploadExcelImport from "@/components/Upload/UploadExcelImport.vue";
export default {
    components: {
        DownloadLink,
        UploadExcelImport
    },
    props: {
        title: {
            type: String, //标题
            default: "导入",
        },
        uploadUrl: {
            type: String, //上传地址
            default: "",
        },
        templeteUrl: {
            type: String, //模板地址
            default: "",
        },
    },
    watch: {
    },
    data() {
        return {
            importShow: false,
        }
    },
    created() {

    },
    methods: {

        async ImportSuccess() {
            this.importShow = false;
            this.$emit('ButtonImportSuccess');
        },
        /**
        * 导入弹窗
         */
        async ShowImport() {
            this.importShow = true;

        },
    }
}

</script>
