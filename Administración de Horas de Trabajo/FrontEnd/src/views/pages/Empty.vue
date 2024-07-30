<script setup>
import { ref, onUnmounted, onMounted, computed } from 'vue';
import { useToast } from 'primevue/usetoast';
import { getCompanies } from '../../service/CompanyService';
import { registerHourWorked } from '../../service/HourService';
import { DateTime } from 'luxon';
const toast = useToast();
const isWorking = ref(false);
const timer = ref(0);
const interval = ref(null);
const timeFactor = 300; // Ajusta este valor para acelerar el tiempo (10x aquí)
const visibleDialog = ref(false);
const showEditInput = ref(false);
const roundedHours = ref(0);
const companies = ref(null)
const company = ref(null)
let start_time = ""
let end_time = ""


const startTimer = () => {
    start_time = getCurrentTime()
    isWorking.value = true;
    interval.value = setInterval(() => {
        // timer.value += 1;
        timer.value += timeFactor; // Incrementa el cronómetro por el factor de tiempo
    }, 1000);
};

const stopTimer = () => {
    isWorking.value = false;
    clearInterval(interval.value);
    interval.value = null;
};

const toggleTimer = () => {
    if (isWorking.value) {
        stopTimer();
        calculateRoundedHours();
        visibleDialog.value = true;
    } else {
        startTimer();
    }
};

const getCurrentDate = () => {
    return DateTime.now().setZone('America/Bogota').toFormat('yyyy-MM-dd');
}

// winz pinares
// MAL palo de agua


const getDayOfWeek = (dateString) => {
    const date = DateTime.fromISO(dateString, { zone: 'America/Bogota' });
    const daysOfWeek = ['domingo', 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado'];
    const dayIndex = date.weekday % 7; // Modificar para que el índice esté entre 0 y 6
    return daysOfWeek[dayIndex];
}

const getCurrentTime = () => {
    return DateTime.now().setZone('America/Bogota').toFormat('h:mma');
}

const calculateRoundedHours = () => {
    const hrs = Math.floor(timer.value / 3600);
    const mins = Math.floor((timer.value % 3600) / 60);

    if (mins > 20 && mins <= 44) {
        roundedHours.value = hrs + 0.5;
    } else if (mins > 44 && mins <= 60) {
        roundedHours.value = hrs + 1;
    } else {
        roundedHours.value = hrs;
    }
};

const registerHours = async () => {
    end_time = getCurrentTime()
    const data = {
        day_worked: getDayOfWeek(getCurrentDate()),
        date_worked: getCurrentDate(),
        start_time: start_time,
        end_time: end_time,
        id_company: +company.value.code,
        total_hours: roundedHours.value.toString(),
    }

    await registerHourWorked(data)

    timer.value = 0;
    visibleDialog.value = false;
    toast.add({ severity: 'success', summary: 'Successful', detail: ` ${roundedHours.value} Horas registradas con éxito  `, life: 3000 });

    start_time = ""
    end_time = ""
};

const continueWorking = () => {
    visibleDialog.value = false;
    startTimer();
};

const formatTime = (seconds) => {
    const hrs = Math.floor(seconds / 3600);
    const mins = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;
    return `${hrs.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
};

onMounted(async () => {
    companies.value = await getCompanies()
})

onUnmounted(() => {
    stopTimer();
});

const isCompanySelected = computed(() => {
    return company.value !== null;
});
</script>

<template>


    <div class="flex justify-content-center align-items-center">


        <div class="col-12 lg:col-5">

            <div class="p-3 h-full">
                <div class="shadow-2 p-3 flex flex-column surface-card" style="border-radius: 6px">
                    <Divider />

                    <div class="mt-3 mb-3 flex justify-content-center align-items-center">
                        <FloatLabel>
                            <Dropdown id="company" v-model="company" :options="companies" optionLabel="name"
                                placeholder="Seleccione una empresa"></Dropdown>
                            <label for="company">Empresa</label>
                        </FloatLabel>

                    </div>

                    <Divider />

                    <div class="text-900 font-medium text-xl mb-2 text-center mt-2">Registro de horas</div>

                    <div class="flex align-items-center justify-content-center mb-2">
                        <span class="font-bold text-2xl text-900">{{ formatTime(timer) }}</span>
                    </div>

                    <Divider />

                    <Button @click="toggleTimer" :severity="isWorking ? 'contrast' : 'success'"
                        :label="isWorking ? 'Dejar de trabajar' : 'Entrar a trabajar'"
                        class="p-3 w-full p-button-outlined mt-2" :disabled="!isCompanySelected"></Button>
                </div>
            </div>
        </div>
    </div>

    <Dialog v-model:visible="visibleDialog" modal header="Confirmacion de horas" :style="{ width: '25rem' }">
        <div class="text-900 font-medium text-xl mb-2 text-center">Horas: {{ roundedHours }} </div>
        <div class="mb-3">
            <Button label="Editar" @click="showEditInput = !showEditInput" link />
        </div>
        <div class="flex justify-content-center text-center mb-5 mt-3" v-if="showEditInput">
            <InputNumber v-model="roundedHours" inputId="horizontal-buttons" showButtons buttonLayout="horizontal"
                :step="0.50" mode="decimal" :min="0" :max="24" fluid>
                <template #incrementbuttonicon>
                    <span class="pi pi-plus" />
                </template>
                <template #decrementbuttonicon>
                    <span class="pi pi-minus" />
                </template>
            </InputNumber>
        </div>
        <div class="flex justify-end gap-2">
            <Button type="button" label="Cancelar" severity="secondary" @click="continueWorking"></Button>
            <Button type="button" label="Confirmar" @click="registerHours"></Button>
        </div>
    </Dialog>
</template>
