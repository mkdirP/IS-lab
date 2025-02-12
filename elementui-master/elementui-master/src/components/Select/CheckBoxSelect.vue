<template>
    <el-checkbox-group style="width: 100%;" v-model="selectValue" @change="Change">
        <el-checkbox v-for="item in _options" :label="item.value">{{ item.name }}</el-checkbox>
    </el-checkbox-group>
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
        columnName: {
            type: String, //需要绑定Name的值
            default: "",
        },
        columnValue: {
            type: String, //需要绑定Value的值
            default: "",
        },
        columnLabel: {
            type: String, //需要绑定Label的值
            default: "",
        },
        where: {},

        disabled: {
            type: Boolean,
            default: false
        },
        options: {
            type: Array,
            default: () => { return [] }
        }


    },
    watch: {
        "value": {
            immediate: true, //该回调将会在侦听开始之后被立即调用
            handler: function (n, o) {
                console.log(n);
                if (n?.toString()?.length > 0) {
                    this.selectValue = n.split(',')
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
            _options: [],
            where_: {},//默认
            searchWhere: {},//搜索带过来的条件
            selectValue: [],

        }
    },
    created() {

        if (this.$props.value?.toString()?.length > 0) {
            this.selectValue = this.$props.value.split(',')
        }
        this.where_ = this.$props.where;
        this.FetchDataList();

    },
    methods: {

        async Reload(where) {

            var searchWhere = {};
            if (where) {
                searchWhere = Object.assign(searchWhere, where);
            }
            this.searchWhere = searchWhere;
            this.FetchDataList(searchWhere);
        },
        async FetchDataList(searchWhere = {}) {
            if (this.$props.url) {
                this.loading = true;
                let {
                    Data: {
                        Items,

                    }
                } = await this.$Post(this.$props.url, {
                    Limit: 999,
                    ...this.where_,
                    ...searchWhere
                });
                this.loading = false;
                let dataList = [];
                Items.forEach((item, index) => {
                    dataList.push({
                        name: item[`${this.columnName}`],
                        value: item[`${this.columnValue}`]?.toString(),
                        label: item[`${this.columnLabel}`]?.toString(),
                        orginRItem: item
                    });

                });

                this._options = dataList;
            }
            else {
                this._options = this.$props.options;
            }

        },

        Change() {

            this.$emit('input', this.selectValue.join(','));

        },

    }
}

</script>
