import axios from "axios";
import { BASE_URL } from "./ConfigService";
export const getCompanies = async () => {
    return (await axios.get(`${BASE_URL}/companies/get_all_companies`)).data;
}

export const getCompaniesSchemaDB = async () => {
    return (await axios.get(`${BASE_URL}/companies/get_companies`)).data;
}

export const registerCompany = async (data) => {
    return (await axios.post(`${BASE_URL}/companies/create_company`,data)).data;
}

export const updateCompany = async (id_company,data) => {
    return (await axios.put(`${BASE_URL}/companies/update_company/${id_company}`,data)).data;
}

export const deleteCompany = async (id_company) => {
    return (await axios.put(`${BASE_URL}/companies/delete_company/${id_company}`)).data;
}

