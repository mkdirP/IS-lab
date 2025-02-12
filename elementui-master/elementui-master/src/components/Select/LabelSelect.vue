
  <template>
    <el-select style="width:100%" :disabled="disabled" v-model="selectValue" multiple allow-create placeholder="请选择"
        :filterable="true" :loading="loading" :clearable="true" :remote="true" @change="Change">
        <el-option v-for="item in options" :key="item.name" :label="item.name" :value="item.name">
            <span style="float: left">{{ item.name }}</span>
            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.label }}</span>
        </el-option>
    </el-select>
</template>

<script>

import store from "@/store";
export default {
    props: {

        value: {
            type: [Number, String],
            default: ''
        },
        url: {
            type: String, //默认的请求路径
            default: "",
        },

        columnName: { //默认的列属性
            type: String, //默认的请求路径
            default: "",
        },
        where: {},
        disabled: {
            type: Boolean,
            default: false
        },
    },
    watch: {
        "value": {
            immediate: true, //该回调将会在侦听开始之后被立即调用
            handler: function (n, o) {
                if (n?.toString()?.length > 0) {
                    this.selectValue = n.toString().split(",")
                }
                else {
                    this.selectValue = [];
                }
            }
        }
    },
    data() {
        return {

            loading: false, //是否正在获取数据中
            options: [],
            where_: {},

            selectValue: [],

        }
    },
    created() {
        this.where_ = this.$props.where;
        this.FetchDataList();

    },
    methods: {

        InitData() {
            this.where_ = {};
        },
        async FetchDataList() {
            console.log("zz", this.$props.url)
            if (this.$props.url) {
                this.loading = true;
                let {
                    Data: {
                        Items,

                    }
                } = await this.$Post(this.$props.url, {
                    ...this.where_
                });
                this.loading = false;
                let dataList = [];
                Items.forEach((item, index) => {
                    dataList.push({
                        name: item[`${this.columnName}`],
                    });
                });
                this.options = dataList;
            }
        },

        Change(value) {

            if (Array.isArray(value) && value.length > 0) {
                this.$emit('input', value.join(","));
            }
            else {
                this.$emit('input', '');
            }

        },

    }
}

</script>

