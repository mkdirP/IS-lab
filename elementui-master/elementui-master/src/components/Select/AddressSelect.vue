
  <template>
    <div>
        <el-select :filterable="true" v-model="selectedProvince" placeholder="请选择省份" @change="handleProvinceChange">
            <el-option v-for="province in provinceData" :key="province.value" :label="province.label"
                :value="province.value"></el-option>
        </el-select>
        -
        <el-select :filterable="true" v-model="selectedCity" placeholder="请选择城市" :disabled="!selectedProvince"
            @change="handleCityChange">
            <el-option v-for="city in cityData" :key="city.value" :label="city.label" :value="city.value"></el-option>
        </el-select>
        -
        <el-select :filterable="true" v-model="selectedDistrict" placeholder="请选择区县" :disabled="!selectedCity"
            @change="handleInputChange">
            <el-option v-for="district in districtData" :key="district.value" :label="district.label"
                :value="district.value"></el-option>
        </el-select>
    </div>
</template>

<script>
import regionData from "./chian-area-data.js"
export default {
    name: 'AreaSelect',
    props: {
        value: [String, Object, Array],
    },
    data() {
        return {
            regionData,
            selectedProvince: '',
            selectedCity: '',
            selectedDistrict: '',
            provinceData: this.convertToOptions(regionData),
            cityData: [],
            districtData: [],
        };
    },
    watch: {
        value: {
            deep: true,
            immediate: true,
            handler(val) {
                if (val) {
                    if (val) {
                        const [selectedProvince, selectedCity, selectedDistrict] = val.split(',');
                        this.selectedProvince = selectedProvince;
                        this.selectedCity = selectedCity;
                        this.selectedDistrict = selectedDistrict;
                    }
                } else {
                    this.selectedProvince = '';
                    this.selectedCity = '';
                    this.selectedDistrict = '';
                }
            }
        }
    },
    methods: {
        convertToOptions(data) {
            return data.map(item => ({
                value: item.value,
                label: item.label,
            }));
        },
        handleProvinceChange() {
            const selectedProvinceData = this.regionData.find(item => item.value === this.selectedProvince);
            this.cityData = selectedProvinceData ? this.convertToOptions(selectedProvinceData.children) : [];
            this.districtData = [];
            this.selectedCity = '';
            this.selectedDistrict = '';

        },
        handleCityChange() {
            const selectedProvinceData = this.regionData.find(item => item.value === this.selectedProvince);
            const selectedCityData = selectedProvinceData.children.find(item => item.value === this.selectedCity);
            this.districtData = selectedCityData ? this.convertToOptions(selectedCityData.children) : [];
            this.selectedDistrict = '';

        },
        handleInputChange() {
            const selectedProvinceLabel = this.regionData.find(item => item.value === this.selectedProvince)?.label || '';
            const selectedCityLabel = this.cityData.find(item => item.value === this.selectedCity)?.label || '';
            const selectedDistrictLabel = this.districtData.find(item => item.value === this.selectedDistrict)?.label || '';

            const result = selectedProvinceLabel + ',' + selectedCityLabel + ',' + selectedDistrictLabel

            console.log(result)
            this.$emit("input", result);
            this.$emit("Change", { Provice: selectedProvinceLabel, City: selectedCityLabel, Area: selectedDistrictLabel })
        }
    },
};
</script>
<style scoped>
::v-deep .el-select--medium {
    width: 180px;
}
</style>

