import axios from "axios";
import { BASE_URL } from "./ConfigService";
export const registerHourWorked = async (data) => {
    return (await axios.post(`${BASE_URL}/hour_work/register_hour_work`,data)).data;
}

export const getHourWorkedByDate = async (data) => {
    return (await axios.post(`${BASE_URL}/hour_work/get_hours_worked`,data)).data;
}
