
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

``
# Step 6 - File Handling

## 🧠 What is File Handling in Bash?

**File handling** in Bash means writing scripts that can:

* **Check** if a file or directory exists
* **Read** content from a file (line by line or all at once)
* **Write** to a file (either overwrite or append)
* **Manipulate** files: copy, move, rename, delete
* **Analyze** files: count words, lines, characters

---

## 🧾 Why is File Handling Useful?

Most real-world scripts do things like:

* Log system status to a file
* Process configuration files
* Clean up temp files
* Back up important data
* Monitor changes in files

---

## 🧩 Key File-Handling Tools in Bash

| Operation              | Command or Test                |
| ---------------------- | ------------------------------ |
| Check if file exists   | `[ -f "filename" ]`            |
| Check if dir exists    | `[ -d "dirname" ]`             |
| Read file line-by-line | `while read line; do ...`      |
| Write to file          | `>` (overwrite), `>>` (append) |
| Copy file              | `cp file1 file2`               |
| Move/rename            | `mv old new`                   |
| Delete                 | `rm file`                      |
| Count lines/words      | `wc -l`, `wc -w`               |
-------

# 🔍 Step 6.1: Checking If a File or Directory Exists

In Bash, we use **test expressions** (inside `[ ]`) to check if a file or directory is there.

### ✅ 1. Check if a **file** exists:

```bash
if [ -f "file.txt" ]; then
    echo "File exists."
else
    echo "File does not exist."
fi
```

* `-f` means: true if it's a regular file
* Quotes around the filename are important if it contains spaces

---

### ✅ 2. Check if a **directory** exists:

```bash
if [ -d "myfolder" ]; then
    echo "Directory exists."
else
    echo "Directory does not exist."
fi
```

* `-d` checks for a directory

---

### 🔸 Other Useful Tests:

| Test   | Meaning                       |
| ------ | ----------------------------- |
| `-e`   | File **exists** (any type)    |
| `-f`   | Regular file exists           |
| `-d`   | Directory exists              |
| `-s`   | File exists **and not empty** |
| `! -f` | File **does not** exist       |

----
# question : - what is the difference btw a regular file and other files?

---

## 🧠 What is a "Regular File" in Bash?

A **regular file** is the most common type of file — like:

* `.txt`, `.sh`, `.csv`, `.log`, `.py`, etc.
* It contains **text, data, or binary content**
* It is **not a directory**, device, socket, or symbolic link

---

## 🗂️ Other Types of Files (not regular):

| Type                         | Description                                      |
| ---------------------------- | ------------------------------------------------ |
| **Directory** (`-d`)         | A folder that contains files and subfolders      |
| **Symbolic link** (`-L`)     | A shortcut to another file or folder             |
| **Socket** (`-S`)            | Used for network or inter-process communication  |
| **Named pipe** (`-p`)        | A special file that allows two processes to talk |
| **Device file** (`-b`, `-c`) | Represents hardware like USBs or terminals       |

---

### 🧪 Example

If you run:

```bash
ls -l /dev/null
```

You'll see something like:

```
crw-rw-rw- 1 root root 1, 3 /dev/null
```

That’s **not a regular file** — it's a **character device file**.

But:

```bash
ls -l my_script.sh
```

Might show:

```
-rw-r--r-- 1 manas manas 123 my_script.sh
```

This **is a regular file**, indicated by the first `-` at the beginning of the permissions (`-rw-r--r--`).

---

### ✅ In Bash:

* Use `-f` to check **only regular files**
* Use `-e` to check **any type of file** (regular, dir, socket, etc.)

---
## 📖 Step 6.2: Reading a File Line by Line

Sometimes you don’t want to process the whole file at once — you want to read each line and handle it individually.

---

### ✅ Syntax: Basic Pattern

```bash
while IFS= read -r line
do
    echo "Line: $line"
done < "filename.txt"
```

---

### 🧠 Explanation:

| Part            | Meaning                                       |
| --------------- | --------------------------------------------- |
| `IFS=`          | Prevents trimming leading/trailing whitespace |
| `-r`            | Prevents backslash escaping                   |
| `read -r line`  | Reads one line into the variable `line`       |
| `done < "file"` | Tells Bash where to read lines from           |

---
## 📝 Step 6.3: Writing to a File (Overwrite)

### ✅ Use `>` to **overwrite** or **create** a file:

```bash
echo "This is the first line." > myfile.txt
```

* If the file doesn’t exist → it gets created
* If it does exist → it gets **overwritten** completely

---

### 🛠️ Example Script (overwrite):

```bash
#!/bin/bash

read -p "Enter a filename to write to: " file
read -p "Enter a message: " message

echo "$message" > "$file"
echo "Message written (file is now overwritten)."
```

---

## ➕ Step 6.4: Appending to a File

### ✅ Use `>>` to **append**:

```bash
echo "This is an extra line." >> myfile.txt
```

* If the file exists → text is added to the **end**
* If it doesn’t exist → it will still be created

---

### 🛠️ Example Script (append):

```bash
#!/bin/bash

read -p "Enter a filename to append to: " file
read -p "Enter a message: " message

echo "$message" >> "$file"
echo "Message appended to file."
```

---
## 🛠️ Step 6.5: Copying and Moving Files in Bash

Bash uses the following commands:

| Action  | Command            | Notes                                 |
| ------- | ------------------ | ------------------------------------- |
| 📋 Copy | `cp source target` | Target can be a filename or directory |
| 🚚 Move | `mv source target` | Also used for renaming                |

---

### ✅ Example: Copy a File

```bash
cp file1.txt backup.txt
```

This copies `file1.txt` into a new file `backup.txt`.

---

### ✅ Example: Move (or Rename)

```bash
mv file1.txt archive/file1.txt
```

Moves the file to another folder.

Or to rename:

```bash
mv old.txt new.txt
```

---
# question : does copying one file to another add content of first to the last place of second file or it overwrites the original content of second file?
---

## ✅ What Happens When You Copy a File in Bash?

### 👉 Command:

```bash
cp source.txt target.txt
```

### 🧠 What it does:

* If `target.txt` **does not exist** → it creates it with the content of `source.txt`.
* If `target.txt` **does exist** → it is **completely overwritten** by `source.txt`.

> ❗**It does NOT append** or preserve any content from the old `target.txt`.

---

### 🔄 Want to **append** content instead of overwrite?

You must use `cat` and `>>`, like this:

```bash
cat source.txt >> target.txt
```

This will **add** the contents of `source.txt` to the **end** of `target.txt`.

---

So:

* ✅ `cp` = overwrite
* ✅ `cat ... >>` = append
------
 # question:i want to move newfile.txt from /home/manas to /home/manas/Desktop how to do this by mv?
 ---

### ✅ Terminal Command:

```bash
mv /home/manas/newfile.txt /home/manas/Desktop/
```

* ✅ This **moves** the file from one location to another
* ✅ If a file named `newfile.txt` already exists in `/Desktop`, it will be **overwritten** without asking (unless you use `-i`)

---

### 🔐 Want to be prompted before overwrite?

Use `-i` for "interactive":

```bash
mv -i /home/manas/newfile.txt /home/manas/Desktop/
```

This will ask you before overwriting anything.

---
Great! You're now entering:

---

### 🟡 **Counting Words, Lines, and Characters in Bash**

This step will help you understand basic file analysis — useful for log parsing, statistics, automation, etc.

---

### 🔧 Key Command: `wc`

The `wc` (word count) command is built-in and helps with:

| Option | Description                |
| ------ | -------------------------- |
| `-l`   | Count number of lines      |
| `-w`   | Count number of words      |
| `-c`   | Count number of bytes      |
| `-m`   | Count number of characters |

---

### ✅ Example Use:

```bash
wc -l filename.txt     # Count lines
wc -w filename.txt     # Count words
wc -m filename.txt     # Count characters
wc filename.txt        # All stats
```

---

### 🧠 Did You Know?

* `wc -c` shows **bytes**, not characters. For multibyte text (like Unicode), use `-m`.
* You can combine flags like `wc -lw`.

---

Assume your file is called `sample.txt` (replace with your actual filename).

```bash
wc sample.txt
```

This will print:

```
<number_of_lines> <number_of_words> <number_of_bytes> sample.txt
```

Now, try the following separately:

```bash
wc -l sample.txt    # Only lines
wc -w sample.txt    # Only words
wc -m sample.txt    # Only characters
wc -c sample.txt    # Only bytes
```

---

### 🔍 Tip

If your file has Unicode characters (like emojis, Devanagari, etc.), try:

```bash
wc -m sample.txt    # for accurate character count
```

------

