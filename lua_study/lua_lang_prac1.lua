#!/usr/bin/env lua
--[[
================================================================================
임베디드 엔지니어를 위한 Lua 마스터 가이드 - 20단계 실습
================================================================================
실행 방법:
  lua lua_practice.lua

또는 실행 권한 부여 후:
  chmod +x lua_practice.lua
  ./lua_practice.lua
================================================================================
]]

print("=== Lua 마스터 가이드 20단계 실습 시작 ===\n")

-- 유틸리티: 섹션 구분선 출력
local function print_section(number, title)
    print(string.format("\n%s", string.rep("=", 80)))
    print(string.format("단계 %d: %s", number, title))
    print(string.rep("=", 80))
end

--------------------------------------------------------------------------------
-- Phase 1: 문법의 이질감 극복 (Syntax & Types)
--------------------------------------------------------------------------------

--[[
단계 1: Hello & Comments
문제: print 함수를 사용하고, 주석(--,--[[ ]])을 다는 스크립트를 작성하세요.
]]
print_section(1, "Hello & Comments")

function step1_hello_and_comments()
    -- 한 줄 주석입니다
    print("Hello, Lua!")
    
    --[[
        여러 줄 주석입니다.
        Lua에서는 --[[ ]]로 여러 줄을 주석 처리할 수 있습니다.
    ]]
    
    print("주석 테스트 완료")
end

-- 테스트 실행
step1_hello_and_comments()


--[[
단계 2: Variables & Scope
문제: 전역 변수와 local 변수를 선언하고, 블록(do...end) 밖에서 접근했을 때의 차이를 확인하세요.
주의: Lua는 기본이 전역입니다. local 사용 습관이 중요합니다.
]]
print_section(2, "Variables & Scope")

function step2_variables_and_scope()
    global_var = "나는 전역 변수"  -- local 키워드 없음 = 전역
    
    do
        local local_var = "나는 지역 변수"
        local_in_block = "블록 안의 지역 변수"
        print("블록 내부:", local_var)
        print("블록 내부:", global_var)
    end
    
    print("블록 외부 - 전역 변수:", global_var)
    print("블록 외부 - 지역 변수:", local_in_block)  -- nil (접근 불가)
    
    -- 베스트 프랙티스: 항상 local을 사용하세요
    local best_practice = "메모리 효율적이고 충돌 방지"
    print("권장 사항:", best_practice)
end

step2_variables_and_scope()


--[[
단계 3: Types & Nil
문제: 변수에 nil을 할당하여 삭제하는 개념을 익히고, type() 함수로 8가지 기본 타입을 확인하세요.
8가지 타입: nil, boolean, number, string, function, userdata, thread, table
]]
print_section(3, "Types & Nil")

function step3_types_and_nil()
    local examples = {
        ["nil"] = nil,
        ["boolean"] = true,
        ["number"] = 42,
        ["string"] = "Hello",
        ["function"] = function() end,
        ["table"] = {},
        ["thread"] = coroutine.create(function() end),
        -- userdata는 C API에서만 생성 가능
    }
    
    print("Lua의 8가지 기본 타입:")
    for name, value in pairs(examples) do
        print(string.format("  %s: %s", name, type(value)))
    end
    
    -- nil로 변수 삭제
    local temp = "존재하는 값"
    print("\n삭제 전:", temp, type(temp))
    temp = nil
    print("삭제 후:", temp, type(temp))
end

step3_types_and_nil()


--[[
단계 4: Conditionals
문제: if, elseif, else를 사용하여 짝수/홀수 판별기를 만드세요.
주의: Lua에서는 0이 true로 취급됩니다. 이를 검증하는 코드를 작성하세요.
]]
print_section(4, "Conditionals")

function step4_conditionals(n)
    if n % 2 == 0 then
        print(n .. "은(는) 짝수입니다")
    else
        print(n .. "은(는) 홀수입니다")
    end
end

function step4_zero_truthiness_test()
    print("\nLua의 진리값 테스트 (0은 true입니다!):")
    
    if 0 then
        print("  0은 true로 평가됩니다!")
    end
    
    if false then
        print("  이 코드는 실행되지 않습니다")
    elseif nil then
        print("  이 코드도 실행되지 않습니다")
    else
        print("  false와 nil만 거짓입니다")
    end
end

-- 테스트
step4_conditionals(10)
step4_conditionals(7)
step4_zero_truthiness_test()


--[[
단계 5: Loops
문제: while, repeat...until, numeric for 문을 사용하여 1부터 10까지 출력하세요.
]]
print_section(5, "Loops")

function step5_loops()
    print("while 루프:")
    local i = 1
    while i <= 10 do
        io.write(i .. " ")
        i = i + 1
    end
    print()
    
    print("\nrepeat...until 루프:")
    local j = 1
    repeat
        io.write(j .. " ")
        j = j + 1
    until j > 10
    print()
    
    print("\nnumeric for 루프:")
    for k = 1, 10 do
        io.write(k .. " ")
    end
    print()
    
    print("\nfor 루프 (step 2):")
    for m = 1, 10, 2 do
        io.write(m .. " ")
    end
    print()
end

step5_loops()


--------------------------------------------------------------------------------
-- Phase 2: 테이블 마스터 (Data Structures)
--------------------------------------------------------------------------------

--[[
단계 6: Array
문제: 테이블을 배열처럼 사용해보세요.
중요: 인덱스가 1부터 시작함을 확인하세요.
]]
print_section(6, "Array")

function step6_array()
    local arr = {"a", "b", "c", "d", "e"}
    
    print("배열 요소:")
    for i = 1, #arr do
        print(string.format("  arr[%d] = %s", i, arr[i]))
    end
    
    print("\n중요: Lua는 1-based indexing!")
    print("  첫 번째 요소: arr[1] =", arr[1])
    print("  arr[0] =", arr[0], "(nil)")
    
    -- 배열 조작
    table.insert(arr, "f")  -- 끝에 추가
    table.insert(arr, 2, "inserted")  -- 2번 위치에 삽입
    print("\n삽입 후:", table.concat(arr, ", "))
    
    table.remove(arr, 2)  -- 2번 인덱스 제거
    print("제거 후:", table.concat(arr, ", "))
end

step6_array()


--[[
단계 7: Dictionary
문제: 테이블을 해시맵처럼 사용해보세요.
t.key와 t["key"]가 동일함을 확인하세요.
]]
print_section(7, "Dictionary")

function step7_dictionary()
    local person = {
        name = "홍길동",
        age = 30,
        job = "임베디드 엔지니어"
    }
    
    print("Dictionary 접근 방법:")
    print("  person.name =", person.name)
    print("  person['name'] =", person['name'])
    print("  두 방법은 동일합니다:", person.name == person['name'])
    
    -- 동적 키 추가
    person.city = "서울"
    person["country"] = "Korea"
    
    print("\n모든 키-값 쌍:")
    for key, value in pairs(person) do
        print(string.format("  %s: %s", key, value))
    end
end

step7_dictionary()


--[[
단계 8: Iterators
문제: pairs()와 ipairs()의 차이를 보여주는 예제를 작성하세요.
배열 중간에 nil이 있을 때 ipairs가 멈추는 현상을 관찰하세요.
]]
print_section(8, "Iterators")

function step8_iterators()
    local mixed = {10, 20, 30, nil, 50, key="value"}
    
    print("ipairs() - 배열 인덱스만 순회 (nil에서 중단):")
    for i, v in ipairs(mixed) do
        print(string.format("  [%d] = %s", i, v))
    end
    
    print("\npairs() - 모든 키-값 순회:")
    for k, v in pairs(mixed) do
        print(string.format("  [%s] = %s", tostring(k), tostring(v)))
    end
    
    print("\n주의: ipairs는 nil을 만나면 중단됩니다!")
    print("  mixed[4]는 nil이므로 mixed[5]는 ipairs로 접근 불가")
end

step8_iterators()


--[[
단계 9: Functions
문제: 여러 개의 값을 반환하는 함수(return a, b)를 만들고,
이를 변수 여러 개에 할당해보세요. (Python의 튜플 언패킹과 유사)
]]
print_section(9, "Functions - Multiple Return Values")

function step9_multiple_returns(x, y)
    local sum = x + y
    local product = x * y
    local quotient = x / y
    return sum, product, quotient
end

function step9_demo()
    -- 여러 값 동시에 받기
    local s, p, q = step9_multiple_returns(10, 2)
    
    print(string.format("10과 2의 연산 결과:"))
    print(string.format("  합: %d", s))
    print(string.format("  곱: %d", p))
    print(string.format("  나눗셈: %.1f", q))
    
    -- 일부만 받기
    local only_sum = step9_multiple_returns(5, 3)
    print(string.format("\n첫 번째 반환값만: %d", only_sum))
    
    -- 함수를 테이블에 저장
    local results = {step9_multiple_returns(7, 3)}
    print("\n테이블에 저장:", table.concat(results, ", "))
end

step9_demo()


--[[
단계 10: String Manipulation
문제: string.gsub 등을 사용하여 문자열 패턴 매칭을 실습하세요.
Lua는 Regex 대신 독자적인 가벼운 패턴 문법을 사용합니다.
]]
print_section(10, "String Manipulation")

function step10_string_manipulation()
    local text = "Lua는 2024년에도 강력합니다!"
    
    -- 문자열 치환
    local replaced = string.gsub(text, "2024", "2025")
    print("치환:", replaced)
    
    -- 패턴 매칭 (숫자 찾기)
    local year = string.match(text, "%d+")
    print("추출된 연도:", year)
    
    -- 모든 숫자 찾기
    print("\n모든 숫자:")
    for num in string.gmatch("abc123def456", "%d+") do
        print("  ", num)
    end
    
    -- 문자열 분할
    local function split(str, delimiter)
        local result = {}
        for match in (str..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match)
        end
        return result
    end
    
    local parts = split("apple,banana,orange", ",")
    print("\n분할 결과:", table.concat(parts, " | "))
    
    -- Lua 패턴 문법 예제
    print("\nLua 패턴 특수 문자:")
    print("  %d = 숫자, %a = 알파벳, %s = 공백")
    print("  %w = 알파벳+숫자, . = 임의 문자")
end

step10_string_manipulation()


--------------------------------------------------------------------------------
-- Phase 3: 메타테이블과 OOP (Metatables & Objects)
--------------------------------------------------------------------------------

--[[
단계 11: Metatables Basic
문제: 두 테이블을 더하기(+) 연산자로 합칠 수 있도록 __add 메타메서드를 정의하세요.
]]
print_section(11, "Metatables Basic - Operator Overloading")

function step11_metatables_basic()
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
    local v3 = v1 + v2  -- __add 메타메서드 호출
    
    print("v1:", tostring(v1))
    print("v2:", tostring(v2))
    print("v1 + v2:", tostring(v3))
end

step11_metatables_basic()


--[[
단계 12: Prototype OOP
문제: __index 메타메서드를 사용하여, 테이블 A에 없는 키를 요청하면
테이블 B에서 찾도록 설정하세요. (상속의 기초)
]]
print_section(12, "Prototype OOP - Inheritance")

function step12_prototype_oop()
    -- 부모 테이블 (프로토타입)
    local Animal = {
        sound = "???",
        legs = 4
    }
    
    function Animal:speak()
        print(self.name .. " says " .. self.sound)
    end
    
    -- 자식 테이블 생성
    local dog = {
        name = "바둑이",
        sound = "멍멍"
    }
    
    -- 상속 설정: dog에 없는 키는 Animal에서 찾음
    setmetatable(dog, {__index = Animal})
    
    print("dog.name:", dog.name)  -- dog 자체에 있음
    print("dog.legs:", dog.legs)  -- Animal에서 상속
    dog:speak()  -- Animal의 메서드 호출
end

step12_prototype_oop()


--[[
단계 13: Class Implementation
문제: Account 클래스(테이블)를 만들고 :new() 메서드로 인스턴스를 생성하는
전형적인 Lua OOP 패턴을 구현하세요.
]]
print_section(13, "Class Implementation")

function step13_class_implementation()
    -- 클래스 정의
    local Account = {balance = 0}
    
    -- 생성자
    function Account:new(o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end
    
    -- 메서드
    function Account:deposit(amount)
        self.balance = self.balance + amount
        print(string.format("입금: %d원, 잔액: %d원", amount, self.balance))
    end
    
    function Account:withdraw(amount)
        if amount > self.balance then
            print("잔액 부족!")
            return false
        end
        self.balance = self.balance - amount
        print(string.format("출금: %d원, 잔액: %d원", amount, self.balance))
        return true
    end
    
    -- 인스턴스 생성
    local acc1 = Account:new{balance = 1000}
    local acc2 = Account:new{balance = 500}
    
    print("\n계좌 1:")
    acc1:deposit(500)
    acc1:withdraw(300)
    
    print("\n계좌 2:")
    acc2:deposit(200)
    acc2:withdraw(1000)
end

step13_class_implementation()


--[[
단계 14: Syntactic Sugar
문제: 메서드 호출 시 obj.func(obj, args)와 obj:func(args)의 차이를 이해하는
예제를 작성하세요. (Self 파라미터의 암시적 전달)
]]
print_section(14, "Syntactic Sugar - Colon Operator")

function step14_syntactic_sugar()
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
    
    local p = Person.new("철수")
    
    print("점(.) 표기법 - self를 명시적으로 전달:")
    p.greet_dot(p, "안녕하세요")
    
    print("\n콜론(:) 표기법 - self를 암시적으로 전달:")
    p:greet_colon("안녕하세요")
    
    print("\n둘은 동일합니다:")
    print("  obj:method(args) == obj.method(obj, args)")
end

step14_syntactic_sugar()


--[[
단계 15: Modules
문제: require를 사용하여 다른 파일에 있는 테이블(함수 모음)을 불러오는
모듈 시스템을 실습하세요.
]]
print_section(15, "Modules")

function step15_modules()
    -- 모듈 정의 (일반적으로 별도 파일에 작성)
    local mymath = {}
    
    function mymath.add(a, b)
        return a + b
    end
    
    function mymath.multiply(a, b)
        return a * b
    end
    
    mymath.PI = 3.14159
    
    -- 모듈 사용
    print("mymath.add(5, 3):", mymath.add(5, 3))
    print("mymath.multiply(4, 7):", mymath.multiply(4, 7))
    print("mymath.PI:", mymath.PI)
    
    print("\n실제 프로젝트에서는:")
    print("  1. mymath.lua 파일 생성 (return mymath)")
    print("  2. local mymath = require('mymath')")
    print("  3. mymath.add(1, 2) 사용")
end

step15_modules()


--------------------------------------------------------------------------------
-- Phase 4: 고급 기능 및 연동 (Advanced & Embedding)
--------------------------------------------------------------------------------

--[[
단계 16: Coroutines
문제: coroutine.create, yield, resume을 사용하여
협력적 멀티태스킹(Cooperative Multitasking)을 구현하세요. (OS 스레드가 아님)
]]
print_section(16, "Coroutines - Cooperative Multitasking")

function step16_coroutines()
    -- 코루틴 생성
    local co = coroutine.create(function()
        for i = 1, 5 do
            print("  코루틴 실행:", i)
            coroutine.yield()  -- 제어권 반환
        end
    end)
    
    print("코루틴 상태:", coroutine.status(co))
    
    print("\n코루틴 실행 (3번):")
    for i = 1, 3 do
        print("메인 -> 코루틴 resume", i)
        coroutine.resume(co)
    end
    
    print("\n코루틴 상태:", coroutine.status(co))
    
    -- 값 전달 예제
    print("\n\n값 전달 예제:")
    local producer = coroutine.create(function()
        for i = 1, 3 do
            print("  생산:", i)
            coroutine.yield(i * 10)
        end
    end)
    
    while coroutine.status(producer) ~= "dead" do
        local ok, value = coroutine.resume(producer)
        if value then
            print("소비:", value)
        end
    end
end

step16_coroutines()


--[[
단계 17: Error Handling
문제: pcall (protected call)을 사용하여 에러 발생 시 프로그램이 죽지 않고
에러 메시지를 잡는 코드를 작성하세요. (Python의 try-except 유사)
]]
print_section(17, "Error Handling - pcall")

function step17_error_handling()
    local function risky_operation(x)
        if x == 0 then
            error("0으로 나눌 수 없습니다!")
        end
        return 100 / x
    end
    
    -- pcall 없이 (위험)
    print("pcall 없이 호출:")
    -- risky_operation(0)  -- 이 줄은 프로그램을 중단시킵니다
    
    -- pcall 사용 (안전)
    print("\npcall 사용:")
    local ok, result = pcall(risky_operation, 0)
    
    if ok then
        print("성공:", result)
    else
        print("에러 발생:", result)
    end
    
    -- 정상 실행
    ok, result = pcall(risky_operation, 5)
    if ok then
        print("성공:", result)
    end
    
    print("\nxpcall 예제 (에러 핸들러 지정):")
    xpcall(
        function() error("커스텀 에러") end,
        function(err)
            print("  에러 핸들러 호출:", err)
            print("  스택 트레이스:", debug.traceback())
        end
    )
end

step17_error_handling()


--[[
단계 18: C API - Stack
문제: (개념 학습) Lua와 C가 데이터를 주고받을 때 사용하는
'가상 스택(Virtual Stack)'의 개념을 그림으로 그려보며 이해하세요.
]]
print_section(18, "C API - Virtual Stack (개념)")

function step18_c_api_concept()
    print([[
Lua C API의 가상 스택 개념:

C 프로그램과 Lua는 '스택'을 통해 데이터를 주고받습니다.

스택 인덱싱:
  정방향: 1, 2, 3, ... (바닥부터)
  역방향: -1, -2, -3, ... (꼭대기부터)

예제 C 코드:
  lua_pushnumber(L, 42);      // 스택에 42 push
  lua_pushstring(L, "hello"); // 스택에 "hello" push
  
  스택 상태:
    -1 (top) -> "hello"
    -2       -> 42

  double n = lua_tonumber(L, -2);  // 42 가져오기
  lua_pop(L, 2);                    // 2개 제거

주요 함수:
  - lua_push*: 스택에 값 넣기
  - lua_to*: 스택에서 값 가져오기
  - lua_pop: 스택에서 제거
  - lua_getglobal: 전역 변수를 스택에 push
  - lua_setglobal: 스택 top을 전역 변수로 설정

실습:
  1. main.c 파일 작성 (위 가이드 참조)
  2. clang -o embed main.c -llua
  3. ./embed
]])
end

step18_c_api_concept()


--[[
단계 19: C Extension
문제: C언어에서 Lua 스크립트 파일을 로드하고 실행하는 간단한 호스트 프로그램을 작성하세요.
]]
print_section(19, "C Extension (실습 가이드)")

function step19_c_extension_guide()
    print([[
C에서 Lua 임베딩하기 (MacOS):

1. config.lua 생성:
   width = 1920
   height = 1080

2. main.c 생성:
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

3. 컴파일:
   clang -o embed main.c -I/opt/homebrew/include -L/opt/homebrew/lib -llua

4. 실행:
   ./embed

C 함수를 Lua에 노출하기:
   int my_add(lua_State *L) {
       double a = lua_tonumber(L, 1);
       double b = lua_tonumber(L, 2);
       lua_pushnumber(L, a + b);
       return 1;  // 반환값 개수
   }
   
   lua_register(L, "my_add", my_add);
]])
end

step19_c_extension_guide()


--[[
단계 20: Python Binding
문제: Python lupa 라이브러리를 사용해 Python 내에서 Lua 코드를 실행하세요.
]]
print_section(20, "Python Binding (실습 가이드)")

function step20_python_binding_guide()
    print([[
Python에서 Lua 사용하기:

1. 설치:
   pip install lupa

2. Python 코드 작성 (test_lua.py):
   from lupa import LuaRuntime
   
   lua = LuaRuntime(unpack_returned_tuples=True)
   
   # Lua 함수 정의
   lua_code = """
   function add(a, b)
       return a + b
   end
   """
   
   lua.execute(lua_code)
   
   # Python에서 Lua 함수 호출
   add_func = lua.globals().add
   result = add_func(10, 20)
   print(f"Result: {result}")
   
   # Python dict를 Lua table로 전달
   process = lua.eval("""
       function(data)
           return data['x'] + data['y']
       end
   """)
   
   print(process({'x': 5, 'y': 3}))

3. 실행:
   python test_lua.py

장점:
  - Python의 생태계 + Lua의 성능
  - 게임 스크립팅, 설정 파일 처리에 유용
  - LuaJIT 사용 시 매우 빠름
]])

    -- Lua에서 파이썬 바인딩을 시뮬레이션
    print("\n\nLua 측 예제 (Python에서 호출될 함수):")
    
    function calculate_stats(data)
        local sum = 0
        local count = 0
        for _, v in ipairs(data) do
            sum = sum + v
            count = count + 1
        end
        return sum / count, sum, count
    end
    
    -- 테스트 데이터
    local test_data = {10, 20, 30, 40, 50}
    local avg, total, cnt = calculate_stats(test_data)
    
    print(string.format("평균: %.2f, 합계: %d, 개수: %d", avg, total, cnt))
end

step20_python_binding_guide()


--------------------------------------------------------------------------------
-- 종합 정리
--------------------------------------------------------------------------------

print("\n\n" .. string.rep("=", 80))
print("축하합니다! Lua 20단계 실습을 완료했습니다!")
print(string.rep("=", 80))

print([[

학습한 내용 요약:

Phase 1: 문법의 이질감 극복
  ✓ 주석, 변수 스코프, 타입 시스템
  ✓ 조건문, 반복문
  ✓ 0이 true인 진리값 체계

Phase 2: 테이블 마스터
  ✓ 배열 (1-based indexing!)
  ✓ 딕셔너리
  ✓ pairs vs ipairs
  ✓ 다중 반환값, 문자열 처리

Phase 3: 메타테이블과 OOP
  ✓ 연산자 오버로딩 (__add, __tostring)
  ✓ 프로토타입 상속 (__index)
  ✓ 클래스 패턴 구현
  ✓ 콜론(:) 문법
  ✓ 모듈 시스템

Phase 4: 고급 기능
  ✓ 코루틴 (협력적 멀티태스킹)
  ✓ 에러 처리 (pcall/xpcall)
  ✓ C API 개념 (가상 스택)
  ✓ C 연동 가이드
  ✓ Python 바인딩

다음 단계:
  1. 실제 C 프로젝트에 Lua 임베딩 해보기
  2. LuaJIT으로 성능 최적화
  3. 게임 엔진이나 IoT 프로젝트에 적용
  4. Sol2, LuaBridge 같은 모던 바인딩 라이브러리 탐구

Happy Coding! 🌙
]])