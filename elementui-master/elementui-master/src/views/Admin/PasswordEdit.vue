<template>
    <div>

        <el-card class="margin-top-sm">
            <div slot="header" class="clearfix">
                <h2>Change Password</h2>
            </div>
            <div>
                <el-form ref="editModalForm" :model="formData" label-width="80px" size="mini" :rules="rules">


                    <el-form-item label="Original password" prop="OrginPassword" placeholder="Please enter your original password">
                        <el-input type="password" v-model.trim="formData.OrginPassword"></el-input>
                    </el-form-item>

                    <el-form-item label="New Password" prop="NewPassword" placeholder="Please enter your original password">
                        <el-input type="password" v-model.trim="formData.NewPassword"></el-input>
                    </el-form-item>

                    <el-form-item label="Confirm Password" prop="TwoPassword" placeholder="Please enter your original password">
                        <el-input type="password" v-model.trim="formData.TwoPassword"></el-input>
                    </el-form-item>


                </el-form>
                <div style="display: flex;justify-content: flex-end;">
                    <el-button type="primary" @click="CreateOrEdit">sure</el-button>
                </div>
            </div>
        </el-card>

    </div>
</template>

<script>
import store from "@/store/index.js"
import { mapGetters } from "vuex";
export default {

    computed: {
        ...mapGetters(["UserInfo", 'UserId'])
    },
    data() {
        return {

            formData: {},
            rules: {
                "TwoPassword": [
                    { required: true, message: 'This item is required', trigger: 'blur' },
                ],
                "OrginPassword": [
                    { required: true, message: 'This item is required', trigger: 'blur' },
                ],
                "NewPassword": [
                    { required: true, message: 'This item is required', trigger: 'blur' },

                ],
            },

        }
    },
    created() {

    },
    methods: {


        //创建或者修改
        async CreateOrEdit() {
            this.$refs.editModalForm.validate(async (valid) => {
                if (valid) {

                    if (this.UserInfo.Password != this.formData.OrginPassword) {
                        this.$message.error("The original password is incorrect.");
                        return;
                    }
                    if (this.formData.TwoPassword != this.formData.NewPassword) {
                        this.$message.error("The confirmed password and new password do not match");
                        return;
                    }
                    if (this.formData.Password == this.formData.TwoPassword) {
                        this.$message.error("The original password and the new password cannot be the same");
                    }

                    this.UserInfo.Password = this.formData.TwoPassword;

                    //保存数据到数据库
                    let { Success, Msg, Data } = await this.$Post("/User/CreateOrEdit", this.UserInfo);
                    if (Success) {

                        this.$message.success("Modification successful!");
                        store.dispatch("Logout");
                        this.$router.push({
                            path: "/Login"
                        })

                    }
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });
        },

    }
}
</script>

<style></style>