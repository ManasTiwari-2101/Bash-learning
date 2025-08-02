
---

## 🔹 Step 1: Introduction to Bash Scripting

### ✅ What is Bash?

* **Bash** stands for **Bourne Again SHell**.
* It is a command-line interpreter used to interact with the system, automate tasks, and write shell scripts.

### ✅ Starting a Bash Script

* Every Bash script should begin with the **shebang** line:

  ```bash
  #!/bin/bash
  ```

  This tells the system to execute the script using the Bash shell.

### ✅ Making Scripts Executable

```bash
chmod +x script.sh
./script.sh
```

---

## 🔹 Step 2: Variables, Input, and Output

### ✅ Variables

* No spaces around `=`.
* Example: `name="John"`
* Use variables with a `$` sign: `echo "$name"`

### ✅ Input from User

* `read` reads user input and stores it in a variable.
* `-p` flag is used to show a prompt inline:

  ```bash
  read -p "Enter your name: " name
  ```

### ✅ Output to Screen

* Use `echo` to print messages:

  ```bash
  echo "Hello, $name"
  ```

### ✅ Common Gotchas

* Always quote your variables: `"$name"` to avoid issues with spaces or empty strings.
* To check if a variable is empty:
  `[[ -z "$name" ]]` — returns true if variable is empty.

### ✅ Exit Status

* `exit 0` — successful execution
* `exit 1`, `exit 2`, etc. — different failure cases

---

## 🔹 Step 3: Conditionals — `if`, `elif`, `else`, `case`

### ✅ `if` Statement Syntax

```bash
if [ condition ]; then
  commands
elif [ another_condition ]; then
  commands
else
  commands
fi
```

### ✅ Test Conditions

#### String Operators:

| Operator       | Meaning                       |
| -------------- | ----------------------------- |
| `-z "$str"`    | True if string is empty       |
| `"$a" = "$b"`  | True if strings are equal     |
| `"$a" != "$b"` | True if strings are not equal |

#### Integer Operators (used with `[ ]`):

| Operator | Meaning            |
| -------- | ------------------ |
| `-eq`    | equal              |
| `-ne`    | not equal          |
| `-lt`    | less than          |
| `-le`    | less than or equal |
| `-gt`    | greater than       |
| `-ge`    | greater or equal   |

#### Arithmetic (used with `(( ))`):

```bash
(( a % 2 == 0 ))
```

No need for `$` inside `(( ))`.

### ✅ Regular Expressions (with `[[ ]]`)

* Use `[[ "$var" =~ regex ]]` to match a pattern
* Example: `[[ "$name" =~ ^[[:space:]]+$ ]]` checks for all spaces

---

### ✅ `case` Statement

Used when checking one variable against multiple fixed patterns.

#### Syntax:

```bash
case "$variable" in
  pattern1) commands ;;
  pattern2) commands ;;
  *) default ;;
esac
```
> 🔴 **No**, Bash `case` statements do **not have fall-through** by default.

---

## 🧠 What does that mean?

In languages like C or Java:

```c
switch (x) {
  case 1:
    // code
  case 2:
    // code (falls through from case 1)
}
```

Unless you write `break`, it continues to the next case.

-------------------------------------------------------------------------------------------------

## ✅ In **Bash**, **each pattern block ends with `;;`**, which **stops execution** of the `case`.

### 🧪 Example:

```bash
case "$x" in
  1)
    echo "One"
    ;;
  2)
    echo "Two"
    ;;
esac
```

* If `x=1`, only `"One"` is printed
* It will **not** fall into case `2`

---

## 🟡 Can you simulate fall-through in Bash?

Yes — but only **manually**, like this:

```bash
case "$x" in
  1)
    echo "One"
    ;&
  2)
    echo "Two"
    ;;
esac
```

### 🔍 What is `;&`?

* `;&` tells Bash to **also run the next pattern**, even if it doesn’t match.

📌 This only works in **Bash 4.0 or later**.

---

### 🧪 Example:

```bash
x=1
case "$x" in
  1)
    echo "You chose 1"
    ;&
  2)
    echo "Also matched 2"
    ;;
esac
```

Output:

```
You chose 1
Also matched 2
```

---

## ✅ Summary:

| Symbol | Behavior                                   |
| ------ | ------------------------------------------ |
| `;;`   | End this case — no fall-through            |
| `;&`   | Fall through to next block (run it too)    |
| `;;&`  | Test next pattern as well (advanced, rare) |


#### Key Notes:

* No fall-through: once a pattern matches, the rest are skipped
* Each case ends with `;;`
* `*` is the default pattern

---

## 🔹 Step 4: Loops — `for`, `while`, `until`

### ✅ `for` Loop

#### C-Style:

```bash
for ((i=0; i<5; i++)); do
  commands
done
```

#### List Style:

```bash
for item in list; do
  commands
done
```

#### `seq` command (used with list-style loop):

```bash
for i in $(seq 1 5); do
  echo $i
done
```

---

### ✅ `while` Loop

Repeats as long as the condition is true.

```bash
while [ condition ]; do
  commands
done
```

#### Common Use: Reading input until user guesses correctly.

---

### ✅ `until` Loop

Repeats as long as the condition is **false**. Opposite of `while`.

```bash
until [ condition ]; do
  commands
done
```

#### Use Case: Wait for correct password, valid input, etc.

---

### ✅ Random Numbers in Bash

Bash has a built-in variable called `$RANDOM` that generates a pseudo-random number between 0 and 32767.

#### To generate a number in a range (e.g., 1 to 10):

```bash
random_number=$(( RANDOM % 10 + 1 ))
```

---

## ✅ Summary: Bash Scripting Essentials

| Feature        | Syntax/Tool                    |
| -------------- | ------------------------------ |
| Start script   | `#!/bin/bash`                  |
| Input          | `read -p "Prompt: " var`       |
| Output         | `echo "$var"`                  |
| If condition   | `if [ cond ]; then ... fi`     |
| Case condition | `case "$var" in ... esac`      |
| Loops (for)    | `for ((i=0;i<n;i++)); do ...`  |
| Loops (while)  | `while [ cond ]; do ...`       |
| Loops (until)  | `until [ cond ]; do ...`       |
| Random         | `$RANDOM`, `$(( RANDOM % n ))` |
--------------------------------------------------------------------------------------------------------
You're right — thanks for the reminder. Here's the **clean `notes.md`** for **Step 5: Functions in Bash**, with theory, syntax, key concepts, and small tips — **no programs included**, so it's ready for GitHub as a standalone notes file.

---

## 📘 Functions (Step 5)

# 🧠 Bash Scripting – Step 5: Functions

Functions in Bash are reusable blocks of code. They help organize logic, reduce repetition, and make scripts cleaner and easier to manage.

---

## ✅ 1. Defining a Function

There are two valid syntaxes:

```bash
my_function() {
    commands
}
````

Or:

```bash
function my_function {
    commands
}
```

---

## ✅ 2. Calling a Function

Once defined, call the function by its name:

```bash
my_function
```

---

## ✅ 3. Passing Arguments to Functions

Arguments are passed like this:

```bash
greet_user "Manas"
```

Inside the function:

* `$1` = first argument
* `$2`, `$3`, ... = second, third, etc.

There is no need to declare parameters explicitly.

---

## ✅ 4. Returning Values from Functions

### 🔸 String or number values (indirect return):

Use `echo` to output the value, and capture it using command substitution:

```bash
get_value() {
    echo "42"
}

value=$(get_value)
```

### 🔸 Exit status (true/false logic):

Use `return` with an integer (0 = success, non-zero = failure):

```bash
check_even() {
    if (( $1 % 2 == 0 )); then
        return 0
    else
        return 1
    fi
}
```

Then use `$?` to check:

```bash
check_even 4
if [ $? -eq 0 ]; then
    echo "Even"
else
    echo "Odd"
fi
```

---

## ✅ 5. Local Variables

To limit variable scope to inside the function, use `local`:

```bash
example() {
    local temp="value"
    echo "$temp"
}
```

Using `local` prevents accidental changes to variables outside the function.

---

## ✅ 6. Special Variables Inside Functions

| Variable      | Meaning                                      |
| ------------- | -------------------------------------------- |
| `$1`, `$2`... | Positional parameters passed to the function |
| `$#`          | Number of arguments                          |
| `$@`          | All arguments as separate words              |
| `$*`          | All arguments as one string                  |
| `$?`          | Exit code of the last command                |

---

## 📌 Summary: Key Function Practices

| Feature       | Tool                        |
| ------------- | --------------------------- |
| Define        | `function_name() { ... }`   |
| Call          | `function_name`             |
| Pass values   | `$1`, `$2`, etc.            |
| Return string | `echo` + `$(function)`      |
| Return status | `return` + check with `$?`  |
| Limit scope   | Use `local` inside function |

```

--------------------------------------------------------------------------------------------
