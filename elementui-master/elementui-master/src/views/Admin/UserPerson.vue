<!--<template>-->
<!--    <div>-->

<!--        <el-card class="margin-top-sm">-->
<!--            <div slot="header" class="clearfix">-->
<!--                <h2>Modify personal information</h2>-->
<!--            </div>-->
<!--            <div>-->
<!--                <el-form ref="editModalForm" v-if="editShow == true" :model="formData" label-width="80px" size="mini"-->
<!--                    :rules="rules">-->
<!--                    <el-form-item label="UserName" prop="UserName">-->
<!--                        <el-input v-model="formData.UserName" clearable :disabled="true"></el-input>-->
<!--                    </el-form-item>-->

<!--                    <el-form-item label="Email" prop="Email">-->
<!--                        <el-input v-model="formData.Email" clearable> </el-input>-->
<!--                    </el-form-item>-->
<!--                    <el-form-item label="Name" prop="Name">-->
<!--                        <el-input v-model="formData.Name" clearable></el-input>-->
<!--                    </el-form-item>-->
<!--                    <el-form-item label="PhoneNumber" prop="PhoneNumber">-->
<!--                        <el-input v-model="formData.PhoneNumber" clearable></el-input>-->
<!--                    </el-form-item>-->
<!--                    <el-form-item label="ImageUrls" prop="ImageUrls">-->
<!--                        <UploadImages v-model="formData.ImageUrls"></UploadImages>-->
<!--                    </el-form-item>-->

<!--                    <el-form-item label="Birth" prop="Birth">-->
<!--                        <el-date-picker type="date" value-format="yyyy-MM-dd 00:00:00" placeholder="Select Date"-->
<!--                            v-model="formData.Birth" clearable></el-date-picker>-->
<!--                    </el-form-item>-->

<!--                  <el-form-item label="eyeColor" prop="EyeColor">-->
<!--                    <el-select v-model="searchForm.EyeColor" placeholder="Please select">-->
<!--                      <el-option key="RED" label="RED" value="RED">-->
<!--                      </el-option>-->
<!--                      <el-option key="BLACK" label="BLACK" value="BLACK">-->
<!--                      </el-option>-->
<!--                      <el-option key="YELLOW" label="YELLOW" value="YELLOW">-->
<!--                      </el-option>-->
<!--                      <el-option key="ORANGE" label="ORANGE" value="BORANGE">-->
<!--                      </el-option>-->
<!--                    </el-select>-->
<!--                  </el-form-item>-->
<!--                  <el-form-item label="hairColor" prop="HairColor">-->
<!--                    <el-select v-model="searchForm.HairColor" placeholder="Please select">-->
<!--                      <el-option key="RED" label="RED" value="RED">-->
<!--                      </el-option>-->
<!--                      <el-option key="BLACK" label="BLACK" value="BLACK">-->
<!--                      </el-option>-->
<!--                      <el-option key="YELLOW" label="YELLOW" value="YELLOW">-->
<!--                      </el-option>-->
<!--                      <el-option key="ORANGE" label="ORANGE" value="ORANGE">-->
<!--                      </el-option>-->
<!--                    </el-select>-->
<!--                  </el-form-item>-->
<!--                  <el-form-item label="height" prop="Height">-->
<!--                    <el-input v-model.trim="searchForm.Height" placeholder="Please enter your height" :clearable="true"></el-input>-->
<!--                  </el-form-item>-->
<!--                  <el-form-item label="nationality" prop="Nationality">-->
<!--                    <el-select v-model="searchForm.Nationality" placeholder="Please select">-->
<!--                      <el-option key="RUSSIA" label="RUSSIA" value="RUSSIA">-->
<!--                      </el-option>-->
<!--                      <el-option key="ITALY" label="ITALY" value="ITALY">-->
<!--                      </el-option>-->
<!--                      <el-option key="JAPAN" label="JAPAN" value="JAPAN">-->
<!--                      </el-option>-->
<!--                    </el-select>-->
<!--                  </el-form-item>-->
<!--                </el-form>-->
<!--                <div style="display: flex;justify-content: flex-end;">-->
<!--                    <el-button type="primary" @click="CreateOrEdit">confirm</el-button>-->
<!--                </div>-->
<!--            </div>-->
<!--        </el-card>-->

<!--    </div>-->
<!--</template>-->

<!--<script>-->
<!--import store from "@/store/index.js"-->
<!--import { mapGetters } from "vuex";-->
<!--export default {-->

<!--    computed: {-->
<!--        ...mapGetters(["UserInfo", 'UserId'])-->
<!--    },-->
<!--    data() {-->
<!--        return {-->
<!--            editShow: false,-->
<!--            formData: {},-->
<!--            rules: {-->
<!--                UserName: [-->
<!--                    { required: true, message: 'Please enter your account number', trigger: 'blur' },-->
<!--                ],-->
<!--                Password: [-->
<!--                    { required: true, message: 'Please enter your password', trigger: 'blur' },-->
<!--                ],-->
<!--                Email: [-->
<!--                    { required: true, message: 'Please enter your email', trigger: 'blur' },-->
<!--                    {-->
<!--                        validator: (rule, value, callback) => {-->
<!--                            var reg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;-->
<!--                            if (!value || !reg.test(value)) {-->
<!--                                callback(new Error('Please enter the correct email address'));-->
<!--                            }-->
<!--                            else {-->
<!--                                callback();-->
<!--                            }-->
<!--                        }, trigger: 'blur'-->
<!--                    },-->
<!--                ],-->
<!--                Name: [-->
<!--                    { required: true, message: 'Please enter a name', trigger: 'blur' },-->
<!--                ],-->
<!--                PhoneNumber: [-->
<!--                    { required: true, message: 'Please enter your mobile phone number', trigger: 'blur' },-->
<!--                    {-->
<!--                        validator: (rule, value, callback) => {-->
<!--                            var reg = /^1[34578]\d{9}$/;-->
<!--                            if (!value || !reg.test(value)) {-->
<!--                                callback(new Error('Please enter the correct mobile phone number'));-->
<!--                            }-->
<!--                            else {-->
<!--                                callback();-->
<!--                            }-->
<!--                        }, trigger: 'blur'-->
<!--                    },-->
<!--                ],-->
<!--                Birth: [-->
<!--                    { required: true, message: 'Please enter your year of birth', trigger: 'blur' },-->
<!--                ],-->
<!--                ImageUrls: [-->
<!--                    { required: true, message: 'Please enter an avatar', trigger: 'blur' },-->
<!--                ],-->
<!--            },-->

<!--        }-->
<!--    },-->
<!--    created() {-->
<!--        this.ShowEditModal();-->
<!--    },-->
<!--    methods: {-->

<!--        //获取用户信息-->
<!--        async ShowEditModal() {-->

<!--            let { Data } = await this.$Post("/User/Get", { Id: this.UserId })-->
<!--            this.formData = Data;-->
<!--            this.editShow = true;-->

<!--        },-->
<!--        //创建或者修改-->
<!--        async CreateOrEdit() {-->
<!--            this.$refs.editModalForm.validate(async (valid) => {-->
<!--                if (valid) {-->
<!--                    //保存数据到数据库-->
<!--                    let { Success, Msg, Data } = await this.$Post("/User/CreateOrEdit", this.formData);-->
<!--                    if (Success) {-->

<!--                        this.$message.success("Modified successfully!");-->

<!--                        store.dispatch("GetInfo");-->


<!--                    }-->
<!--                } else {-->
<!--                    console.log('error submit!!');-->
<!--                    return false;-->
<!--                }-->
<!--            });-->
<!--        },-->

<!--    }-->
<!--}-->
<!--</script>-->

<!--<style></style>-->
<template>
  <div>
    <el-card class="margin-top-sm">
      <div slot="header" class="clearfix">
        <h2>Modify personal information</h2>
      </div>
      <div>
        <el-form ref="editModalForm" v-if="editShow" :model="formData" label-width="80px" size="mini" :rules="rules">
          <el-form-item label="UserName" prop="UserName">
            <el-input v-model="formData.UserName" clearable disabled></el-input>
          </el-form-item>

          <el-form-item label="Email" prop="Email">
            <el-input v-model="formData.Email" clearable></el-input>
          </el-form-item>

          <el-form-item label="Name" prop="Name">
            <el-input v-model="formData.Name" clearable></el-input>
          </el-form-item>

          <el-form-item label="PhoneNumber" prop="PhoneNumber">
            <el-input v-model="formData.PhoneNumber" clearable></el-input>
          </el-form-item>

          <el-form-item label="ImageUrls" prop="ImageUrls">
            <UploadImages v-model="formData.ImageUrls"></UploadImages>
          </el-form-item>

          <el-form-item label="Birth" prop="Birth">
            <el-date-picker type="date" value-format="yyyy-MM-dd 00:00:00" placeholder="Select Date"
                            v-model="formData.Birth" clearable></el-date-picker>
          </el-form-item>

          <el-form-item label="Eye Color" prop="EyeColor">
            <el-select v-model="formData.EyeColor" placeholder="Please select" clearable>
              <el-option key="RED" label="RED" value="RED"></el-option>
              <el-option key="BLACK" label="BLACK" value="BLACK"></el-option>
              <el-option key="YELLOW" label="YELLOW" value="YELLOW"></el-option>
              <el-option key="ORANGE" label="ORANGE" value="ORANGE"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="Hair Color" prop="HairColor">
            <el-select v-model="formData.HairColor" placeholder="Please select" clearable>
              <el-option key="RED" label="RED" value="RED"></el-option>
              <el-option key="BLACK" label="BLACK" value="BLACK"></el-option>
              <el-option key="YELLOW" label="YELLOW" value="YELLOW"></el-option>
              <el-option key="ORANGE" label="ORANGE" value="ORANGE"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="Height" prop="Height">
            <el-input v-model.trim="formData.Height" placeholder="Please enter your height" clearable></el-input>
          </el-form-item>

          <el-form-item label="Nationality" prop="Nationality">
            <el-select v-model="formData.Nationality" placeholder="Please select" clearable>
              <el-option key="RUSSIA" label="RUSSIA" value="RUSSIA"></el-option>
              <el-option key="ITALY" label="ITALY" value="ITALY"></el-option>
              <el-option key="JAPAN" label="JAPAN" value="JAPAN"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
<div style="display: flex;justify-content: flex-end;">
<el-button type="primary" @click="CreateOrEdit">confirm</el-button>
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
    ...mapGetters(["UserInfo", "UserId"]),
    isAdmin() {
      return this.UserInfo?.Role === "admin" || this.UserInfo?.Role === "user";
    }
  },
  data() {
    return {
      editShow: false,
      formData: {},
      rules: {
        UserName: [{ required: true, message: 'Please enter your account number', trigger: 'blur' }],
        Email: [
          { required: true, message: 'Please enter your email', trigger: 'blur' },
          {
            validator: (rule, value, callback) => {
              var reg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
              if (!value || !reg.test(value)) {
                callback(new Error('Please enter the correct email address'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        Name: [{ required: true, message: 'Please enter a name', trigger: 'blur' }],
        PhoneNumber: [
          { required: true, message: 'Please enter your mobile phone number', trigger: 'blur' },
          {
            validator: (rule, value, callback) => {
              var reg = /^1[34578]\d{9}$/;
              if (!value || !reg.test(value)) {
                callback(new Error('Please enter the correct mobile phone number'));
              } else {
                callback();
              }
            },
            trigger: 'blur'
          }
        ],
        Birth: [{ required: true, message: 'Please enter your year of birth', trigger: 'blur' }],
        ImageUrls: [{ required: true, message: 'Please enter an avatar', trigger: 'blur' }],
        EyeColor: [{ required: true, message: 'Please select an eye color', trigger: 'change' }],
        HairColor: [{ required: true, message: 'Please select a hair color', trigger: 'change' }],
        Height: [{ required: true, message: 'Please enter your height', trigger: 'blur' }],
        Nationality: [{ required: true, message: 'Please select your nationality', trigger: 'change' }]
      }
    };
  },
  created() {
    this.ShowEditModal();
  },
  methods: {
    async ShowEditModal() {
      let { Data } = await this.$Post("/User/Get", { Id: this.UserId });
      this.formData = Data;
      this.editShow = true;
    },
    async CreateOrEdit() {
      this.$refs.editModalForm.validate(async (valid) => {
        if (valid) {
          let { Success, Msg } = await this.$Post("/User/CreateOrEdit", this.formData);
          if (Success) {
            this.$message.success("Modified successfully!");
            store.dispatch("GetInfo");
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    }
  }
};
</script>

<style></style>
