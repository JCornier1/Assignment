"use client";

import { StoreContext } from "@/services/storeContext";
import { useContext, useEffect, useState } from "react";
import type { User } from "@/models/userModel";

export function ModalComponent() {
  // global state
  const { users, closeModal, activatedModal, deleteUser } =
    useContext(StoreContext);

  // local state
  const [currentUserInfo, setCurrentUserInfo] = useState<User | undefined>(
    users.find((user) => user.id === activatedModal.currentId)
  );

  useEffect(() => {
    setCurrentUserInfo(
      users.find((user) => user.id === activatedModal.currentId)
    );
  }, [users]);

  return (
    <div
      className="relative z-10"
      aria-labelledby="modal-title"
      role="dialog"
      aria-modal="true"
    >
      <div
        className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
        aria-hidden="true"
      ></div>

      <div className="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div className="flex min-h-full items-center justify-center p-4 text-center sm:items-center sm:p-0">
          <div className="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
            <div className="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
              <div className="sm:flex sm:items-start">
                <img
                  className="h-12 w-12 flex-none rounded-full bg-gray-50"
                  src={`https://picsum.photos/seed/${currentUserInfo?.id}/200`}
                  alt="user avatar"
                />
                <div className="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                  <h3
                    className="text-base font-semibold leading-6 text-gray-900"
                    id="modal-title"
                  >
                    {currentUserInfo?.name}
                  </h3>
                  <div className="mt-2">
                    <p className="text-sm text-gray-500 py-1">
                      <b>username:</b> {currentUserInfo?.username}
                    </p>
                    <p className="text-sm text-gray-500 py-1">
                      <b>email:</b> {currentUserInfo?.email}
                    </p>
                    <p className="text-sm text-gray-500 py-1">
                      <b>address:</b>
                      <p className="ml-1">
                        <b>city:</b> {currentUserInfo?.address.city}
                      </p>
                      <p className="ml-1">
                        <b>street:</b> {currentUserInfo?.address.street}
                      </p>
                      <p className="ml-1">
                        <b>suit:</b> {currentUserInfo?.address.suite}
                      </p>
                    </p>
                    <p className="text-sm text-gray-500 py-1">
                      <b>phone:</b> {currentUserInfo?.phone}
                    </p>
                    <p className="text-sm text-gray-500 py-1">
                      <b>website:</b> {currentUserInfo?.website}
                    </p>
                    <p className="text-sm text-gray-500">
                      <b>company:</b> {currentUserInfo?.company.name}
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div className="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
              <button
                type="button"
                onClick={() => deleteUser(currentUserInfo?.id ?? 1)}
                className="mb-1 inline-flex w-full justify-center rounded-md bg-red-700 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-800 sm:ml-3 sm:w-auto"
              >
                Delete
              </button>
              <button
                type="button"
                onClick={() => closeModal()}
                className="mb-1 inline-flex w-full justify-center rounded-md bg-sky-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-sky-800 sm:ml-3 sm:w-auto"
              >
                Ok
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
