
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
