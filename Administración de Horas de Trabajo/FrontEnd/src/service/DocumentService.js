import axios from "axios";
import { BASE_URL } from "./ConfigService";
export const generatePDF = async (data) => {
    const response = await axios.post(`${BASE_URL}/document/generate_document`, data, {
        responseType: 'blob'
    });

    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'horas__trabajadas_ROMAN.pdf'); // Nombre del archivo que se descargará
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}