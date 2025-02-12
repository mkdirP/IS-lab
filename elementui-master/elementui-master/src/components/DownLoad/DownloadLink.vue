
  <template>
    <div>
        <a style="color:royalblue" :href="importUrl">下载导入模板</a>
    </div>
</template>

<script>
import store from "@/store";
export default {
    filters: {

    },
    props: {

        url: {
            type: String,
            default: "",
        }
    },
    watch: {

    },

    data() {
        return {
            importUrl: "",

        };
    },

    created() {
        this.importUrl = process.env.VUE_APP_BASE_API + this.url;
    },
    methods: {

    },
};
</script>

<style scoped></style>
