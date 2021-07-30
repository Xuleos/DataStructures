type QueueIterator<T> = IterableFunction<LuaTuple<[number, T]>>;

interface Queue<T> {
	Push(Value: T): number;
	Pop(): T | undefined;
	Front(): T | undefined;
	IsEmpty(): boolean;
	Iterator(): QueueIterator<T>;
}

interface QueueConstructor {
	new <T>(): Queue<T>;
}

declare const Queue: QueueConstructor;
export = Queue;
