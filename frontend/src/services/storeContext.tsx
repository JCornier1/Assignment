"use client";
import { createContext, useState } from "react";
import type { User } from "@/models/userModel";
import { useFetch } from "@/services/useFetch";

const initialStoreContextState: StoreContextState = {
  users: [],
};

export const StoreContext = createContext<StoreContextState>(
  initialStoreContextState
);

export const StoreProvider = ({ children }: any) => {
  //State
  // const [users, setUsers] = useState<User[]>([]);
  const { data: users } = useFetch<User>(
    "https://jsonplaceholder.typicode.com/users"
  );

  return (
    <StoreContext.Provider
      value={{
        users,
      }}
    >
      {children}
    </StoreContext.Provider>
  );
};

interface StoreContextState {
  users: User[];
}
