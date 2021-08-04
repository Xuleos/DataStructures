interface ArrayList<T> {
	/**
	 * Adds an object to the end of the ArrayList.
	 * @param Value The value to be added to the end of the ArrayList. The value cannot be nil.
	 * @returns The ArrayList index at which the value has been added.
	 */
	Add(Value: T): number;
	/**
	 * Creates a shallow copy of the ArrayList.
	 * @returns A shallow copy of the ArrayList.
	 */
	Clone(): ArrayList<T>;
	Clear(): void;
	Contains(Value: T): boolean;
	IndexOf(Value: T): number | undefined;
	Insert(Index: number, Value: T): void;
}

interface ArrayListConstructor {
	new <T>(): ArrayList<T>;
	FromCapacity<T>(Capacity: number): ArrayList<T>;
	FromArray<T>(Array: Array<T>): ArrayList<T>;
	MarkReadOnly<T>(List: ArrayList<T>): ArrayList<T>;
	MarkFixedSize<T>(list: ArrayList<T>): ArrayList<T>;
}

declare const ArrayList: ArrayListConstructor;
export = ArrayList;
