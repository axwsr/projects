<script setup>
import { FilterMatchMode } from 'primevue/api';
import { ref, onMounted, onBeforeMount } from 'vue';
import { useToast } from 'primevue/usetoast';
import { deleteCompany, getCompaniesSchemaDB, registerCompany, updateCompany } from '../../service/CompanyService';

const toast = useToast();
const productDialog = ref(false);
const deleteProductDialog = ref(false);

const company = ref({});
const companies = ref(null)
const selectedProducts = ref(null);
const dt = ref(null);
const filters = ref({});
const submitted = ref(false);

onBeforeMount(() => {
    initFilters();
});

onMounted(async () => {
    companies.value = await getCompaniesSchemaDB()
});



const openNew = () => {
    company.value = {};
    submitted.value = false;
    productDialog.value = true;
};

const hideDialog = () => {
    productDialog.value = false;
    submitted.value = false;
};

const saveProduct = async () => {
    submitted.value = true;
    if (company.value.name_company && company.value.name_company.trim()) {
        if (company.value.id_company) {
            const response = await updateCompany(company.value.id_company, company.value)
            companies.value[findIndexById(company.value.id_company)] = response
            toast.add({ severity: 'success', summary: 'Successful', detail: 'Empresa editada.', life: 3000 });
        } else {
            const response = await registerCompany(company.value)
            companies.value.push(response)
            toast.add({ severity: 'success', summary: 'Successful', detail: 'Empresa registrada con éxito', life: 3000 });
        }
        productDialog.value = false;
        company.value = {};
    }
};

const editProduct = (editProduct) => {
    company.value = { ...editProduct };
    productDialog.value = true;
};

const confirmDeleteProduct = (editProduct) => {
    company.value = editProduct;
    deleteProductDialog.value = true;
};

const deleteProduct = async () => {
    await deleteCompany(company.value.id_company)
    companies.value = companies.value.filter((val) => val.id_company !== company.value.id_company);
    deleteProductDialog.value = false;
    company.value = {};
    toast.add({ severity: 'success', summary: 'Successful', detail: 'company Deleted', life: 3000 });
};

const findIndexById = (id) => {
    let index = -1;
    for (let i = 0; i < companies.value.length; i++) {
        if (companies.value[i].id_company === id) {
            index = i;
            break;
        }
    }
    return index;
};



const initFilters = () => {
    filters.value = {
        global: { value: null, matchMode: FilterMatchMode.CONTAINS }
    };
};
</script>

<template>
    <div class="grid">
        <div class="col-12">
            <div class="card">
                <Toolbar class="mb-4">
                    <template v-slot:start>
                        <div class="my-2">
                            <Button label="New" icon="pi pi-plus" class="mr-2" severity="success" @click="openNew" />
                        </div>
                    </template>
                </Toolbar>

                <DataTable ref="dt" :value="companies" v-model:selection="selectedProducts" dataKey="id"
                    :paginator="true" :rows="10" :filters="filters"
                    paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
                    :rowsPerPageOptions="[5, 10, 25]"
                    currentPageReportTemplate="Mostrando de {first} a {last} de {totalRecords} empresas">
                    <template #header>
                        <div class="flex flex-column md:flex-row md:justify-content-between md:align-items-center">
                            <h5 class="m-0">Empresas registradas</h5>

                        </div>
                    </template>


                    <Column field="name" header="Name" :sortable="true" headerStyle="width:40%; min-width:10rem;">
                        <template #body="slotProps">
                            <span class="p-column-title">Name</span>
                            {{ slotProps.data.name_company }}
                        </template>
                    </Column>

                    <Column header="Acciones" headerStyle="min-width:10rem;">
                        <template #body="slotProps">
                            <Button icon="pi pi-pencil" class="mr-2" severity="success" rounded
                                @click="editProduct(slotProps.data)" />
                            <Button icon="pi pi-trash" class="mt-2" severity="danger" rounded
                                @click="confirmDeleteProduct(slotProps.data)" />
                        </template>
                    </Column>
                </DataTable>

                <Dialog v-model:visible="productDialog" :style="{ width: '450px' }" header="Empresa" :modal="true"
                    class="p-fluid">

                    <div class="field">
                        <label for="name">Nombre</label>
                        <InputText id="name" v-model.trim="company.name_company" required="true" autofocus
                            :invalid="submitted && !company.name_company" />
                        <small class="p-invalid" v-if="submitted && !company.name_company">El nombre es
                            obligatorio.</small>
                    </div>

                    <template #footer>
                        <Button label="Cancelar" icon="pi pi-times" text="" @click="hideDialog" />
                        <Button label="Registrar" icon="pi pi-check" text="" @click="saveProduct" />
                    </template>
                </Dialog>

                <Dialog v-model:visible="deleteProductDialog" :style="{ width: '450px' }" header="Confirm"
                    :modal="true">
                    <div class="flex align-items-center justify-content-center">
                        <i class="pi pi-exclamation-triangle mr-3" style="font-size: 2rem" />
                        <span v-if="company">Seguro que quieres borrar <b>{{ company.name_company }}</b>?</span>
                    </div>
                    <template #footer>
                        <Button label="No" icon="pi pi-times" text @click="deleteProductDialog = false" />
                        <Button label="Si" icon="pi pi-check" text @click="deleteProduct" />
                    </template>
                </Dialog>
            </div>
        </div>
    </div>
</template>
