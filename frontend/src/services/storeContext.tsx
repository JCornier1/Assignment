'use client';
import { createContext, useState } from 'react';
import type { User } from '@/models/userModel';
import { useFetch } from '@/services/useFetch';

const initialStoreContextState: StoreContextState = {
	users: [],
	activatedModal: { activated: false, currentId: 1 },
	openModal: () => {},
	closeModal: () => {},
	deleteUser: () => {},
};

export const StoreContext = createContext<StoreContextState>(
	initialStoreContextState
);

export const StoreProvider = ({ children }: any) => {
	//State
	const { data: users, setData: setUsers } = useFetch<User>(
		'https://jsonplaceholder.typicode.com/users'
	);

	const [activatedModal, setActivatedModal] = useState<activatedModalInterface>(
		{
			activated: false,
			currentId: 1,
		}
	);

	// Setters of the modal
	const openModal = (userId: number) =>
		setActivatedModal({ activated: true, currentId: userId });
	const closeModal = () =>
		setActivatedModal((prevState) => {
			return { ...prevState, activated: false };
		});

	//users Delete
	const deleteUser = (userId: number) => {
		setUsers((users) => {
			return users.filter((user) => user.id !== userId);
		});
		closeModal();
	};

	return (
		<StoreContext.Provider
			value={{
				users,
				activatedModal,
				deleteUser,
				openModal,
				closeModal,
			}}
		>
			{children}
		</StoreContext.Provider>
	);
};

interface StoreContextState {
	users: User[];
	activatedModal: activatedModalInterface;
	openModal: (userId: number) => void;
	closeModal: () => void;
	deleteUser: (userId: number) => void;
}

interface activatedModalInterface {
	activated: boolean;
	currentId: number;
}
