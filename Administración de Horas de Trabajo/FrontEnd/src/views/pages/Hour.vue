<script setup>
import { ref, onMounted, watch, computed } from 'vue';
import { getCompanies } from '../../service/CompanyService';
import { DateTime } from 'luxon';
import { useToast } from 'primevue/usetoast';
import { registerHourWorked } from '../../service/HourService';
const toast = useToast();

let dateWork = ref(null);
let dayWork = ref(null)
let endTime = ref(null)
let startTime = ref(null)
let totalHours = ref(0)
let company = ref(null)
let formattedDate = null
const companies = ref(null)
const loading = ref(false)

const load = async () => {
    loading.value = true;
    const formattedStartTime = DateTime.fromJSDate(startTime.value, { zone: 'America/Bogota' }).toFormat('h:mma');
    const formattedEndTime = DateTime.fromJSDate(endTime.value, { zone: 'America/Bogota' }).toFormat('h:mma');

    const data = {
        day_worked: dayWork.value,
        date_worked: formattedDate,
        start_time: formattedStartTime,
        end_time: formattedEndTime,
        id_company: +company.value.code,
        total_hours: totalHours.value.toString(),
    }
    await registerHourWorked(data)

    resetForm()
    setTimeout(() => {
        loading.value = false;
        toast.add({ severity: 'success', summary: 'Successful', detail: `Horas registradas con éxito`, life: 3000 });
    }, 2000);
};

const getDayOfWeek = () => {
    if (dateWork.value) {
        // Convierte la fecha a un objeto Luxon usando fromJSDate para trabajar con objetos Date
        const date = DateTime.fromJSDate(dateWork.value, { zone: 'America/Bogota' });
        const daysOfWeek = ['domingo', 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado'];
        const dayIndex = date.weekday % 7;
        dayWork.value = daysOfWeek[dayIndex];
        formattedDate = date.toFormat('yyyy-MM-dd');
    } else {
        dayWork.value = null
    }

};

const resetForm = () => {
    dateWork.value = null;
    dayWork.value = null;
    endTime.value = null;
    startTime.value = null;
    totalHours.value = 0;
    company.value = null;
};

onMounted(async () => {
    companies.value = await getCompanies()
})

watch(dateWork, getDayOfWeek);

const isFormValid = computed(() => {
    return dateWork.value && dayWork.value && endTime.value && startTime.value && totalHours.value && company.value;
});

</script>
<template>
    <div class="grid p-fluid">
        <div class="col-12">
            <div class="card">
                <h5>Escoga la fecha</h5>
                <Calendar :showIcon="true" dateFormat="dd/mm/yy" :showButtonBar="true" v-model="dateWork"
                    placeholder="Fecha trabajada" />

                <h5 class="mb-4">Día trabajado</h5>
                <FloatLabel>
                    <InputText type="text" v-model="dayWork" disabled />
                </FloatLabel>

                <h5>Horas de trabajo</h5>
                <div class="grid formgrid">
                    <div class="col-12 mb-4 lg:col-6 lg:mb-0 ">
                        <IconField iconPosition="right">
                            <Calendar v-model="startTime" hourFormat="12" :showTime="true" :timeOnly="true"
                                :showSeconds="false" :showOnFocus="true" placeholder="Hora Inicio" />
                            <InputIcon class="pi pi-calendar-times" />
                        </IconField>
                    </div>
                    <div class="col-12 mb-2 lg:col-6 lg:mb-0 ">
                        <IconField iconPosition="right">
                            <Calendar v-model="endTime" hourFormat="12" :showTime="true" :timeOnly="true"
                                :showSeconds="false" :showOnFocus="true" placeholder="Hora Fin" />
                            <InputIcon class="pi pi-calendar-times" />
                        </IconField>
                    </div>
                </div>

                <h5 class="mb-4">Total Horas</h5>
                <FloatLabel>
                    <InputNumber v-model="totalHours" inputId="horizontal-buttons" showButtons buttonLayout="horizontal"
                        :step="0.50" mode="decimal" :min="0" :max="24" fluid>
                        <template #incrementbuttonicon>
                            <span class="pi pi-plus" />
                        </template>
                        <template #decrementbuttonicon>
                            <span class="pi pi-minus" />
                        </template>
                    </InputNumber>
                </FloatLabel>

                <h5>Escoga la empresa</h5>
                <Dropdown v-model="company" :options="companies" optionLabel="name"
                    placeholder="Seleccione una empresa" />

                <Divider />

                <div class=" flex justify-content-center">
                    <Button type="button" label="Guardar" icon="pi pi-save" :loading="loading" :disabled="!isFormValid"
                        @click="load" />
                </div>

            </div>
        </div>

    </div>
</template>
