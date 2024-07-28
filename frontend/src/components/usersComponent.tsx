"use client";
import { useEffect, useContext } from "react";
import { ModalComponent } from "./modalComponent";
import { StoreContext } from "@/services/storeContext";

export function UserComponent() {
  // global state
  const { users, activatedModal, openModal } = useContext(StoreContext);

  useEffect(() => {}, [users]);
  return (
    <div className="p-4">
      {activatedModal.activated && <ModalComponent />}
      <h1 className="text-2xl font-bold">Users List</h1>
      <ul role="list" className="divide-y divide-gray-100 w-full">
        {users.map((user) => (
          <li
            className="flex justify-between gap-x-6 py-5 hover:cursor-pointer hover:bg-gray-200"
            onClick={() => openModal(user.id)}
            key={user.id}
          >
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
