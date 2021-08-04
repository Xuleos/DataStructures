interface BinaryHeap<T> {
	Heapify(Index: number): void;
	/**
	 * Pushes a new key to the heap
	 * @param Key The key you are pushing. Must be able to work with comparing methods like `<`.
	 * @returns The index of the pushed key in the heap.
	 */
	Push(Key: T): number;
	Set(Index: number, Key: T): number;
	/**
	 * Removes the minimum element (the root) from the heap and returns it.
	 * @returns The minimum element if it exists, otherwise undefined.
	 */
	Pop(): T;
	/**
	 * Deletes the key at Index by shifting it to root (treating it as -infinity) and then popping it.
	 * @param Index The index of the key you want to delete.
	 * @returns the same heap
	 */
	Delete(Index: number): BinaryHeap<T>;
	/**
	 * Returns the front value of the heap
	 * @returns The first value.
	 */
	GetFront(): T;
	/**
	 * Determines if the heap is empty.
	 * @returns True if the heap is empty.
	 */
	IsEmpty(): boolean;
}

interface BinaryHeapConstructor {
	new <T>(ComparisonFunction: (a: T, b: T) => boolean): BinaryHeap<T>;
	FromArray<T>(Array: Array<T>): BinaryHeap<T>;
}

declare const BinaryHeap: BinaryHeapConstructor;
export = BinaryHeap;
