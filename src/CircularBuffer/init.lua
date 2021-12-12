-- This could be made a bit faster for pushing by using a LinkedList.
local Types = require(script.Parent.Types)

--[=[
	A circular buffer is a data structure that stores a fixed number of elements, removing ones when you reach the maximum capacity.
	@class CircularBuffer
]=]
local CircularBuffer = {}
CircularBuffer.ClassName = "CircularBuffer"
CircularBuffer.__index = CircularBuffer

type Array<Value> = Types.Array<Value>
type int = Types.int
type NonNil = Types.NonNil

--[=[
	@within CircularBuffer
	@prop Capacity int
	The capacity of the CircularBuffer.
]=]

--[=[
	@within CircularBuffer
	@prop Data Array<T>
	The data of the CircularBuffer.
]=]

--[=[
	Creates a new CircularBuffer.
	@param MaxCapacity int -- The maximum size of the CircularBuffer before it starts removing values.
	@return CircularBuffer<T> -- Returns a new CircularBuffer.
]=]
function CircularBuffer.new(MaxCapacity: int)
	assert(type(MaxCapacity) == "number", "MaxCapacity must be a number, instead got a " .. typeof(MaxCapacity))
	assert(MaxCapacity > 0, "MaxCapacity must be greater than 0.")

	return setmetatable({
		Capacity = MaxCapacity;
		Data = table.create(MaxCapacity);
		Index = MaxCapacity + 1;
	}, CircularBuffer)
end

function CircularBuffer.Is(Value)
	return type(Value) == "table" and getmetatable(Value) == CircularBuffer
end

--[=[
	Clears the CircularBuffer.
	@return CircularBuffer<T> -- Returns self.
]=]
function CircularBuffer:Clear()
	table.clear(self.Data)
	return self
end

--[=[
	Gets the capacity of the CircularBuffer.
	@return int -- The maximum capacity of the CircularBuffer.
]=]
function CircularBuffer:GetCapacity()
	return self.Capacity
end

--[=[
	Gets the capacity of the CircularBuffer.
	@return int -- The maximum capacity of the CircularBuffer.
]=]
function CircularBuffer:GetMaxCapacity()
	return self.Capacity
end

--[=[
	Returns whether or not the CircularBuffer is empty.
	@return boolean -- Whether or not the CircularBuffer is empty.
]=]
function CircularBuffer:IsEmpty()
	return #self.Data == 0
end

--[=[
	Returns whether or not the CircularBuffer is full.
	@return boolean -- Whether or not the CircularBuffer is full.
]=]
function CircularBuffer:IsFull()
	return #self.Data == self.Capacity
end

--[=[
	Pushes the passed data to the front of the CircularBuffer.
	@error InvalidData -- Thrown when NewData is null.
	@param NewData NonNil -- The data you are pushing.
	@return any? -- Returns the removed data, if there was any.
]=]
function CircularBuffer:Push(NewData: NonNil)
	assert(NewData ~= nil, "NewData cannot be nil.")
	local Data = self.Data
	table.insert(Data, 1, NewData)
	return table.remove(Data, self.Index)
end

--[=[
	Replaces the index in the CircularBuffer with the passed data. This function errors if there is no index to replace.
	@error InvalidData -- Thrown when NewData is null.
	@error InvalidIndex -- Thrown when Index is not a number.
	@error IndexTooLarge -- Thrown when Index is greater than the CircularBuffer's capacity.
	@param Index int -- The index you are replacing.
	@param NewData NonNil -- The data you are replacing with.
	@return any -- The replaced data.
]=]
function CircularBuffer:Replace(Index: int, NewData: NonNil)
	assert(NewData ~= nil, "NewData cannot be nil.")
	assert(type(Index) == "number", "Index must be an integer, instead got a " .. typeof(Index))
	assert(Index <= self.Capacity, "This is beyond the capacity of the CircularBuffer.")

	local OldData = self.Data[Index]
	if OldData ~= nil then
		self.Data[Index] = NewData
	else
		error(string.format("[CircularBuffer.Replace] - Data[%d] does not exist and cannot be replaced as a result.", Index), 2)
	end

	return OldData
end

--[=[
	Inserts the data at the index in the CircularBuffer.
	@error InvalidData -- Thrown when NewData is null.
	@error InvalidIndex -- Thrown when Index is not a number.
	@error IndexTooLarge -- Thrown when Index is greater than the CircularBuffer's capacity.
	@param Index int -- The index you are replacing.
	@param NewData NonNil -- The data you are replacing with.
	@return any? -- The replaced data.
]=]
function CircularBuffer:Insert(Index: int, NewData: NonNil)
	assert(NewData ~= nil, "NewData cannot be nil.")
	assert(type(Index) == "number", "Index must be an integer, instead got a " .. typeof(Index))
	assert(Index <= self.Capacity, "This is beyond the capacity of the CircularBuffer.")

	local Data = self.Data
	table.insert(Data, Index, NewData)
	return table.remove(Data, self.Index)
end

--[=[
	Returns the value at the given index.
	@error InvalidIndex -- Thrown when Index is not a number or nil.
	@param Index int? -- The index you are getting. Defaults to `1`.
	@return any? -- The value at the given index.
]=]
function CircularBuffer:PeekAt(Index: int?)
	assert(Index == nil or type(Index) == "number", "Index must be an integer?, instead got a " .. typeof(Index))
	return self.Data[if Index then Index else 1]
end

--[=[
	Returns an iterator for iterating over the CircularBuffer. Just a wrapper for `ipairs(self.Data)`.
	@return Iterator -- The ipairs iterator.
]=]
function CircularBuffer:Iterator()
	return ipairs(self.Data)
end

function CircularBuffer:__tostring()
	local Data = self.Data
	local Length = #Data
	local NewData = table.move(Data, 1, Length, 1, table.create(Length))
	for Index, Value in ipairs(NewData) do
		NewData[Index] = tostring(Value)
	end

	return string.format("CircularBuffer<[%s]>", table.concat(NewData, ", "))
end

export type CircularBuffer = typeof(CircularBuffer.new(1))
table.freeze(CircularBuffer)
return CircularBuffer
