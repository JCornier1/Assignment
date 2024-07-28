"use client";
import { useState, useEffect, useContext } from "react";
import type { User } from "@/models/userModel";
import { ModalComponent } from "./modalComponent";
import { StoreContext } from "@/services/storeContext";

export function UserComponent() {
  const { users } = useContext(StoreContext);

  const [modalActivated, setModalActivated] = useState(false);

  function openModal() {
    setModalActivated(!modalActivated);
  }

  useEffect(() => {
    console.log("los usuarios", users);
  }, [users]);
  return (
    <div>
      <h1 className="text-sky-400">Users List</h1>
      <ul role="list" className="divide-y divide-gray-100">
        {users.map((user) => (
          <li className="flex justify-between gap-x-6 py-5" key={user.id}>
            <div className="flex min-w-0 gap-x-4">
              <img
                className="h-12 w-12 flex-none rounded-full bg-gray-50"
                src={`https://picsum.photos/seed/${user.id}/200`}
                alt="user avatar"
              />
              <div className="min-w-0 flex-auto">
                <p className="text-sm font-semibold leading-6 text-gray-900">
                  {user.name}
                </p>
                <p className="mt-1 truncate text-xs leading-5 text-gray-500">
                  {user.email}
                </p>
              </div>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}
