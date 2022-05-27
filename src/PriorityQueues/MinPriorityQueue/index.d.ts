interface HeapEntry<T> {
	Priority: number;
	Value: T;
}

interface MinPriorityQueue<T> {
	IsEmpty(): boolean;
	InsertWithPriority(Value: T, Priority: number): number;
	ChangePriority(Value: T, Priority: number): number;
	GetFirstPriority(): number;
	GetLastPriority(): number;
	PopElement(OnlyValue?: boolean): HeapEntry<T> | undefined;
	ToArray(OnlyValues?: boolean): Array<HeapEntry<T>>;
	Iterate(OnlyValues?: boolean): IterableFunction<LuaTuple<[number, HeapEntry<T>]>>;
	ReverseIterate(OnlyValues?: boolean): IterableFunction<LuaTuple<[number, HeapEntry<T>]>>;
	Clear(): MinPriorityQueue<T>;
	Contains(Value: T): boolean;
	RemovePriority(Priority: number): void;
	RemoveValue(Value: T): void;

	/** @hidden */
	Heap: Array<HeapEntry<T>>;
	Length: number;
}

interface MinPriorityQueueConstructor {
	new <T>(): MinPriorityQueue<T>;
}

declare const MinPriorityQueue: MinPriorityQueueConstructor;
export = MinPriorityQueue;
