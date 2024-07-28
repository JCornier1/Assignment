import { useEffect, useState } from "react";

export function useFetch<T>(url:string){
    const[data, setData] = useState<T[]>([]);

    useEffect(()=>{
        async function fetchData() {
            try {
                const response = await fetch(url)
                const data = await response.json() as T[]
                setData(data)
            } catch (error) {
                console.error(error)
            }            
        }
        fetchData()
    },[url])
    return {data}
}
