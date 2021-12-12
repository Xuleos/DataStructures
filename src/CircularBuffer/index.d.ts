interface CircularBuffer<T> {
	/**
	 * The data of the Circular Buffer
	 */
	readonly Data: Array<T>;
	/**
	 * The capacity of the CircularBuffer
	 */
	readonly Capacity: number;
	/**
	 * CLears the CircularBuffer.
	 * @returns self
	 */
	Clear(): CircularBuffer<T>;
	/**
	 * Gets the capacity of the CircularBuffer.
	 * @returns The maximum capacity of the CircularBuffer.
	 */
	GetCapacity(): number;
	/**
	 * Gets the capacity of the CircularBuffer.
	 * @returns The maximum capacity of the CircularBuffer.
	 */
	GetMaxCapacity(): number;
	/**
	 * @returns whether or not the CircularBuffer is empty.
	 */
	IsEmpty(): boolean;
	/**
	 * @returns Whether or not the CircularBuffer is full
	 */
	IsFull(): boolean;
	/**
	 * Pushes the pased data to the front of the CircularBuffer.
	 * @param NewData the data you are pushing
	 * @returns the removed data, if any
	 */
	Push(NewData: T): T | undefined;
	/**
	 * Replaces the index in the CircularBuffer with the passed data. This function errors if there is no index to replace.
	 * @param Index The index you are replacing
	 * @param NewData The data you are replacing with
	 * @returns The replaced data
	 */
	Replace(Index: number, NewData: T): T;
	/**
	 * Inserts the data at the index in the CircularBuffer.
	 * @param Index The index you are replacing.
	 * @param NewData The data you are replacing with.
	 * @returns The replaced data
	 */
	Insert(Index: T, NewData: T): T | undefined;
	/**
	 * @param Index The index you are getting. Defaults to `1`
	 * @returns The value at the given index.
	 */
	PeekAt(Index: T | undefined): T | undefined;
	/**
	 * Returns an iterator for iterating over the CircularBuffer
	 * @returns the ipairs iterator
	 */
	Iterator(): IterableFunction<LuaTuple<[number, T]>>;
}

interface CircularBufferConstructor {
	new <T>(MaxCapacity: number): CircularBuffer<T>;
}

declare const CircularBuffer: CircularBufferConstructor;
export = CircularBuffer;
