import axios from "axios";

export default defineNuxtPlugin(async (nuxtApp) => {
    const apiClient = axios.create({
        baseURL: "http://localhost:8000/api",
        headers: {
            "Content-Type": "application/json",
        },
    });


    return {
        provide: {
            axios: apiClient,
        },
    };
});