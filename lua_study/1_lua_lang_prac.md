# 임베디드 엔지니어를 위한 Lua 마스터 가이드 (MacOS 환경)

Python과 C에 능숙한 임베디드 엔지니어에게 Lua는 'Python의 유연함'과 'C의 가벼움'을 결합한 도구입니다.  
이 가이드는 MacOS(Apple Silicon/Intel) 환경을 기준으로 작성되었으며, 언어의 기초부터 C/C++ 및 Python 연동까지 난이도가 점진적으로 상승하는 20단계의 실습 커리큘럼을 제공합니다.

---

## 1. Lua 학습 로드맵: 20단계 연습문제

이 연습문제들은 단순히 문법을 익히는 것을 넘어, Lua의 내부 동작 원리(Stack, Table, Coroutine)를 이해하도록 설계되었습니다.

### Phase 1: 문법의 이질감 극복 (Syntax & Types)

Python과 비슷해 보이지만 결정적인 차이점(1-based indexing, scope)을 익힙니다.

1. **Hello & Comments**: `print` 함수를 사용하고, 주석(`--`, `--[[ ]]`)을 다는 스크립트를 작성하세요.
2. **Variables & Scope**: 전역 변수와 `local` 변수를 선언하고, 블록(`do...end`) 밖에서 접근했을 때의 차이를 확인하세요. (Lua는 기본이 전역입니다. `local` 사용 습관이 중요합니다.)
3. **Types & Nil**: 변수에 `nil`을 할당하여 삭제하는 개념을 익히고, `type()` 함수로 8가지 기본 타입(`nil`, `boolean`, `number`, `string`, `function`, `userdata`, `thread`, `table`)을 확인하세요.
4. **Conditionals**: `if`, `elseif`, `else`를 사용하여 짝수/홀수 판별기를 만드세요. **주의**: Lua에서는 0이 true로 취급됩니다. 이를 검증하는 코드를 작성하세요.
5. **Loops**: `while`, `repeat...until`, numeric `for` 문을 사용하여 1부터 10까지 출력하세요.

### Phase 2: 테이블 마스터 (Data Structures)

Lua의 유일한 자료구조인 Table로 모든 것(배열, 리스트, 딕셔너리)을 구현합니다.

6. **Array**: 테이블을 배열처럼 사용해보세요. `t = {"a", "b"}`. **중요**: 인덱스가 1부터 시작함을 확인(`t[1]`)하세요.
7. **Dictionary**: 테이블을 해시맵처럼 사용해보세요. `t = {key="value"}`. `t.key`와 `t["key"]`가 동일함을 확인하세요.
8. **Iterators**: `pairs()`(키-값 순회)와 `ipairs()`(배열 인덱스 순회)의 차이를 보여주는 예제를 작성하세요. 배열 중간에 `nil`이 있을 때 `ipairs`가 멈추는 현상을 관찰하세요.
9. **Functions**: 여러 개의 값을 반환하는 함수(`return a, b`)를 만들고, 이를 변수 여러 개에 할당해보세요. (Python의 튜플 언패킹과 유사)
10. **String Manipulation**: `string.gsub` 등을 사용하여 문자열 패턴 매칭을 실습하세요. (Lua는 Regex 대신 독자적인 가벼운 패턴 문법을 사용합니다.)

### Phase 3: 메타테이블과 OOP (Metatables & Objects)

C++의 연산자 오버로딩과 유사한 메타테이블을 통해 객체 지향을 구현합니다.

11. **Metatables Basic**: 두 테이블을 더하기(`+`) 연산자로 합칠 수 있도록 `__add` 메타메서드를 정의하세요.
12. **Prototype OOP**: `__index` 메타메서드를 사용하여, 테이블 A에 없는 키를 요청하면 테이블 B에서 찾도록 설정하세요. (상속의 기초)
13. **Class Implementation**: `Account` 클래스(테이블)를 만들고 `:new()` 메서드로 인스턴스를 생성하는 전형적인 Lua OOP 패턴을 구현하세요.
14. **Syntactic Sugar**: 메서드 호출 시 `obj.func(obj, args)`와 `obj:func(args)`의 차이를 이해하는 예제를 작성하세요. (Self 파라미터의 암시적 전달)
15. **Modules**: `require`를 사용하여 다른 파일에 있는 테이블(함수 모음)을 불러오는 모듈 시스템을 실습하세요.

### Phase 4: 고급 기능 및 연동 (Advanced & Embedding)

임베디드 엔지니어에게 가장 중요한 C/Python 연동 및 비동기 처리입니다.

16. **Coroutines**: `coroutine.create`, `yield`, `resume`을 사용하여 협력적 멀티태스킹(Cooperative Multitasking)을 구현하세요. (OS 스레드가 아님)
17. **Error Handling**: `pcall` (protected call)을 사용하여 에러 발생 시 프로그램이 죽지 않고 에러 메시지를 잡는 코드를 작성하세요. (Python의 try-except 유사)
18. **C API - Stack**: (개념 학습) Lua와 C가 데이터를 주고받을 때 사용하는 '가상 스택(Virtual Stack)'의 개념을 그림으로 그려보며 이해하세요.
19. **C Extension**: C언어에서 Lua 스크립트 파일을 로드하고 실행하는 간단한 호스트 프로그램을 작성하세요. (아래 섹션 참조)
20. **Python Binding**: Python `lupa` 라이브러리를 사용해 Python 내에서 Lua 코드를 실행하세요. (아래 섹션 참조)

---

## 2. C/C++ 연동 가이드 (MacOS)

Lua는 C 라이브러리 형태로 제공됩니다. MacOS에서는 brew로 설치한 라이브러리를 링크해야 합니다.

### 2.1 사전 준비

```bash
# 터미널에서 실행
brew install lua

# 설치 경로 확인 (보통 /opt/homebrew/opt/lua 또는 /usr/local/opt/lua)
brew --prefix lua
```

### 2.2 C에서 Lua 호출하기 (Embedding Example)

C 프로그램이 호스트가 되어 Lua 스크립트(`config.lua`)를 설정 파일처럼 읽어오는 예제입니다.

**config.lua**

```lua
width = 1920
height = 1080
window_title = "Embedded Lua Test"
```

**main.c**

```c
#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main() {
    // 1. Lua VM 상태 생성
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    // 2. Lua 파일 로드 및 실행
    if (luaL_dofile(L, "config.lua") != LUA_OK) {
        fprintf(stderr, "Error: %s\n", lua_tostring(L, -1));
        return 1;
    }

    // 3. 전역 변수 'width'를 스택으로 가져오기
    lua_getglobal(L, "width");
    lua_getglobal(L, "height");

    // 4. 스택의 값 읽기 (Stack Index: -2=width, -1=height)
    if (lua_isinteger(L, -2) && lua_isinteger(L, -1)) {
        int w = lua_tointeger(L, -2);
        int h = lua_tointeger(L, -1);
        printf("Config Loaded: %d x %d\n", w, h);
    }

    // 5. 정리
    lua_close(L);
    return 0;
}
```

### 2.3 컴파일 및 실행 (MacOS Terminal)

Apple Silicon(M1/M2/M3) 사용자는 `/opt/homebrew` 경로를 명시해야 합니다.

```bash
# 컴파일 (경로는 brew --prefix lua 결과에 따라 조정)
clang -o lua_embed main.c -I/opt/homebrew/include -L/opt/homebrew/lib -llua

# 실행
./lua_embed
# 출력: Config Loaded: 1920 x 1080
```

---



## 3. Python 연동 가이드

Python이 메인 로직을 담당하고, 고성능 연산이나 특정 스크립팅이 필요할 때 Lua(LuaJIT)를 호출하는 구조입니다. `lupa` 라이브러리가 표준입니다.

### 3.1 설치

```bash
pip install lupa
```

### 3.2 Python에서 Lua 함수 실행

```python
from lupa import LuaRuntime

# Lua VM 생성 (Python 내부에 격리된 메모리 공간 생성)
lua = LuaRuntime(unpack_returned_tuples=True)

# Lua 코드 정의 (피보나치 수열)
lua_code = """
function fib(n)
    if n < 2 then return n end
    return fib(n-1) + fib(n-2)
end
"""

# Lua 코드 실행
lua.execute(lua_code)

# Python 변수에 Lua 함수 바인딩
lua_fib = lua.globals().fib

# Python처럼 호출
result = lua_fib(10)
print(f"Fibonacci(10) calculated by Lua: {result}")

# Python Dict를 Lua Table로 전달
process_data = lua.eval("""
    function(data)
        -- Lua는 Python dict를 table처럼 접근 가능
        return data['value'] * 2
    end
""")

print(process_data({'value': 21}))  # 42 출력
```

---

## 4. Mac 로컬 실습 환경 구축 요약

가장 빠르게 실습을 시작하는 방법입니다.

1. **설치**: `brew install lua`
2. **확인**: 터미널에 `lua` 입력 → 인터랙티브 쉘 진입.
3. **에디터**: VS Code 설치 → "Lua" (Sumneko) 익스텐션 설치 (강력 추천, 문법 검사 및 자동완성).
4. **실행**: `.lua` 파일 작성 후 터미널에서 `lua filename.lua`로 실행.

이 과정을 통해 Lua의 간결함과 C/Python과의 강력한 접착성을 직접 경험해 보시기 바랍니다.

