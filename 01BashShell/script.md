# 基本知识

**标准格式**：在首行指定要使用的 shell：`#!/bin/bash`

**输出不换行**： `echo -n message`

**注意空格**：通常 code 中的空格是为了排版美观，而在脚本中，空格常常被识别为命令或参数的分隔符

`$$`：查看脚本的进程 id

# 变量

~~~shell
var=10 # 赋值变量 var - 没有 $
var2=$var # 引用变量 var - 有 $
var=`ls -l | wc -l` # 使用只shell运行命令，将命令输出信息赋值变量
var=$(ls -l | wc -l) # 同上
~~~

**自定义变量**：字母+数字+下划线，长度不超过20

## 字符串

**单引号字符串**：不支持 变量`$` 与 转义`\`

**双引号字符串**：支持 变量`$` 与 转义`\`

**没有引号包围的字符串**：支持变量`$`，不支持空格

# 重定向

**管道**：将一个命令的输出作为另一个命令的输入  `command1 | command2`

Linux系统实际上会同时运行这两个命令，在系统内部将它们连接起来：在第一个命令产生输出的同时，输出会被立即送给第二个命令

**输出重定向**：

~~~shell
command > outputfile # 命令的输出写入到文件
command >> outputfile # 命令的输出追加到文件
~~~

**输入重定向**：

~~~shell
command < inputfile # 将文件的内容重定向到命令

  wc << EOF     # 内联输入重定向，EOF可以是任意指定字符串 - 文本开始结束标记
> test string 1
> test string 2
> test string 3
> EOF
~~~

# 数学运算

默认的数学运算中只支持整数运算

~~~shell
$[operation] # 内部支持变量
~~~

**浮点解决方案**：详见 - [command.md/bc](./commands.md)

~~~shell
var1=$(echo "scale=4; 3.44 / 5" | bc) # example

var5=$(bc << EOF
scale = 4
a1 = ( $var1 * $var2)
b1 = ($var3 * $var4)
a1 + b1
EOF
~~~

# 结构化命令

完成逻辑流程控制的命令

## Tips

运行脚本后，没有错误提示且等待输入，可能是 参数名称写错了

## ifs

### if-then

bash shell的if语句会运行if后面的那个命令，如果该命令的退出状态码是 0 ，位于then部分的命令就会被执行

~~~shell
# 推荐格式
if command
then
	do sth
fi

# 其它格式
if command; then
	do sth
fi
~~~

### if-then-else-elif

成功执行 A 不成功则执行 B

~~~shell
if command
then
	commands
elif command
then
	commands
else
	commands
fi
~~~

### test测试

初始检测命令的退出状态码，还可以利用 test 命令检测变量的 True False表达

True：变量中存在内容，

Flase：变量为空

其次 test 命令还支持 变量间的 **数值比较，文件比较，字符串比较**

因为经常使用因此使用 `[ test option ]` 进行了封装

**数值比较**：`n1 -eq n2` - `-ge  -gt  -le  -lt  -ne`

~~~shell
# if test conditi
if [ test condition ]
then
	commands
fi
~~~

**字符串比较**：`str1 = str2` - `!=  <  > ` - 需要转义 - `\>  \<`

注意等号之间是存在空格的，这是多条命令组合并非一个赋值命令，否则无论如何退出的状态码都为0，则if为true

`ASCII` - 进行比较，大写字母小于小写字母 - 与 sort 相反

`-n str1` - 检查 str1 的长度是否非0

`-z str` - 检查 str1 的长度是否为0

**文件比较**：测试 Linux 文件系统上文件和目录的状态

eg：存在 default.config 配置文件，需要判断改文件是否存在且是否有读取权限

~~~shell
[-d file] # 存在 且 是目录
[-f file] # 存在 且 是文件
[-r file] # 存在 且 可读 同理：-w -x 可写 可执行
[-O file] # 存在 且 属当前用户所有
[file1 -nt file2] # file 是否比 file2 新 # 比较最新更改时间
[file1 -ot file2]

[-s file] # 存在 且 是非空
[-G file] # 存在 且 默认组与当前用户相同
[-e file] # 存在
~~~

**demos-dir**

~~~shell
dirname='secrets'

if [ -d $dirname ]
then
    echo "$dirname is existed"
    if [ -O $dirname ]
    then
        echo "you can visited it, have a look at it:"
        cd $dirname
        ls -tr 
    else
        echo "you can not access the dir"
    fi  
else
    echo "$dirname is not existed"
fi
~~~

**demos-file**

~~~shell
filename='default.config'

if [ -f $filename ]
then
    echo "$filename is existed"
    if [ -r $filename ]
    then
        echo "$filename is readable"
    else
        echo "$filename is not readable"
    fi  
    if [ -x $filename ]
    then
        echo "$filename is executable"
    else
        echo "$filename is not executable"
    fi  
else
    echo "$filename is not existed"
fi

~~~

**demo-fileTime**

~~~shell
dirname='./secrets/*'

for file in $dirname
do
    for file2 in $dirname
    do  
        if [ $file = $file2 ]
        then
            continue
        fi
        # echo $file" -  VS - "$file2
        if [ ! $ans ]
        then
            ans=$file
        fi
        if [ $ans -ot $file2 ]
        then
            ans=$file2
        fi
    done
done
echo "$ans is the newest!"

~~~

### 复合条件测试

~~~shell
[ condition1 ] && [ condition2 ] # 第一个条件不同过，第二个条件不会执行
[ condition1 ] || [ condition2 ]
~~~

**demo**

~~~shell
# -o : or
# -a : and
# ! : not
dirname='secrets'

if [ -d $dirname ] && [ -O $dirname -o -G $dirname ]
then
    ls -tr $dirname
else
    echo "permission denied"
fi
~~~

### 高级特性

**双括号**：允许你在比较过程中使用高级数学表达式

支持更多的符号：`++ --  ! && ||  ~ & | **  <<  >>   `

~~~shell
#!/bin/bash
# (( var2 = var++ ))
# if (( $var ** 3 == 1 ))
# if (( $var >= 10 || $var <= 5 ))
var1=10

if (( $var1 ** 2 > 90 ))
then
    (( var2 = $var1 ** 2 ))
    echo "var2=$var2"
fi
~~~

双方括号：提供了模式匹配

~~~shell
#!/bin/bash
if [[ $USER == c* ]] # 双等号将右边的字符串视为一个模式
then
    echo "hello $USER"
else
    echo "sorry, i don't know you"
fi
~~~

## case

case命令会将指定的变量与不同模式进行比较

可以通过竖线操作符在一行中分隔出多个模式模式

~~~shell
case variable in
pattern1 | pattern2) commands1;;
pattern3) commands2;;
*) default commands;;
esac

#!/bin/bash

pattern=cjc
case $pattern in
name | cjc)
    echo "hello $pattern";;
cjc)
    echo "$pattern hello";;
*)
    echo "good bye"
esac
# >>> hello cjc
~~~

# for

和编程语言中常见的 foreach 不同的是，var 的作用域不仅仅在 for 循环中，因此循环结束后，var 的值为 list 中的最后一个值

在某个值两边使用双引号时，shell 并不会将双引号当成值的一部分。

**循环输出的重定向**：在 done 命令后面使用管道或重定向命令即可

~~~shell
for var in list
do
	commands
done | sort 
for test in $var do ... done > a.txt 
for info in $(cat $filepath) do ... done >> a.txt
~~~

## 分隔符

**IFS** - 内部字段分隔符 - internal field separator

定义了bash shell用作字段分隔符的一系列字符 - 默认为 `空格  制表符  换行符`

~~~shell
filepath="./ifsTest.txt"

IFS.OLD=$IFS
IFS=$','
# IFS=$'\n':;" # 如果要指定多个IFS字符，只要将它们在赋值行串起来就行。
...
IFS=$IFS.OLD
~~~

## 通配符

Tips：在使用通配符遍历文件时，注意文件名中允许出现空格，因此需要将文件名用 双引号 括起来

**牛皮**：支持多个目录合并查询  支持变量

~~~shell
catalog1=/home/cjc/*
catalog2=/home/cjc/APINetwork/*

for name in /home/cjc/* $catalog2
do
    if [ -d $name ]
    then
        echo "$name is a dictionary"
    elif [ -f $name ]
    then
        echo "$name is a file"
    fi  
done
~~~

## 退出循环

**break**：

单独使用 - 跳出当前循环；

添加参数 n 表示跳出循环的层数 默认为1 - `break n`

## Demo

~~~shell
#!/bin/bash

IFS.OLD=$IFS
IFS=$'\n'

for entry in $( cat /etc/passwd)
do
    IFS=:
    for demo in $entry
    do  
        echo $demo
    done
done
~~~



## C语言风格

此时变量赋值可以有空格，条件中的变量不以美元符开头，迭代过程的算式未用expr

支持多个变量，但是条件只能一个

~~~shell
for (( i=1; i <= 10; ++i ))
do
    echo "The next number is $i"
done
for (( a=1, b=0; a <= 10; a++, --b )) do ... done
~~~

# while

执行内部命令前先检测 test 命令返回的状态码，非零则不执行

~~~shell
while test command # 格式 同 if-then 中的 command
do
	other commands
done

var=10
while [ $var -gt 0 ] 
do
    echo -n "$var "
    var=$[ $var - 1 ]
done
~~~

多个条件：注意，无论前面的条件是否成立，只看最后一个条件的状态

~~~shell
var=10
while [ $var -ge 5 ] 
    echo $var
    [ $var -ge 0 ] 
do
    echo "This is inside the loop"
    var=$[ $var - 1 ]
done
~~~

## until

until命令要求你指定一个通常返回非零退出状态码的测试命令。

只有测试命令的退出状态码不为0，bash shell才会执行循环中列出的命令

具体格式通 while	

# 交互

**命令行参数**：`$0  $1  ${11}  $#  ${!#}  $@  $*`

## 位置参数

`$0` - 程序名称，`$i` - 表示第 `i` 个参数，`$#` - 表示有效位置参数个数

> 为了使得在不同位置调用脚本文件获取的程序名一致，请使用
>
> basename：返回不包含路径的脚本名 `name=$(basename $0)`

`${!#}` - 表示最后一个参数，无参时为程序名称 - PS，花括号内不支持 `$` 因此换为 `!`

`$*` - 将所有输入的参数看做一个参数- 当作一个单词保存

`$@` - 单独处理输入的参数，构造成for循环可识别的 - 所有参数当作同一字符串中的多个独立的单词

当位置参数超过 10 个时：`${11}`

Tips：使用参数前最好测试是否输入了对应的参数，与用户做好交互提示

Tips：参数中存在带有空格的参数时需要使用双引号将 `$@` 括起来才能成功遍历哦

~~~shell
if [ -n "$1" ]
then
	echo "hello $1"
else
	echo "wrong input!"
~~~

**shift**：默认情况下它会将每个参数变量向左移动一个位置，即变量`$2`的值会移到`$1`中

~~~shell
shift 2 # shift n 表示位移 n 步
~~~

## 选项参数

同位置参数类似，**只不过我们可以人为的或借助工具将选项和参数进行匹配或分割**

**人为解析**：定义一个选项参数和位置参数的分隔符，通常使用 `--`

~~~shell
while [ -n "$1" ]
do
    case "$1" in
    -a) echo "Found the $1 option" ;;
    -b) param=$2
        echo "Found the $1 option"
        echo "  with the parameter value $param"
        shift;;
    -c) echo "Found the $1 option" ;;
    --) shift
        break;;
    *) echo "$1 is an wrong option" ;;
    esac
    shift
done

param_idx=1
for param in $@
do
    echo "Parameter #$param_idx = $param"
    param_idx=$[ $param_idx + 1 ]
done
~~~

**getopt**：针对选项合并等预处理情况，使用getopt完成命令输入的预处理，然后替换原始命令行输入，再进行人工解析

合并多个选项时如何识别，推荐使用 `getopt` 命令将参数进行解析后进行操作

set命令的选项之一是双破折线（--），它会将命令行参数替换成set命令的命令行值。

缺陷：完全的空格分隔解析，忽略了引号，因此无法处理参数中带有空格的情况

~~~shell
echo "getopt opstring parameters"

set -- $( getopt -q ab:c "$@" )

# option parameters manned processing ...

# position parameters manned processing ...
~~~

**getopts**：getopt 的高级版本，支持空格，解析了参数前的引导符，

`$OPTARG` - means the extra parameter of the option

`$OPTIND` - means the parameter idx processing now - 用于 shift 命令，实现 option 和 position 的 cut

~~~shell
while getopts :ab:cd opt
do
    case "$opt" in
    a) echo "Found the $opt option" ;;
    b) param=$OPTARG
       echo "Found the $opt option"
       echo "  with the parameter value $param";;
    c) echo "Found the $opt option" ;;
    d) echo "Found the $opt option" ;;
    *) echo "$opt is an wrong option" ;;
    esac
done

echo "stop when attach the position parametter"

shift $[ $OPTIND - 1 ]

param_idx=1
for param in "$@"
do
    echo "Parameter #$param_idx = $param"
    param_idx=$[ $param_idx + 1 ]
done

~~~



## 统一规范

有些字母选项在Linux世界里已经拥有了某种程度的标准含义。如果你能在shell脚本中支
持这些选项，脚本看起来能更友好一些

![image-20210418140203654](https://gitee.com/Butterflier/pictures/raw/master/images2/20210418140210.png)

## 用户输入

read命令从标准输入（键盘）或另一个文件描述符中接受输入

~~~shell
read name # 等待输入，并将输入赋值给变量 name
read -p "comments" name # 进行提示性输入 - 不会自动换行哦 - 如果使用变量注意使用双引号
read -t 5 name # 防止一直阻塞等待，设定计时器，计时器过期会返回非零状态码（if）
read -n1 name # 表示检测到输入字符个数达到1即可向下运行，不必等待用户回车
read -s password # 输入的数据颜色将与背景色一致，不会被看到
~~~

支持从文件中读取（重定向/管道）

每一次调用 read 会读取一行，直到全部读取完毕，返回非 0 状态码

~~~shell
cat test | while read line 

while read line
do
	sth
done < a.txt

exec 0< a.txt
while read line do sth done
~~~

# 输入输出

## 文件描述符

file descriptor - 用于标识每个文件对象，非负整数

每个进程一次最多可以有九个文件描述符

**Preserved File Descriptor**

| 文件描述符 | 缩写   | Des      |
| ---------- | ------ | -------- |
| 0          | STDIN  | 标准输入 |
| 1          | STDOUT | 标准输出 |
| 2          | STDERR | 标准错误 |

### STDIN

标准输入 - 键盘等

重定向 - `<` - 会用重定向指定的文件来替换标准输入文件描述符 - 读取文件，提取数据

### STDOUT

Standard Output - 终端显示器 - terminal display device

重定向 - `>` - 会将输出重定向到目标文件，写入或追加

Tips：但是 shell 中默认 错误信息 和 输出信息的处理是分开的，因此错误信息仍会打印在 STDOUT

### STDERR

用于处理错误信息的文件描述符 - 文件描述符必须紧紧地放在重定向符号前

只重定向错误信息：`command 2> filename`

重定向错误和输出：

- 不同文件存储：`command 2> filenamea 1>filenameb`
- 相同文件存储：`command &> filename` - 命令生成的所有输出都会发送到同一位置 - 同时赋予错误信息更高的优先级，使得其在正常输出之前被输入到文件中

## 脚本内重定向

将正常输出重定向到指定文件描述符：`command >&n` - n 表示文件描述符 - 在重定向到文件描述符时必须在文件描述符数字之前加一个&

将文件描述符 a 的输出重定向到 文件描述符 b：`command a>&b `

exec 命令：启动一个新shell并将STDOUT文件描述符重定向到文件

`exec 2>filename` `exec 1>testout` - 能够将重定向状态在脚本内应用 - 可被覆盖

`exec 0< filename`

## 自定义文件描述符

依旧使用 `exec` 命令实现

自定义输出文件描述符：

`exec 3> filename` - 在后续的输出中可以使用描述符 3 重定向输出了

`exec 3>>filename` - 输出将被追加到目标文件

自定义输入文件描述符：

`exec 6<&0` - 先将STDIN文件描述符保存到另外一个文件描述符

`exec 0< filename` - 输入被重定向到 filename

自定义双向文件描述符：

`exec 3<> filename`：要注意这个文件只有一个内部指针，交替使用输入和输出会将内容替换或未知错误

关闭自定义文件描述符：`exec 3>$-` `exec 9<&-`

**demo**

~~~shell
# 在脚本中临时重定向输出，然后恢复默认输出设置
exec 9<&0
exec 0<"input.txt"
IFS_OLD=$IFS
IFS=,

while read name age gender
do
    info="Hello $name, you are $age year's old, you sex is $gender"
    if [ $name = "cjc" ]; then
        exec 3>&1
        exec 1> "cjc.info"
        echo $info 
        exec 1>&3
        exec 3>&-
    else
        echo $info
    fi  
done

exec 0<&9
exec 9<&-
IFS=$IFS_OLD

read -p "username: " name
read -s -p "password: " password
echo 
echo "name=$name, password=$password"


echo "this is an advertisment" > /dev/null
~~~

## 阻止命令输出

以将目标重定向到一个叫作 `null` 文件的特殊文件，shell 输出到 null 文件的任何数据都不会保存

Tricks：清空文件 - `cat /dev/null > filename`

## 临时文件

使用 `/tmp` 目录来存放不需要永久保留的文件，通常在系统启动时自动删除

创建本地临时文件：`mktemp tempname.XXXXXX` - mktemp命令会用6个字符码替换这6个X，从而保证文件名在目录中是唯一的 - 命令返回创建的临时文件名

**demo**

~~~shell
tempfile=$(mktemp temp.XXXXXX)
exec 3>&1
exec 1>$tempfile
echo "temp infomation ... "
exec 1>&3
exec 3>&-

rm -f $tempfile 2> /dev/null
~~~

系统临时目录内创建临时文件：`mktemp -t temp.XXXXXX` - 命令返回全路径名称

创建临时目录：`mktemp -d tempdir.XXXXXX`

## 消息多重转发

需求：将目标消息同时发送到 STDOUT 和 指定文件

`tee` - 相当于管道的一个T型接头 - 将从STDIN过来的数据发往 STDOUT 和 指定的文件名

`command | tee filename` - 命令的输出会在 STDOUT  和 filename中记录 - 默认覆盖原文件

`command | tee -a filename` - 追加到文件中

## Demo

分别重定向了 `cat` 命令的输出 和 输入

~~~shell
outputfile="members.sql"
IFS_OLD=$IFS
IFS=,

while read lname fname address city state zip
do
    cat >> $outputfile << EOF
    INSERT INTO members (lname, fname, address, city, state, zip) VALUES ('$lname', '$fname', '$address', '$city', '$state', '$zip');
EOF
done < $1
~~~

# 控制脚本

这些控制方法包括向脚本发送信号、修改脚本的优先级以及在脚本运行时切换到运行模式

## 信号

| 信号 | 值      | Description                    |
| ---- | ------- | ------------------------------ |
| 1    | SIGNUP  | 挂起进程                       |
| 2    | SIGINT  | 终止进程                       |
| 3    | SIGQUIT | 停止进程                       |
| 9    | SIGKILL | 无条件终止进程                 |
| 15   | SIGTERM | 尽可能终止进程                 |
| 17   | SIGSTOP | 无条件停止进程，但不是终止进程 |
| 18   | SIGTSTP | 停止或暂停进程，但不终止进程   |
| 19   | SIGCONT | 继续运行停止的进程             |

默认情况下，bash shell会忽略收到的任何SIGQUIT (3)和SIGTERM (5)信号（正因为这样，交互式shell才不会被意外终止）。但是bash shell会处理收到的SIGHUP (1)和SIGINT (2)信号。

### 生成

`Ctrl + C` - `SIGINT` 信号 - 中断进程

`Ctrl + Z` - `SIGTSTP` 信号 - 停止 shell 中运行的任何进程 - 会让程序继续保留在内存中，并能从上次停止的位置继续运行

### 捕获

使用 `trap commands signals` 命令 - commands 表示捕获目标信号时要执行的命令，signals 表示一组用空格分开的待捕获信号 - 信号用数值或Linux信号名来表示

~~~shell
# 相同信号绑定的命令可以覆盖
trap "echo ' haha you can not kill me!'" SIGINT
trap "echo 'exit successfully'" EXIT
# 使用 -- 恢复信号的默认处理行为
trap -- SIGINT
~~~

## 作业控制

shell 将 shell 中运行的每个进程称为作业，并为每个作业分配唯一的作业号

`ps -l` - 在进程状态列（S列）查看已停止（T状态）的作业信息

停止作业：`Ctrl+c`

~~~shell
# 作业号后方的加号表示默认作业，
jobs # 查看分配给shell的作业
# 在使用作业控制命令时，如果未在命令行指定任何作业号，该作业会被当成作业控制命令的操作对象
jobs -l # 可以查看到作业的PID信息等
jobs -n # 只列出上次 shell 发出通知后改变了状态的作业
jobs -p # 只列出pid
jobs -r # 只列出运行中的作业
jobs -s # 只列出已停止的作业
~~~

重启作业：

`bg` - 重启目标作业，并将其置于后台模式

`fg` - 重启目标作业，并将其置于前台模式

## 后台状态

在后台模式中，进程运行时不会和终端会话上的STDIN、STDOUT以及STDERR关联

后台状态，退出终端会随之终止：

~~~shell
./xxx.sh & # 该脚本将在后台运行，但是标准输出和标准错误的输出仍然是终端显示器
# >>> [1] 3231 - [作业号] 进程id
~~~

后台状态，即使终端关闭也会运行至结束：`nohup` 命令使得脚本会忽略终端会话发过来的SIGHUP信号

~~~shell
nohup ./xxx.sh &
nohup commands > run.log 2>&1 & 
# > run.log - 将标准输出重定向到 run.log
# 2>&1 - 将标准错误重定向到 run.log
~~~

## 优先级

调度优先级 - scheduling proority - 最高优先级：-20，最低优先级：19，默认优先级：0

设置 / 改变优先级：

1. 只能对属于你的进程执行
2. 只能降低进程的优先级
3. root用户可以通过renice来任意调整进程的优先级

~~~shell
nice -n 10 ./test.sh > run.out & # nice 命令可以降低优先级，但是普通用户不能用于提高优先级
renice -n 10 -p pid # 将进程 pid 的优先级改编为10
~~~

## 定时脚本

`at` - 令允许指定Linux系统何时运行脚本 - 存在守护进程 `atd` 以后台模式运行，检查作业队列来运行作业

该命令默认将 email 作为输出目标，因此最好在执行的命令上添加重定向

~~~shell
# at [ -f filename ] time
# time: now\teatime\tomorrow\13:30\
at -f test.sh now
at -M -f test.sh now # 屏蔽作业产生的输出信息
atq # 列出等待的作业 作业号 + 执行时间
atrm 作业号 # 根据 atq 中的作业号删除
~~~



# 退出脚本

shell中运行的每个命令都使用退出状态码（exit status）告诉shell它已经运行完毕

查看退出状态码：`$?` - 上一个命令的退出状态码

手动退出：`exit n`

| 状态码 | 描述                       |
| ------ | -------------------------- |
| 0      | 成功结束                   |
| 1      | 一般性未知错误             |
| 2      | 不适合的shell命令          |
| 126    | 命令不可执行               |
| 127    | 没有找到命令               |
| 128    | 无效的退出参数             |
| 128+x  | 与Linux信号x相关的严重错误 |
| 130    | Ctrl+C执行的终止           |
| 255    | 正常范围之外的退出         |

# END