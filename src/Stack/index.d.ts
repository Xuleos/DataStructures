interface Stack<T> {
	Length: number;
	Push(Value: T): number;
	Pop(): T | undefined;
	Top(): T | undefined;
	IsEmpty(): boolean;
}

interface StackConstructor {
	new <T>(): Stack<T>;
}

declare const Stack: StackConstructor;
export = Stack;
