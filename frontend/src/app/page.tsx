import Image from 'next/image';
import styles from './page.module.css';
import { UserComponent } from '@/components/usersComponent';

export default function Home() {
	return (
		<main>
			<UserComponent />
		</main>
	);
}
