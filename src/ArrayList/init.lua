local Types = require(script.Parent.Types)
local _ = Types

local ArrayList = {}
ArrayList.ClassName = "ArrayList"
ArrayList.__index = ArrayList

type Array<Value> = Types.Array<Value>
type int = Types.int
type NonNil = Types.NonNil

function ArrayList.new()
	return setmetatable({
		IsFixedSize = false,
		IsReadOnly = false,
		Length = 0,
	}, ArrayList)
end

export type ArrayList = typeof(ArrayList.new())

function ArrayList.FromCapacity(Capacity: int): ArrayList
	local self = table.create(Capacity)
	self.IsFixedSize = false
	self.IsReadOnly = false
	self.Length = 0
	return setmetatable(self, ArrayList)
end

function ArrayList.FromArray(Array: Array<any>): ArrayList
	Array.IsFixedSize = false
	Array.IsReadOnly = false
	Array.Length = #Array
	return setmetatable(Array, ArrayList)
end

ArrayList.WithCapacity = ArrayList.FromCapacity

function ArrayList.Is(Value)
	return type(Value) == "table" and getmetatable(Value) == ArrayList
end

function ArrayList.MarkReadOnly(List: ArrayList): ArrayList
	if List == nil then
		error("Argument #1 to 'ArrayList.MarkReadOnly' missing or nil", 2)
	end

	local self = List:Clone()
	self.IsReadOnly = true
	return self
end

function ArrayList.MarkFixedSize(List: ArrayList): ArrayList
	if List == nil then
		error("Argument #1 to 'ArrayList.MarkFixedSize' missing or nil", 2)
	end

	local self = List:Clone()
	self.IsFixedSize = true
	return self
end

--[[**
	Adds an object to the end of the ArrayList.
	@param [t:NonNil] Value The value to be added to the end of the ArrayList. The value cannot be nil.
	@returns [t:int] The ArrayList index at which the value has been added.
**--]]
function ArrayList:Add(Value: NonNil): int
	if self.IsFixedSize then
		error("This ArrayList has a fixed size.", 2)
	end

	if self.IsReadOnly then
		error("This ArrayList is read-only.", 2)
	end

	if Value == nil then
		error("Argument #2 to 'ArrayList:Add' missing or nil", 2)
	end

	local Length = self.Length + 1
	self.Length = Length
	self[Length] = Value
	return Length
end

--[[**
	Creates a shallow copy of the ArrayList.
	@returns [t:ArrayList] A shallow copy of the ArrayList.
**--]]
function ArrayList:Clone(): ArrayList
	local NewSelf = {
		IsFixedSize = self.IsFixedSize,
		IsReadOnly = self.IsReadOnly,
		Length = self.Length,
	}

	for Index, Value in ipairs(self) do
		NewSelf[Index] = Value
	end

	return setmetatable(NewSelf, ArrayList)
end

function ArrayList:Clear()
	if self.IsFixedSize then
		error("This ArrayList has a fixed size.", 2)
	end

	if self.IsReadOnly then
		error("This ArrayList is read-only.", 2)
	end

	table.clear(self)
	self.IsReadOnly = false
	self.Length = 0
end

function ArrayList:Contains(Value: NonNil): boolean
	if Value == nil then
		error("Argument #2 to 'ArrayList:Contains' missing or nil", 2)
	end

	return table.find(self, Value) ~= nil
end

function ArrayList:IndexOf(Value: NonNil): int?
	if Value == nil then
		error("Argument #2 to 'ArrayList:IndexOf' missing or nil", 2)
	end

	return table.find(self, Value)
end

function ArrayList:Insert(Index: int, Value: NonNil)
	if self.IsFixedSize then
		error("This ArrayList has a fixed size.", 2)
	end

	if self.IsReadOnly then
		error("This ArrayList is read-only.", 2)
	end

	if Value == nil then
		error("Argument #3 to 'ArrayList:Insert' missing or nil", 2)
	end

	if Index < 1 then
		error("Argument #2 to 'ArrayList:Insert' must be greater than zero.", 2)
	end

	if Index > self.Length + 1 then
		error(
			"Argument #2 to 'ArrayList:Insert' must be less than or equal to the length of the ArrayList.",
			2
		)
	end

	self.Length += 1
	table.insert(self, Index, Value)
end

function ArrayList:__tostring()
	return "ArrayList"
end

return ArrayList
