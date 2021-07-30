interface ListNode<T> {
	Previous?: ListNode<T>;
	Next?: ListNode<T>;
	List: LinkedList<T>;
	Value: T;

	After(Value: T): ListNode<T> | undefined;
	Before(Value: T): ListNode<T> | undefined;
	Destroy(): boolean;
	Iterator(): LinkedListIterator<T>;
	ReverseIterator(): LinkedListIterator<T>;
}

type LinkedListIterator<T> = IterableFunction<LuaTuple<[ListNode<T>, T]>>;

interface LinkedList<T> {
	/**
	 * Adds the element `Value` to the end of the list.
	 * This operation should compute in O(1) time and O(1) memory.
	 * @param Value The value you are appending
	 * @returns The appended node
	 */
	Push(Value: T): ListNode<T> | undefined;
	/**
	 * 	Adds the elements from `List` to the end of the list.
	 * This operation should compute in O(1) time and O(1) memory.
	 * @param List The `LinkedList` you are appending from.
	 */
	Append(List: LinkedList<T>): void;

	/**
	 * Adds the element `Value` to the start of the list.
	 * This operation should compute in O(1) time and O(1) memory.
	 * @param Value The value you are prepending.
	 * @returns The prepended node
	 */
	PushFront(Value: T): ListNode<T> | undefined;

	/**
	 * Adds the elements from `List` to the start of the list.
	 * This operation should compute in O(1) time and O(1) memory.
	 * @param List The `LinkedList` you are prepending from.
	 */
	Prepend(List: LinkedList<T>): void;

	/**
	 * Removes the first element and returns it, or `nil` if the list is empty.
	 * This operation should compute in O(1) time.
	 * @returns The popped node, if there was one..
	 */
	Pop(): ListNode<T> | undefined;

	/**
	 * Removes the last element and returns it, or `null` if the list is empty.
	 * This operation should compute in O(1) time.
	 * @returns The popped node, if there was one
	 */
	PopBack(): ListNode<T> | undefined;

	/**
	 * Returns `true` if the `LinkedList` is empty.
	 * This operation should compute in O(1) time.
	 * @returns boolean
	 */
	IsEmpty(): boolean;

	/**
	 * Removes all elements from the `LinkedList`.
	 * This operation should compute in O(n) time.
	 * @returns LinkedList
	 */
	Clear(): LinkedList<T>;

	/**
	 * Returns `true` if the `LinkedList` contains an element equal to the given value.
	 * @param Value The value you are searching for.
	 * @returns boolean
	 */
	Contains(Value: ListNode<T> | T): boolean;

	/**
	 * Provides a forward iterator.
	 * @returns LinkedListIterator
	 */
	Iterator(): LinkedListIterator<T>;

	/**
	 * Provides a reverse iterator.
	 * @returns LinkedListIterator
	 */
	ReverseIterator(): LinkedListIterator<T>;

	/**
	 * Returns an array containing all of the elements in this list in proper sequence (from first to last element).
	 * @returns An array with every element in the `LinkedList`.
	 */
	ToArray(): Array<T>;

	/**
	 * Removes the element at the given index from the `LinkedList`.
	 * This operation should compute in O(n) time.
	 * @param Index The index of the node you want to remove.
	 * @returns LinkedList
	 */
	Remove(Index: number): LinkedList<T>;

	/**
	 * Removes any element with the given value from the `LinkedList`.
	 * This operation should compute in O(n) time.
	 * @param Value The value you want to remove from the `LinkedList`.
	 * @returns LinkedList
	 */
	RemoveValue(Value: T): LinkedList<T>;

	/**
	 * Removes the given `ListNode` from the `LinkedList`.
	 * This operation should compute in O(n) time.
	 * @param Node The node you want to remove from the `LinkedList`.
	 * @returns LinkedList
	 */
	RemoveNode(Node: ListNode<T>): LinkedList<T>;
}

declare interface LinkedListConstructor {
	new <T>(Values?: Array<T>): LinkedList<T>;
}

declare const LinkedList: LinkedListConstructor;
export = LinkedList;
