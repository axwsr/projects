<script setup>
import { ref, watch } from 'vue';
import { useLayout } from '@/layout/composables/layout';
import SpeedDial from 'primevue/speeddial';
import { useRouter } from 'vue-router';

const { isDarkTheme } = useLayout();
const lineOptions = ref(null);
const router = useRouter();

const items = ref([
    {
        label: 'Add',
        icon: 'pi pi-play',
        command: () => {
            router.push('/pages/empty');
        }
    },
    {
        label: 'Update',
        icon: 'pi pi-plus',
        command: () => {
            router.push('/pages/hour');
        }
    },
    {
        label: 'Delete',
        icon: 'pi pi-file-pdf',
        command: () => {
            router.push('/pages/document');
        }
    },
    {
        label: 'Vue Website',
        icon: 'pi pi-building',
        command: () => {
            router.push('/pages/company');
        }
    }
])

const applyLightTheme = () => {
    lineOptions.value = {
        plugins: {
            legend: {
                labels: {
                    color: '#495057'
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: '#495057'
                },
                grid: {
                    color: '#ebedef'
                }
            },
            y: {
                ticks: {
                    color: '#495057'
                },
                grid: {
                    color: '#ebedef'
                }
            }
        }
    };
};

const applyDarkTheme = () => {
    lineOptions.value = {
        plugins: {
            legend: {
                labels: {
                    color: '#ebedef'
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: '#ebedef'
                },
                grid: {
                    color: 'rgba(160, 167, 181, .3)'
                }
            },
            y: {
                ticks: {
                    color: '#ebedef'
                },
                grid: {
                    color: 'rgba(160, 167, 181, .3)'
                }
            }
        }
    };
};

watch(
    isDarkTheme,
    (val) => {
        if (val) {
            applyDarkTheme();
        } else {
            applyLightTheme();
        }
    },
    { immediate: true }
);
</script>

<template>
    <div class="grid">
        <div class="col-12">
            <div class="card">
                <div class="flex align-items-center justify-content-between mb-4">
                    <h2 class="welcome"> BIENVENIDO <i>MAURICIO ROMÁN</i> 👋 </h2>
                </div>

                <h4>¿Que quieres hacer?</h4>

                <Divider />
                <div class="card flex align-items-center justify-content-center"
                    :style="{ position: 'relative', height: '200px' }">
                    <SpeedDial :model="items" mask :radius="80" type="circle" buttonClass="p-button-success" />
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.welcome {
    font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
}
</style>