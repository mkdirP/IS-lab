
  <template>
    <div style="margin: 10px 0px;">
        <div v-if="loading">加载中~~~~~~</div>
        <div v-else style="display: flex;flex-wrap: nowrap;cursor:pointer;color:var(--primary-color);font-size: 20px;">
            <div style="font-weight: bolder;color:black;padding:5px">{{ title }}</div>
            <div @click="Select(undefined)" style="margin-left:20px;padding:5px"
                :class="active == undefined ? 'active' : ''">全部
            </div>
            <template v-for="(item, index) in options">
                <div @click="Select(item.value)" style="margin-left:20px;padding:5px"
                    :class="active == item.value ? 'active' : ''">
                    {{ item.name }}</div>
            </template>
        </div>

    </div>
</template>

<script>

import store from "@/store";
import { mapGetters } from "vuex";
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
        title: {
            type: String, //类型名称
            default: "",
        },

        BindName: { //默认的列属性
            type: String, //默认的请求路径
            default: "",
        },
        BindValue: {
            type: String, //默认的请求路径
            default: "",
        },
        where: {},


    },
    watch: {

    },
    computed: {

    },
    data() {
        return {
            active: undefined,
            loading: false, //是否正在获取数据中
            options: [],
            where_: {},
            pagination: {
                Limit: 9999,
                Page: 1,
                Total: 0,
                PageSizes: [5, 10, 20, 50, 100],
            },


        }
    },
    created() {

        this.where_ = this.$props.where;
        this.FetchDataList();

    },
    methods: {

        InitData() {
            this.pagination.Limit = 100;
            this.pagination.Page = 1;
            this.pagination.Total = 0;
            this.where_ = {};
        },
        async FetchDataList() {
            this.loading = true;
            let {
                Data: {
                    Items,
                    TotalCount
                }
            } = await this.$Post(this.$props.url, {
                Limit: this.pagination.Limit,
                Size: this.pagination.Limit,
                Page: this.pagination.Page,
                ...this.where_
            });
            this.loading = false;
            let dataList = [];
            Items.forEach((item, index) => {
                dataList.push({
                    name: item[`${this.BindName}`],
                    value: item[`${this.BindValue}`] ?? item[`${this.BindValue}`].toString(),
                });
            });
            this.options = dataList;
            this.pagination.Total = TotalCount;
        },
        Select(value) {
            this.active = value;
            this.$emit('input', value);
            this.$emit('Select', value);

        },

    }
}

</script>

<style scoped>
.active {
    background-color: var(--active-bg-color);
    color: var(--active-color);
    border-radius: 4px;
    padding-left: 5px;
    padding-right: 5px;

}
</style>

