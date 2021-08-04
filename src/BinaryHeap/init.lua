local Types = require(script.Parent.Types)
local _ = Types

local BinaryHeap = {}
BinaryHeap.ClassName = "BinaryHeap"
BinaryHeap.__index = BinaryHeap

type Array<Value> = Types.Array<Value>
type Comparable = Types.Comparable
type ComparisonFunction<T> = Types.ComparisonFunction<T>
type int = Types.int
type NonNil = Types.NonNil

function BinaryHeap.new(ComparisonFunction: ComparisonFunction<Comparable>?)
	return setmetatable({
		ComparisonFunction = ComparisonFunction,
		Length = 0,
	}, BinaryHeap)
end

export type BinaryHeap = typeof(BinaryHeap.new())

function BinaryHeap.FromArray(Array: Array<any>): BinaryHeap
	Array.Length = #Array
	return setmetatable(Array, BinaryHeap)
end

function BinaryHeap.Is(Value)
	return type(Value) == "table" and getmetatable(Value) == BinaryHeap
end

function BinaryHeap:Heapify(Index)
	local Key = self[Index]
	local Length = self.Length
	local ComparisonFunction = self.ComparisonFunction

	local Smallest = Index + Index
	while Smallest <= Length do
		local Value0 = self[Smallest]
		local Index1 = Smallest + 1
		local Value1 = self[Index1]

		if
			Value1
			and (
				ComparisonFunction
				and ComparisonFunction(Value1, Value0)
				or not ComparisonFunction
				and Value1 < Value0
			)
		then
			Value0 = Value1
			Smallest = Index1
		end

		if ComparisonFunction and ComparisonFunction(Value0, Key) or not ComparisonFunction and Value0 < Key then
			self[Index] = Value0
			Index = Smallest
			Smallest = Index + Index
		else
			self[Index] = Key
			return
		end
	end

	self[Index] = Key
end

--[[**
	Pushes a new key to the heap.
	@param [t:Comparable] Key The key you are pushing. Must be able to work with comparing methods like `<`.
	@returns [t:int] The index of the pushed key in the heap.
**--]]
function BinaryHeap:Push(Key)
	local Length = self.Length + 1
	self.Length = Length
	local ComparisonFunction = self.ComparisonFunction

	local Index = math.floor(Length / 2)
	local Value = self[Index]

	while
		Value
		and (ComparisonFunction and ComparisonFunction(Key, Value) or not ComparisonFunction and Key < Value)
do
		self[Length] = Value
		Length = Index
		Index = math.floor(Length / 2)
		Value = self[Index]
	end

	self[Length] = Key
	return Length
end

function BinaryHeap:Set(Index, Key)
	local ComparisonFunction = self.ComparisonFunction
	if
		ComparisonFunction
		and ComparisonFunction(Key, self[Index])
		or not ComparisonFunction
		and Key < self[Index]
	then
		local Middle = math.floor(Index / 2)
		local Value = self[Middle]

		while
			Value
			and (
				ComparisonFunction
				and ComparisonFunction(Key, Value)
				or not ComparisonFunction
				and Key < Value
			)
do
			self[Index] = Value
			Index = Middle
			Middle = math.floor(Index / 2)
			Value = self[Middle]
		end

		self[Index] = Key
		return Index
	else
		local Length = self.Length

		local Smallest = Index + Index
		while Smallest <= Length do
			local Value0 = self[Smallest]
			local Index1 = Smallest + 1
			local Value1 = self[Index1]

			if
				Value1
				and (
					ComparisonFunction
					and ComparisonFunction(Value1, Value0)
					or not ComparisonFunction
					and Value1 < Value0
				)
			then
				Value0 = Value1
				Smallest = Index1
			end

			if ComparisonFunction and ComparisonFunction(Value0, Key) or not ComparisonFunction and Value0 < Key then
				self[Index] = Value0
				Index = Smallest
				Smallest = Index + Index
			else
				break
			end
		end

		self[Index] = Key
		return Index
	end
end

--[[**
	Removes the minimum element (the root) from the heap and returns it.
	@returns [t:Comparable?] The minimum element if it exists, otherwise nil.
**--]]
function BinaryHeap:Pop(): Comparable?
	local Length = self.Length

	if Length == 0 then
		return nil
	elseif Length == 1 then
		local RootElement = self[1]
		self[1] = nil
		self.Length = 0
		return RootElement
	end

	local RootElement = self[1]
	local Key = self[Length]
	self[Length] = nil

	Length -= 1
	self.Length = Length
	local ComparisonFunction = self.ComparisonFunction

	local Index = 1
	local Smallest = Index + Index
	while Smallest <= Length do
		local Value0 = self[Smallest]
		local Index1 = Smallest + 1
		local Value1 = self[Index1]

		if
			Value1
			and (
				ComparisonFunction
				and ComparisonFunction(Value1, Value0)
				or not ComparisonFunction
				and Value1 < Value0
			)
		then
			Value0 = Value1
			Smallest = Index1
		end

		if ComparisonFunction and ComparisonFunction(Value0, Key) or not ComparisonFunction and Value0 < Key then
			self[Index] = Value0
			Index = Smallest
			Smallest = Index + Index
		else
			self[Index] = Key
			return RootElement
		end
	end

	self[Index] = Key
	return RootElement
end

--[[**
	Deletes the key at Index by shifting it to root (treating it as -infinity) and then popping it.
	@param [t:int] Index The index of the key you want to delete.
	@returns [t:BinaryHeap] Returns the same heap.
**--]]
function BinaryHeap:Delete(Index: int): BinaryHeap
	local Length = self.Length
	if Length == 1 then
		self[1] = nil
		self.Length = 0
		return self
	end

	while Index > 1 do
		local Middle = math.floor(Index / 2)
		self[Index] = self[Middle]
		Index = Middle
	end

	local Key = self[Length]
	self[Length] = nil

	Length -= 1
	self.Length = Length
	local ComparisonFunction = self.ComparisonFunction

	local Smallest = Index + Index
	while Smallest <= Length do
		local Value0 = self[Smallest]
		local Index1 = Smallest + 1
		local Value1 = self[Index1]

		if
			Value1
			and (
				ComparisonFunction
				and ComparisonFunction(Value1, Value0)
				or not ComparisonFunction
				and Value1 < Value0
			)
		then
			Value0 = Value1
			Smallest = Index1
		end

		if ComparisonFunction and ComparisonFunction(Value0, Key) or not ComparisonFunction and Value0 < Key then
			self[Index] = Value0
			Index = Smallest
			Smallest = Index + Index
		else
			self[Index] = Key
			return self
		end
	end

	self[Index] = Key
	return self
end

--[[**
	Returns the front value of the heap.
	@returns [t:any] The first value.
**--]]
function BinaryHeap:GetFront(): any
	return self[1]
end

BinaryHeap.Front = BinaryHeap.GetFront

--[[**
	Determines if the heap is empty.
	@returns [t:boolean] True iff the heap is empty.
**--]]
function BinaryHeap:IsEmpty(): boolean
	return self[1] == nil
end

function BinaryHeap:__tostring()
	return "BinaryHeap"
end

return BinaryHeap
