<template>
  <div class="Register-password">
    <div class="container">
      <!-- 左侧图片区域 -->
      <div class="left-section">
        <div class="image-wrapper">
          <img src="@/assets/login1.png" alt="Login">
          <div class="overlay"></div>
        </div>
        <div class="tech-circles">
          <span v-for="i in 5" :key="i"></span>
        </div>
      </div>

      <!-- 右侧表单区域 -->
      <div class="right-section">
        <div class="form-container">
          <h2 class="title">
            <span class="tech-line"></span>
            Register an account
            <span class="tech-line"></span>
          </h2>
          
          <el-form ref="loginForm" :model="formData" :rules="rules">
            <el-form-item prop="UserName">
              <el-input 
                v-model.trim="formData.UserName" 
                prefix-icon="el-icon-user"
                placeholder="Please enter your account number">
              </el-input>
            </el-form-item>

            <el-form-item prop="Email">
              <el-input 
                v-model.trim="formData.Email" 
                prefix-icon="el-icon-message"
                placeholder="Please enter your email address">
              </el-input>
            </el-form-item>

            <el-form-item prop="PhoneNumber">
              <el-input 
                v-model.trim="formData.PhoneNumber" 
                prefix-icon="el-icon-phone"
                placeholder="Please enter your phone number">
              </el-input>
            </el-form-item>

            <el-form-item prop="Password">
              <el-input 
                v-model.trim="formData.Password" 
                prefix-icon="el-icon-lock"
                type="password"
                placeholder="Please enter new password">
              </el-input>
            </el-form-item>

            <el-button-group class="role-buttons">
              <el-button
                  :type="formData.RoleType === 'User' ? 'primary' : 'default'"
                  @click="setRole('2')">
                Register as User
              </el-button>
              <el-button
                  :type="formData.RoleType === 'Admin' ? 'primary' : 'default'"
                  @click="setRole('1')">
                Register as Admin
              </el-button>
            </el-button-group>

            <el-form-item prop="Code" class="verify-code">
              <el-input 
                v-model.trim="formData.Code" 
                prefix-icon="el-icon-key"
                placeholder="Please enter the verification code">
              </el-input>
              <ValidCode ref="ValidCode" class="code-component"></ValidCode>
            </el-form-item>

            <el-form-item prop="RoleType" class="role-select">
              <el-radio-group v-model="formData.RoleType">
                <el-radio v-for="item in roleOptions" :key="item.Code" :label="item.Code">
                  {{ item.Label }}
                </el-radio>
              </el-radio-group>
            </el-form-item>


            <el-button type="primary" class="submit-btn" @click="RegisterBtn">
              Register
              <i class="el-icon-right"></i>
            </el-button>
          </el-form>

          <div class="footer-links">
            <RouterLink to="/Login" class="login-link">
              Back to Login
              <i class="el-icon-arrow-right"></i>
            </RouterLink>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import ValidCode from '@/components/Code/canvas.vue';
export default {
    components: {
        ValidCode: ValidCode
    },
    data() {
        return {
            formData: {
                UserName: '',
                Password: '',

                Code: ""
            },

            rules: {
                UserName: [
                    { required: true, message: 'Please enter your account number', trigger: 'blur' },
                ],
                Password: [
                    { required: true, message: 'Please enter your password', trigger: 'blur' },
                ],
                "Email": [
                    { required: true, message: 'This item is required', trigger: 'blur' },
                    {
                        validator: (rule, value, callback) => {
                            var reg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
                            if (!value || !reg.test(value)) {
                                callback(new Error('Please enter a valid email address'));
                            }
                            else {
                                callback();
                            }
                        }, trigger: 'blur'
                    },
                ],
                "ImageUrls": [
                    { required: true, message: 'This item is required', trigger: 'blur' },
                ],
                "Name": [
                    { required: true, message: 'This item is required', trigger: 'blur' },
                ],

                "PhoneNumber": [
                    { required: true, message: 'This item is required', trigger: 'blur' },
                    {
                        validator: (rule, value, callback) => {
                            var reg = /^1[34578]\d{9}$/;
                            if (!value || !reg.test(value)) {
                                callback(new Error('Please enter a valid mobile phone number'));
                            }
                            else {
                                callback();
                            }
                        }, trigger: 'blur'
                    },
                ],
                Code: [
                    { required: true, message: 'Please enter the verification code', trigger: 'blur' },
                    {
                        validator: (rule, value, callback) => {
                            let identifyCode = this.$refs.ValidCode.getCode();

                            if (value != identifyCode) {
                                callback(new Error('Please enter the correct verification code'));
                            } else {
                                callback();
                            }
                        }, trigger: 'blur'
                    }
                ]
            }
        }

    },
    created() {

    },
    methods: {
        setRole(role) {
          this.formData.RoleType = role;
        },

      RegisterBtn() {
            this.$refs.loginForm.validate(async (valid) => {
                if (valid) {

                    let res = await this.$Post("/User/Register", this.formData)
                    console.log(res);
                    if (res.Success) {
                        this.$message.success("Password changed successfully!");
                        this.$router.push({
                            path: "/Login"
                        })
                    }
                    else {

                        this.$refs.ValidCode.refreshCode();
                    }
                } else {
                    this.$message.error("Verification failed")
                    this.$refs.ValidCode.refreshCode();
                    return false;
                }
            });
        }
    }
}
</script>

<style scoped>
.Register-password {
  min-height: 100vh;
  background: linear-gradient(135deg, #1a237e 0%, #0d47a1 100%);
  display: flex;
  align-items: center;
  justify-content: center;
}

.container {
  width: 1200px;
  height: 700px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
  display: flex;
  overflow: hidden;
  backdrop-filter: blur(10px);
}

.left-section {
  flex: 1;
  position: relative;
  overflow: hidden;
}

.image-wrapper {
  height: 100%;
  position: relative;
}

.image-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(45deg, rgba(26, 35, 126, 0.7) 0%, rgba(13, 71, 161, 0.7) 100%);
}

.tech-circles span {
  position: absolute;
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  animation: rotate 20s linear infinite;
}

.tech-circles span:nth-child(1) { width: 100px; height: 100px; top: 10%; left: 10%; }
.tech-circles span:nth-child(2) { width: 150px; height: 150px; top: 40%; left: 50%; }
.tech-circles span:nth-child(3) { width: 80px; height: 80px; top: 70%; left: 20%; }
.tech-circles span:nth-child(4) { width: 120px; height: 120px; top: 20%; left: 70%; }
.tech-circles span:nth-child(5) { width: 90px; height: 90px; top: 60%; left: 80%; }

.right-section {
  flex: 1;
  padding: 40px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.form-container {
  width: 400px;
  margin: 0 auto;
}

.title {
  font-size: 28px;
  color: #1a237e;
  margin-bottom: 40px;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 15px;
}

.tech-line {
  height: 2px;
  width: 30px;
  background: linear-gradient(90deg, #1a237e, #0d47a1);
}

.el-input {
  margin-bottom: 20px;
}

.verify-code {
  display: flex;
  gap: 10px;
}

.code-component {
  flex-shrink: 0;
}

.submit-btn {
  width: 100%;
  height: 50px;
  background: linear-gradient(90deg, #1a237e, #0d47a1);
  border: none;
  font-size: 16px;
  margin-top: 20px;
  transition: transform 0.3s;
}

.submit-btn:hover {
  transform: translateY(-2px);
}

.footer-links {
  margin-top: 20px;
  text-align: center;
}

.login-link {
  color: #1a237e;
  text-decoration: none;
  font-size: 14px;
  transition: color 0.3s;
}

.login-link:hover {
  color: #0d47a1;
}

@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>
