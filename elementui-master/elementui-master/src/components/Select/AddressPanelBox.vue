
  <template>
    <div>
        <el-dialog title="选择地址" :visible.sync="showToast" width="90%" :lock-scroll="true" height="800px">

            <div class="" v-for="(provice) in regionData">
                <h2>{{ provice.label }}</h2>
                <div class="city-box">
                    <div class="city-item" v-for="(city) in provice.children" @click="SelectCity(city)">{{ city.label }}
                    </div>

                </div>
            </div>

        </el-dialog>
    </div>

</template>

<script>
import regionData from "./chian-area-data.js"
import store from "@/store";
export default {

    props: {

        value: {
            type: [Number, String],
            default: ''
        },



    },
    watch: {
        "value": {
            immediate: true, //该回调将会在侦听开始之后被立即调用
            handler: function (n, o) {
                if (n?.toString()?.length > 0) {
                    this.selectValue = n.toString();
                }
                else {
                    this.selectValue = n;
                }
            }
        }
    },
    data() {
        return {
            showToast: false, //是否显示
            options: [],
            where_: {},//默认
            searchWhere: {},//搜索带过来的条件
            selectValue: undefined,
            regionData: regionData,
        }
    },
    created() {
        console.log(this.regionData)

    },
    methods: {

        async Show(where) {
            this.showToast = true;
        },

        //选择城市
        async SelectCity(city) {

            this.$emit("Change", city);
            this.showToast = false;
        },


    }
}

</script>
<style scoped>
.city-box {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}

.city-box .city-item {
    padding: 5px;
    cursor: pointer;
}

.city-box .city-item:hover {
    color: red;

}
</style>

