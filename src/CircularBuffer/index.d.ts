interface CircularBuffer<T> {
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
	 * @param newData the data you are pushing
	 * @returns the removed data, if any
	 */
	Push(newData: T): T | undefined;
	/**
	 * Replaces the index in the CircularBuffer with the passed data. This function errors if there is no index to replace.
	 * @param index The index you are replacing
	 * @param newData The data you are replacing with
	 * @returns The replaced data
	 */
	Replace(index: number, newData: T): T;
	/**
	 * Inserts the data at the index in the CircularBuffer.
	 * @param index The index you are replacing.
	 * @param newData The data you are replacing with.
	 * @returns The replaced data
	 */
	Insert(index: T, newData: T): T | undefined;
	/**
	 * @param index The index you are getting. Defaults to `1`
	 * @returns The value at the given index.
	 */
	PeekAt(index: T | undefined): T | undefined;
	/**
	 * Returns an iterator for iterating over the CircularBuffer
	 * @returns the ipairs iterator
	 */
	Iterator(): IterableFunction<LuaTuple<[number, T]>>;
}

interface CircularBufferConstructor {
	new <T>(maxCapacity: number): CircularBuffer<T>;
}

declare const CircularBuffer: CircularBufferConstructor;
export = CircularBuffer;
