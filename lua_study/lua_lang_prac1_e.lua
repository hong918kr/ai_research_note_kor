#!/usr/bin/env lua
--[[
================================================================================
Lua Mastery Guide for Embedded Engineers - 20-Step Practice
================================================================================
How to run:
  lua lua_lang_prac1_e_new.lua

Or after granting execution permission:
  chmod +x lua_lang_prac1_e_new.lua
  ./lua_lang_prac1_e_new.lua
================================================================================
]]

print("=== Lua Mastery Guide 20-Step Practice Start ===\n")

-- Utility: Print section divider
local function print_section(number, title)
    print(string.format("\n%s", string.rep("=", 80)))
    print(string.format("Step %d: %s", number, title))
    print(string.rep("=", 80))
end

--------------------------------------------------------------------------------
-- Phase 1: Overcoming Syntax Differences (Syntax & Types)
--------------------------------------------------------------------------------

--[[
Step 1: Hello & Comments
Problem: Use the print function and write comments (single line: --, multi-line: --[=[ ]=])
]]

print_section(1, "Hello & Comments")

local function step1_hello_and_comments()
    -- This is a single-line comment
    print("Hello, Lua!")
    
    --[[
        This is a multi-line comment.
        In Lua, you can comment multiple lines like this.
    ]]
    
    print("Comment test completed")
end

-- Run test
step1_hello_and_comments()


--[[
Step 2: Variables & Scope
Problem: Declare global and local variables, and observe the difference 
when accessing them outside of blocks (do...end).
Note: Lua defaults to global. Using 'local' is an important habit.
]]
print_section(2, "Variables & Scope")

local function step2_variables_and_scope()
    global_var = "I am a global variable"  -- No local keyword = global
    
    do
        local local_var = "I am a local variable"
        local_in_block = "Local variable inside block"
        print("Inside block:", local_var)
        print("Inside block:", global_var)
    end
    
    print("Outside block - global variable:", global_var)
    print("Outside block - local variable:", local_in_block)  -- nil (inaccessible)
    
    -- Best practice: Always use local
    local best_practice = "Memory efficient and prevents conflicts"
    print("Best practice:", best_practice)
end

step2_variables_and_scope()


--[[
Step 3: Types & Nil
Problem: Learn the concept of deleting variables by assigning nil, 
and verify the 8 basic types using type() function.
8 types: nil, boolean, number, string, function, userdata, thread, table
]]
print_section(3, "Types & Nil")

local function step3_types_and_nil()
    local examples = {
        ["nil"] = nil,
        ["boolean"] = true,
        ["number"] = 42,
        ["string"] = "Hello",
        ["function"] = function() end,
        ["table"] = {},
        ["thread"] = coroutine.create(function() end),
        -- userdata can only be created via C API
    }
    
    print("Lua's 8 basic types:")
    for name, value in pairs(examples) do
        print(string.format("  %s: %s", name, type(value)))
    end
    
    -- Delete variable with nil
    local temp = "Existing value"
    print("\nBefore deletion:", temp, type(temp))
    temp = nil
    print("After deletion:", temp, type(temp))
end

step3_types_and_nil()


--[[
Step 4: Conditionals
Problem: Create an even/odd checker using if, elseif, else.
Note: In Lua, 0 is treated as true. Write code to verify this.
]]
print_section(4, "Conditionals")

local function step4_conditionals(n)
    if n % 2 == 0 then
        print(n .. " is even")
    else
        print(n .. " is odd")
    end
end

local function step4_zero_truthiness_test()
    print("\nLua truthiness test (0 is true!):")
    
    if 0 then
        print("  0 evaluates to true!")
    end
    
    if false then
        print("  This code won't execute")
    elseif nil then
        print("  This code won't execute either")
    else
        print("  Only false and nil are falsy")
    end
end

-- Test
step4_conditionals(10)
step4_conditionals(7)
step4_zero_truthiness_test()


--[[
Step 5: Loops
Problem: Print numbers from 1 to 10 using while, repeat...until, and numeric for loops.
]]
print_section(5, "Loops")

local function step5_loops()
    print("while loop:")
    local i = 1
    while i <= 10 do
        io.write(i .. " ")
        i = i + 1
    end
    print()
    
    print("\nrepeat...until loop:")
    local j = 1
    repeat
        io.write(j .. " ")
        j = j + 1
    until j > 10
    print()
    
    print("\nnumeric for loop:")
    for k = 1, 10 do
        io.write(k .. " ")
    end
    print()
    
    print("\nfor loop (step 2):")
    for m = 1, 10, 2 do
        io.write(m .. " ")
    end
    print()
end

step5_loops()


--------------------------------------------------------------------------------
-- Phase 2: Table Mastery (Data Structures)
--------------------------------------------------------------------------------

--[[
Step 6: Array
Problem: Use tables as arrays.
Important: Verify that indexing starts from 1.
]]
print_section(6, "Array")

local function step6_array()
    local arr = {"a", "b", "c", "d", "e"}
    
    print("Array elements:")
    for i = 1, #arr do
        print(string.format("  arr[%d] = %s", i, arr[i]))
    end
    
    print("\nImportant: Lua uses 1-based indexing!")
    print("  First element: arr[1] =", arr[1])
    print("  arr[0] =", arr[0], "(nil)")
    
    -- Array manipulation
    table.insert(arr, "f")  -- Append to end
    table.insert(arr, 2, "inserted")  -- Insert at position 2
    print("\nAfter insertion:", table.concat(arr, ", "))
    
    table.remove(arr, 2)  -- Remove index 2
    print("After removal:", table.concat(arr, ", "))
end

step6_array()


--[[
Step 7: Dictionary
Problem: Use tables as hashmaps.
Verify that t.key and t["key"] are identical.
]]
print_section(7, "Dictionary")

local function step7_dictionary()
    local person = {
        name = "John Doe",
        age = 30,
        job = "Embedded Engineer"
    }
    
    print("Dictionary access methods:")
    print("  person.name =", person.name)
    print("  person['name'] =", person['name'])
    print("  Both methods are identical:", person.name == person['name'])
    
    -- Dynamic key addition
    person.city = "Seoul"
    person["country"] = "Korea"
    
    print("\nAll key-value pairs:")
    for key, value in pairs(person) do
        print(string.format("  %s: %s", key, value))
    end
end

step7_dictionary()


--[[
Step 8: Iterators
Problem: Create an example showing the difference between pairs() and ipairs().
Observe how ipairs stops when encountering nil in the middle of an array.
]]
print_section(8, "Iterators")

local function step8_iterators()
    local mixed = {10, 20, 30, nil, 50, key="value"}
    
    print("ipairs() - Iterates array indices only (stops at nil):")
    for i, v in ipairs(mixed) do
        print(string.format("  [%d] = %s", i, v))
    end
    
    print("\npairs() - Iterates all key-value pairs:")
    for k, v in pairs(mixed) do
        print(string.format("  [%s] = %s", tostring(k), tostring(v)))
    end
    
    print("\nNote: ipairs stops when it encounters nil!")
    print("  mixed[4] is nil, so mixed[5] is inaccessible via ipairs")
end

step8_iterators()


--[[
Step 9: Functions
Problem: Create a function that returns multiple values (return a, b),
and assign them to multiple variables. (Similar to Python's tuple unpacking)
]]
print_section(9, "Functions - Multiple Return Values")

local function step9_multiple_returns(x, y)
    local sum = x + y
    local product = x * y
    local quotient = x / y
    return sum, product, quotient
end

local function step9_demo()
    -- Receive multiple values simultaneously
    local s, p, q = step9_multiple_returns(10, 2)
    
    print(string.format("Operation results for 10 and 2:"))
    print(string.format("  Sum: %d", s))
    print(string.format("  Product: %d", p))
    print(string.format("  Quotient: %.1f", q))
    
    -- Receive only partial values
    local only_sum = step9_multiple_returns(5, 3)
    print(string.format("\nFirst return value only: %d", only_sum))
    
    -- Store function results in table
    local results = {step9_multiple_returns(7, 3)}
    print("\nStored in table:", table.concat(results, ", "))
end

step9_demo()


--[[
Step 10: String Manipulation
Problem: Practice string pattern matching using string.gsub, etc.
Lua uses its own lightweight pattern syntax instead of Regex.
]]
print_section(10, "String Manipulation")

local function step10_string_manipulation()
    local text = "Lua is powerful even in 2024!"
    
    -- String replacement
    local replaced = string.gsub(text, "2024", "2025")
    print("Replaced:", replaced)
    
    -- Pattern matching (find numbers)
    local year = string.match(text, "%d+")
    print("Extracted year:", year)
    
    -- Find all numbers
    print("\nAll numbers:")
    for num in string.gmatch("abc123def456", "%d+") do
        print("  ", num)
    end
    
    -- String splitting
    local function split(str, delimiter)
        local result = {}
        for match in (str..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match)
        end
        return result
    end
    
    local parts = split("apple,banana,orange", ",")
    print("\nSplit result:", table.concat(parts, " | "))
    
    -- Lua pattern syntax examples
    print("\nLua pattern special characters:")
    print("  %d = digit, %a = letter, %s = whitespace")
    print("  %w = alphanumeric, . = any character")
end

step10_string_manipulation()


--------------------------------------------------------------------------------
-- Phase 3: Metatables and OOP (Metatables & Objects)
--------------------------------------------------------------------------------

--[[
Step 11: Metatables Basic
Problem: Define the __add metamethod to allow combining two tables with the (+) operator.
]]
print_section(11, "Metatables Basic - Operator Overloading")

local function step11_metatables_basic()
    local Vector = {}
    local mt = {
        __add = function(a, b)
            return {x = a.x + b.x, y = a.y + b.y}
        end,
        __tostring = function(v)
            return string.format("Vector(%d, %d)", v.x, v.y)
        end
    }
    
    function Vector.new(x, y)
        local v = {x = x, y = y}
        setmetatable(v, mt)
        return v
    end
    
    local v1 = Vector.new(3, 4)
    local v2 = Vector.new(1, 2)
    local v3 = v1 + v2  -- Calls __add metamethod
    
    print("v1:", tostring(v1))
    print("v2:", tostring(v2))
    print("v1 + v2:", tostring(v3))
end

step11_metatables_basic()


--[[
Step 12: Prototype OOP
Problem: Use the __index metamethod so that when a key is not found in table A,
it searches in table B. (Basic inheritance)
]]
print_section(12, "Prototype OOP - Inheritance")

local function step12_prototype_oop()
    -- Parent table (prototype)
    local Animal = {
        sound = "???",
        legs = 4
    }
    
    function Animal:speak()
        print(self.name .. " says " .. self.sound)
    end
    
    -- Create child table
    local dog = {
        name = "Buddy",
        sound = "Woof"
    }
    
    -- Set up inheritance: keys not in dog are searched in Animal
    setmetatable(dog, {__index = Animal})
    
    print("dog.name:", dog.name)  -- Found in dog itself
    print("dog.legs:", dog.legs)  -- Inherited from Animal
    dog:speak()  -- Calls Animal's method
end

step12_prototype_oop()


--[[
Step 13: Class Implementation
Problem: Create an Account class (table) and implement the typical Lua OOP pattern
where instances are created using the :new() method.
]]
print_section(13, "Class Implementation")

local function step13_class_implementation()
    -- Class definition
    local Account = {balance = 0}
    
    -- Constructor
    function Account:new(o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end
    
    -- Methods
    function Account:deposit(amount)
        self.balance = self.balance + amount
        print(string.format("Deposit: $%d, Balance: $%d", amount, self.balance))
    end
    
    function Account:withdraw(amount)
        if amount > self.balance then
            print("Insufficient funds!")
            return false
        end
        self.balance = self.balance - amount
        print(string.format("Withdraw: $%d, Balance: $%d", amount, self.balance))
        return true
    end
    
    -- Create instances
    local acc1 = Account:new{balance = 1000}
    local acc2 = Account:new{balance = 500}
    
    print("\nAccount 1:")
    acc1:deposit(500)
    acc1:withdraw(300)
    
    print("\nAccount 2:")
    acc2:deposit(200)
    acc2:withdraw(1000)
end

step13_class_implementation()


--[[
Step 14: Syntactic Sugar
Problem: Create an example to understand the difference between 
obj.func(obj, args) and obj:func(args) in method calls.
(Implicit passing of the Self parameter)
]]
print_section(14, "Syntactic Sugar - Colon Operator")

local function step14_syntactic_sugar()
    local Person = {}
    
    function Person.new(name)
        local self = {name = name}
        
        function self.greet_dot(self, greeting)
            print(greeting .. ", " .. self.name)
        end
        
        function self:greet_colon(greeting)
            print(greeting .. ", " .. self.name)
        end
        
        return self
    end
    
    local p = Person.new("Alice")
    
    print("Dot (.) notation - explicitly passing self:")
    p.greet_dot(p, "Hello")
    
    print("\nColon (:) notation - implicitly passing self:")
    p:greet_colon("Hello")
    
    print("\nThey are equivalent:")
    print("  obj:method(args) == obj.method(obj, args)")
end

step14_syntactic_sugar()


--[[
Step 15: Modules
Problem: Practice the module system by using require to load tables 
(collections of functions) from other files.
]]
print_section(15, "Modules")

local function step15_modules()
    -- Module definition (typically written in separate file)
    local mymath = {}
    
    function mymath.add(a, b)
        return a + b
    end
    
    function mymath.multiply(a, b)
        return a * b
    end
    
    mymath.PI = 3.14159
    
    -- Module usage
    print("mymath.add(5, 3):", mymath.add(5, 3))
    print("mymath.multiply(4, 7):", mymath.multiply(4, 7))
    print("mymath.PI:", mymath.PI)
    
    print("\nIn real projects:")
    print("  1. Create mymath.lua file (return mymath)")
    print("  2. local mymath = require('mymath')")
    print("  3. Use mymath.add(1, 2)")
end

step15_modules()


--------------------------------------------------------------------------------
-- Phase 4: Advanced Features & Integration (Advanced & Embedding)
--------------------------------------------------------------------------------

--[[
Step 16: Coroutines
Problem: Implement cooperative multitasking using coroutine.create, yield, and resume.
(Not OS threads)
]]
print_section(16, "Coroutines - Cooperative Multitasking")

local function step16_coroutines()
    -- Create coroutine
    local co = coroutine.create(function()
        for i = 1, 5 do
            print("  Coroutine executing:", i)
            coroutine.yield()  -- Return control
        end
    end)
    
    print("Coroutine status:", coroutine.status(co))
    
    print("\nExecuting coroutine (3 times):")
    for i = 1, 3 do
        print("Main -> coroutine resume", i)
        coroutine.resume(co)
    end
    
    print("\nCoroutine status:", coroutine.status(co))
    
    -- Value passing example
    print("\n\nValue passing example:")
    local producer = coroutine.create(function()
        for i = 1, 3 do
            print("  Producing:", i)
            coroutine.yield(i * 10)
        end
    end)
    
    while coroutine.status(producer) ~= "dead" do
        local ok, value = coroutine.resume(producer)
        if value then
            print("Consuming:", value)
        end
    end
end

step16_coroutines()


--[[
Step 17: Error Handling
Problem: Use pcall (protected call) to catch error messages without 
terminating the program when errors occur. (Similar to Python's try-except)
]]
print_section(17, "Error Handling - pcall")

local function step17_error_handling()
    local function risky_operation(x)
        if x == 0 then
            error("Cannot divide by zero!")
        end
        return 100 / x
    end
    
    -- Without pcall (dangerous)
    print("Calling without pcall:")
    -- risky_operation(0)  -- This line would terminate the program
    
    -- Using pcall (safe)
    print("\nUsing pcall:")
    local ok, result = pcall(risky_operation, 0)
    
    if ok then
        print("Success:", result)
    else
        print("Error occurred:", result)
    end
    
    -- Normal execution
    ok, result = pcall(risky_operation, 5)
    if ok then
        print("Success:", result)
    end
    
    print("\nxpcall example (custom error handler):")
    xpcall(
        function() error("Custom error") end,
        function(err)
            print("  Error handler called:", err)
            print("  Stack trace:", debug.traceback())
        end
    )
end

step17_error_handling()


--[[
Step 18: C API - Stack
Problem: (Conceptual learning) Understand the 'Virtual Stack' concept used 
for data exchange between Lua and C by drawing diagrams.
]]
print_section(18, "C API - Virtual Stack (Concept)")

local function step18_c_api_concept()
    print([[
Lua C API Virtual Stack Concept:

C programs and Lua exchange data through a 'stack'.

Stack indexing:
  Forward: 1, 2, 3, ... (from bottom)
  Reverse: -1, -2, -3, ... (from top)

Example C code:
  lua_pushnumber(L, 42);      // Push 42 onto stack
  lua_pushstring(L, "hello"); // Push "hello" onto stack
  
  Stack state:
    -1 (top) -> "hello"
    -2       -> 42

  double n = lua_tonumber(L, -2);  // Get 42
  lua_pop(L, 2);                    // Remove 2 items

Key functions:
  - lua_push*: Push values onto stack
  - lua_to*: Get values from stack
  - lua_pop: Remove from stack
  - lua_getglobal: Push global variable onto stack
  - lua_setglobal: Set stack top as global variable

Practice:
  1. Write main.c file (see guide above)
  2. clang -o embed main.c -llua
  3. ./embed
]])
end

step18_c_api_concept()


--[[
Step 19: C Extension
Problem: Write a simple host program in C that loads and executes a Lua script file.
]]
print_section(19, "C Extension (Practice Guide)")

local function step19_c_extension_guide()
    print([[
Embedding Lua in C (Ubuntu):

1. Create config.lua:
   width = 1920
   height = 1080

2. Create main.c:
   #include <lua.h>
   #include <lualib.h>
   #include <lauxlib.h>
   
   int main() {
       lua_State *L = luaL_newstate();
       luaL_openlibs(L);
       
       luaL_dofile(L, "config.lua");
       
       lua_getglobal(L, "width");
       int w = lua_tointeger(L, -1);
       printf("Width: %d\n", w);
       
       lua_close(L);
       return 0;
   }

3. Compile:
   gcc -o embed main.c -I/usr/include/lua5.4 -llua5.4

4. Run:
   ./embed

Exposing C functions to Lua:
   int my_add(lua_State *L) {
       double a = lua_tonumber(L, 1);
       double b = lua_tonumber(L, 2);
       lua_pushnumber(L, a + b);
       return 1;  // Number of return values
   }
   
   lua_register(L, "my_add", my_add);
]])
end

step19_c_extension_guide()


--[[
Step 20: Python Binding
Problem: Use the Python lupa library to execute Lua code within Python.
]]
print_section(20, "Python Binding (Practice Guide)")

local function step20_python_binding_guide()
    print([[
Using Lua in Python:

1. Installation:
   pip install lupa

2. Write Python code (test_lua.py):
   from lupa import LuaRuntime
   
   lua = LuaRuntime(unpack_returned_tuples=True)
   
   # Define Lua function
   lua_code = """
   function add(a, b)
       return a + b
   end
   """
   
   lua.execute(lua_code)
   
   # Call Lua function from Python
   add_func = lua.globals().add
   result = add_func(10, 20)
   print(f"Result: {result}")
   
   # Pass Python dict to Lua as table
   process = lua.eval("""
       function(data)
           return data['x'] + data['y']
       end
   """)
   
   print(process({'x': 5, 'y': 3}))

3. Run:
   python test_lua.py

Advantages:
  - Python's ecosystem + Lua's performance
  - Useful for game scripting, config file processing
  - Very fast when using LuaJIT
]])

    -- Simulate Python binding from Lua side
    print("\n\nLua side example (function to be called from Python):")
    
    local function calculate_stats(data)
        local sum = 0
        local count = 0
        for _, v in ipairs(data) do
            sum = sum + v
            count = count + 1
        end
        return sum / count, sum, count
    end
    
    -- Test data
    local test_data = {10, 20, 30, 40, 50}
    local avg, total, cnt = calculate_stats(test_data)
    
    print(string.format("Average: %.2f, Total: %d, Count: %d", avg, total, cnt))
end

step20_python_binding_guide()


--------------------------------------------------------------------------------
-- Comprehensive Summary
--------------------------------------------------------------------------------

print("\n\n" .. string.rep("=", 80))
print("Congratulations! You've completed the Lua 20-Step Practice!")
print(string.rep("=", 80))

print([[

Learning Summary:

Phase 1: Overcoming Syntax Differences
  ✓ Comments, variable scope, type system
  ✓ Conditionals, loops
  ✓ Truthiness system where 0 is true

Phase 2: Table Mastery
  ✓ Arrays (1-based indexing!)
  ✓ Dictionaries
  ✓ pairs vs ipairs
  ✓ Multiple return values, string processing

Phase 3: Metatables and OOP
  ✓ Operator overloading (__add, __tostring)
  ✓ Prototype inheritance (__index)
  ✓ Class pattern implementation
  ✓ Colon (:) syntax
  ✓ Module system

Phase 4: Advanced Features
  ✓ Coroutines (cooperative multitasking)
  ✓ Error handling (pcall/xpcall)
  ✓ C API concepts (virtual stack)
  ✓ C integration guide
  ✓ Python binding

Next Steps:
  1. Embed Lua in real C projects
  2. Performance optimization with LuaJIT
  3. Apply to game engines or IoT projects
  4. Explore modern binding libraries like Sol2, LuaBridge

Happy Coding! 🌙
]])
