<template>
    <div>

        <el-card class="box-card">
            <div slot="header" class="clearfix">

                <el-row>
                    <el-button type="primary" size="mini"  @click="SearchClick">search</el-button>
                    <el-button type="warning" size="mini"  @click="ResetClick">Clear</el-button>
                  <el-button type="success" size="mini" @click="redirectToUserPerson">Go to Personal info</el-button>
                  <el-button type="info" size="mini" @click="calculateAverageHeight">Avg Height</el-button>
                </el-row>
            </div>
          <div>
            <el-form :inline="true" :model="searchForm" class="demo-form-inline">
              <el-form-item label="name">
                <el-input v-model="searchForm.Name" placeholder="Please enter your name"></el-input>
              </el-form-item>
              <el-form-item label="email">
                <el-input v-model="searchForm.Email" placeholder="Please enter your email address"></el-input>
              </el-form-item>
              <el-form-item label="telephone number">
                <el-input v-model="searchForm.PhoneNumber" placeholder="Please enter your mobile phone number"></el-input>
              </el-form-item>
<!--              <el-form-item label="role" prop="RoleType">-->
<!--                <SigleSelect v-model="searchForm.RoleType" url="/Select/RoleType" columnName="Name"-->
<!--                             columnValue="Code" columnLabel="Label"></SigleSelect>-->
<!--              </el-form-item>-->
              <el-form-item label="Eye Color" prop="EyeColor">
                <el-select v-model="searchForm.EyeColor" placeholder="Please select">
                  <el-option key="RED" label="RED" value="RED"></el-option>
                  <el-option key="BLACK" label="BLACK" value="BLACK"></el-option>
                  <el-option key="YELLOW" label="YELLOW" value="YELLOW"></el-option>
                  <el-option key="ORANGE" label="ORANGE" value="ORANGE"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="Hair Color" prop="HairColor">
                <el-select v-model="searchForm.HairColor" placeholder="Please select">
                  <el-option key="RED" label="RED" value="RED"></el-option>
                  <el-option key="BLACK" label="BLACK" value="BLACK"></el-option>
                  <el-option key="YELLOW" label="YELLOW" value="YELLOW"></el-option>
                  <el-option key="ORANGE" label="ORANGE" value="ORANGE"></el-option>
                </el-select>
              </el-form-item>

              <el-form-item label="Nationality" prop="Nationality">
                <el-select v-model="searchForm.Nationality" placeholder="Please select">
                  <el-option key="RUSSIA" label="RUSSIA" value="RUSSIA"></el-option>
                  <el-option key="ITALY" label="ITALY" value="ITALY"></el-option>
                  <el-option key="JAPAN" label="JAPAN" value="JAPAN"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="height">
                <el-input v-model="searchForm.Height" placeholder="Please enter your height"></el-input>
              </el-form-item>
            </el-form>
          </div>


        <PaginationTable ref="PaginationTableId" url="/User/List" :column="dataColum">
            <template v-slot:header>
                <el-button type="primary" size="mini"  icon="el-icon-edit" @click="ShowEditModal()">add</el-button>
<!--                <ExportButton exportUrl="/User/Export" :where="searchForm"></ExportButton>-->

            </template>
            <template v-slot:Operate="scope">
                <el-button type="primary" size="mini"  @click="ShowEditModal(scope.row.Id)" v-if="RoleType == 'admin'">modify</el-button>
                <el-button type="danger" size="mini"  @click="ShowDeleteModal(scope.row.Id)" v-if="RoleType == 'admin'">delete</el-button>
            </template>
        </PaginationTable>


        <el-dialog :title="formData.Id ? 'Modify User' : 'Add User'" :visible.sync="editorShow" width="80%" :lock-scroll="true"
            min-height="800px">
            <el-form v-if="editorShow == true" ref="editModalForm" :rules="editModalFormRules" :model="formData"
                label-width="140px" size="mini">

                <el-row :gutter="10">

                        <el-form-item label="username" prop="UserName" placeholder="Please enter your account number">
                            <el-input v-model.trim="formData.UserName" :disabled='formData.Id != null'></el-input>
                        </el-form-item>

                        <el-form-item label="password" prop="Password">
                            <el-input type="password" v-model.trim="formData.Password"></el-input>
                        </el-form-item>


                        <el-form-item label="role" prop="RoleType">
                            <SigleSelect v-model="formData.RoleType" url="/Select/RoleType" columnName="Name"
                                columnValue="Code" columnLabel="Label"></SigleSelect>
                        </el-form-item>


                        <el-form-item label="email" prop="Email" placeholder="Please enter your email address">
                            <el-input v-model.trim="formData.Email"></el-input>
                        </el-form-item>


                        <el-form-item label="PhoneNumber" prop="PhoneNumber" placeholder="Please enter your phoneNumber">
                            <el-input v-model.trim="formData.PhoneNumber"></el-input>
                        </el-form-item>


                        <el-form-item label="date of birth" prop="Birth" placeholder="Please enter the time of birth">
                            <el-date-picker v-model="formData.Birth" align="right" type="date" placeholder="Select time of birth"
                                value-format="yyyy-MM-dd HH:mm:ss">
                            </el-date-picker>
                        </el-form-item>

                        <el-form-item label="name" prop="Name" placeholder="Please enter your name">
                            <el-input v-model.trim="formData.Name"></el-input>
                        </el-form-item>

<!--                    <el-col :span="24">-->
<!--                        <el-form-item label="photo" prop="ImageUrls">-->
<!--                            <UploadImages :limit="1" v-model="formData.ImageUrls"></UploadImages>-->
<!--                        </el-form-item>-->
<!--                    </el-col>-->
                  <el-form-item label="Eye Color" prop="EyeColor">
                    <el-select v-model="formData.EyeColor" placeholder="Please select">
                      <el-option key="RED" label="RED" value="RED"></el-option>
                      <el-option key="BLACK" label="BLACK" value="BLACK"></el-option>
                      <el-option key="YELLOW" label="YELLOW" value="YELLOW"></el-option>
                      <el-option key="ORANGE" label="ORANGE" value="ORANGE"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item label="Hair Color" prop="HairColor">
                    <el-select v-model="formData.HairColor" placeholder="Please select">
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
                    <el-select v-model="formData.Nationality" placeholder="Please select">
                      <el-option key="RUSSIA" label="RUSSIA" value="RUSSIA"></el-option>
                      <el-option key="ITALY" label="ITALY" value="ITALY"></el-option>
                      <el-option key="JAPAN" label="JAPAN" value="JAPAN"></el-option>
                    </el-select>
                  </el-form-item>

                </el-row>


                <el-row type="flex" justify="end" align="bottom">
                    <el-form-item>
                        <el-button type="primary" plain @click="CreateOrEditForm()">confirm</el-button>
                        <el-button  @click="editorShow = false">Cancel</el-button>
                    </el-form-item>
                </el-row>
            </el-form>

        </el-dialog>
      </el-card>
    </div>
</template>


<script>
import store from '@/store';
import { mapGetters } from 'vuex'
import moment from 'moment'
export default {
    name: "UserList",
    computed: {
        ...mapGetters([
            'Token', 'UserInfo', 'RoleType', 'HasUserInfo', 'ColumnType', "UserId"
        ])
    },
    data() {
        return {
            searchForm: {},
            editorShow: false,
            dataColum: [
                {
                    key: "Id",
                    hidden: true,

                },
                {
                    key: "RoleType",
                    hidden: true,

                },
                {
                    key: "UserName",
                    title: "UserName",
                    type: store.getters.ColumnType.SHORTTEXT,

                },

                // {
                //     key: "Password",
                //     title: "Password",
                //     type: store.getters.ColumnType.SHORTTEXT,
                //
                // },
                {
                    key: "Email",
                    title: "Email",
                    type: store.getters.ColumnType.SHORTTEXT,

                },
                {
                    key: "Name",
                    title: "Name",
                    type: store.getters.ColumnType.SHORTTEXT,

                },

                // {
                //     key: "ImageUrls",
                //     title: "ImageUrls",
                //     type: store.getters.ColumnType.IMAGES,
                //
                // },

                {
                    key: "PhoneNumber",
                    title: "PhoneNumber",
                    type: store.getters.ColumnType.PHONE,

                },
                {
                    key: "Birth",
                    title: "Birth",
                    type: store.getters.ColumnType.DATE,

                },
                {
                    key: "RoleTypeFormat",
                    title: "RoleTypeFormat",
                    type: store.getters.ColumnType.SHORTTEXT,

                },
                {
                    key: "EyeColor",
                    title: "EyeColor",
                    type: store.getters.ColumnType.SHORTTEXT,

                },
              {
                    key: "HairColor",
                    title: "HairColor",
                    type: store.getters.ColumnType.SHORTTEXT,

                },
              {
                  key: "Height",
                  title: "Height",
                  type: store.getters.ColumnType.SHORTTEXT,
                },
              {
                key: "Nationality",
                title: "Nationality",
                type: store.getters.ColumnType.SHORTTEXT,
              },
                {
                    title: "Operate",
                    width:"200px",
                    key: "Operate",
                    type: store.getters.ColumnType.USERDEFINED,
                },
            ],
            formData: {
            },
            editModalFormRules: {
                "UserName": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],
                "Password": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],
                "Email": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],
                "ImageUrls": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],
                "Name": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],

                "PhoneNumber": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                    {
                        validator: (rule, value, callback) => {
                            var reg = /^1[34578]\d{9}$/;
                            if (!value || !reg.test(value)) {
                                callback(new Error('Please enter the correct mobile phone number'));
                            }
                            else {
                                callback();
                            }
                        }, trigger: 'blur'
                    },
                ],
                "Birth": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],
                "RoleType": [
                    { required: true, message: 'This field is required', trigger: 'blur' },
                ],
              "EyeColor": [{ required: true, message: 'Please select an eye color', trigger: 'change' }],
              "HairColor": [{ required: true, message: 'Please select a hair color', trigger: 'change' }],
              "Height": [{ required: true, message: 'Please enter your height', trigger: 'blur' }],
              "Nationality": [{ required: true, message: 'Please select your nationality', trigger: 'change' }]
            },

            listLoading: false,
        }
    },
    created() {

    },
    methods: {
        /**
        * 点击新增或者编辑的时候会触发
        */
        async ShowEditModal(Id) {
          let { Data } = await this.$Post(`/User/Get`, { Id: Id });
          console.log("API 返回的 Data:", Data);
          this.formData = Data || {};  // 确保 formData 不为空对象
          console.log("赋值后的 formData:", this.formData);
          this.editorShow = true;
        },


      /**
       * 点击保存的时候会触发
       */
        async CreateOrEditForm() {

            this.$refs.editModalForm.validate(async valid => {
                if (valid) {
                    var { Success } = await this.$Post(`/User/CreateOrEdit`, this.formData);
                    if (Success) {
                        this.editorShow = false;
                        this.$refs.PaginationTableId.Reload(this.searchForm);
                    }
                }
            })
        },

        // async SearchClick() {
        //     this.$refs.PaginationTableId.Reload(this.searchForm);
        // },'
      async SearchClick() {
        console.log('searchForm:', this.searchForm); // 打印 searchForm
        this.$refs.PaginationTableId.Reload(this.searchForm);
      },

      /**
       * 点击清空表单会触发
       */
        async ResetClick() {
            this.searchForm = {};
            this.$refs.PaginationTableId.Reload(this.searchForm);
        },
        /**
       * 单个删除的时候会触发
       */
        async ShowDeleteModal(Id) {
            await this.$PostDelete(`/User/Delete`, { Id: Id });
            this.$refs.PaginationTableId.Reload(this.searchForm);
        },

      /**
       * 跳转到 UserPerson 页面
       */
      redirectToUserPerson() {
        this.$router.push({ path: "/Admin/UserPerson" });
      },

      async calculateAverageHeight() {
        try {
          let { Data } = await this.$Post("/User/CalculateAverageHeight", this.searchForm);
          this.$message.info(`Average Height: ${Data}`);
        } catch (error) {
          this.$message.error("Failed to calculate average height");
        }
      }

    }
}
</script>

<style scoped></style>