# Prepair

* `etc/passwd` 文件中存储着每个用户的基本配置信息，其最后一个字段则表示该用户所用的shell

## shell提示符

## bash手册

查找shell命令及其他GNU工具信息的在线手册

`man + 工具名`：定位目标工具的手册条目

手册中分页是由 `pager` 支持的，换行是 `Enter`，换页是 `Space`，退出是 `q` 

当然也可以使用 `命令名称 --help | pager`

# 文件系统

Linux将文件存储在单个目录结构中，这个目录被称为虚拟目录（virtual directory）。虚拟目录将安装在PC上的所有存储设备的文件路径纳入单个目录结构中。

Linux使用正斜线 `/` 划分目录，使用 `\` 表示转义

在Linux PC上安装的第一块硬盘称为根驱动器。根驱动器包含了虚拟目录的核心，其他目录都是从那里开始构建的。

Linux会在根驱动器上创建一些特别的目录，我们称之为挂载点（mount point）。挂载点是虚拟目录中用于分配额外存储设备的目录。虚拟目录会让文件和目录出现在这些挂载点目录中，然而实际上它们却存储在另外一个驱动器中。

<img src="https://gitee.com/Butterflier/pictures/raw/master/images/20210319194524.png" alt="image-20210319194524734" style="zoom:50%;" />

## 文件信息

![image-20210319200725162](https://gitee.com/Butterflier/pictures/raw/master/images/20210319200725.png)

第一项的第一个字符：文件类型 目录 - `d`  文件 - `-`  字符型文件 - `c`  块设备 - `d`

第一项的后九个字符：文件权限

2. 硬盘连接总数
3. 文件属主的用户名
4. 文件属组的组名
5. 文件的大小（以字节为单位）
6. 文件的上次修改时间
7. 文件名或目录名

## 常见目录名

常见的目录名均基于文件系统层级标准：filesystem hierarchy standard，FHS

<img src="https://gitee.com/Butterflier/pictures/raw/master/images/20210319194740.png" alt="image-20210319194740013" style="zoom:50%;" />

## 相关命令

### cd

Change the shell working directory

绝对路径：从根节点开始到目标目录 `cd /home/user/linux/shell`

相对路径：从当前节点开始到目标目录 `cd ./linux/shell`  或  `cd linux/shell`

Tip：`..` 在相对路径中表示当前节点的父目录

~~~shell
cd destination # 切换到目标目录
cd # 切换到当前用户主目录 - `/etc/passwd`  倒数第二个字段
cd ~ # 切换到当前用户主目录
cd / # 切换到根目录
~~~

### cp

支持通配符

~~~shell
# 将文件从source复制到des，如果des中命名了新的文件名称则更改文件名
cp source destination

cp s . # 复制到当前目录
cp -i s d # 如果存在重名文件则询问是否覆盖 - 默认覆盖
cp -r s d # 递归整个目录的复制
cp -b s d # 覆盖已存在文件目标前将目标文件备份 - 备份文件只有一个
cp -v s d # 详细展示cp命令执行的操作过程
~~~

### ls

list directory contents

隐藏文件：文件名以 `.` 开头的文件

~~~shell
ls # 显示当前目录下的文件和目录 - 默认字典序-按列
ls -F # 更加人性化：在目录名后加正斜线（/）、在可执行文件后加星号
ls -a # 显示所有文件和目录（目录也是文件） - 包括隐藏文件
ls -R # 显示文件 并递归显示目录内容
ls -l # 显示文件详细信息
ls -l --time=atime # 显示的时间为访问时间

# K = Kilobyte M = Megabyte G = Gigabyte T = Terabyte
ls -l --block-size=M # -l 下的辅助选项，修改文件大小的显示单位

~~~

#### 排序方式

~~~shell
ls -lS # 按照文件大小降序排序
ls -lX # 按照扩展名字典序排序 == ls -l --sort=extension
ls -lt # 按照修改时间最新排序
ls -lS -r # reverse排序方式
~~~

#### 筛选结果

末尾添加过滤器参数，支持通配符：

`?` - 表示一个字符

`*` - 表示零个或任意多个字符

`[acd]` - 将中括号中的内容按字符切分开，表明该字符位置为其中的任意一个。

`[a-d]` - 范围，表明a,b,c,d

`[!abc]` - 排除，表明除了a,b,c均可出现

### file

查看文件类型

1. 文本文件 - `filename: ASCII text` - 得到文本信息与字符编码
2. 目录文件 - `dirname: directory`
3. 二进制文件 - 确定该程序编译时所面向的平台以及需要何种类型的库

### Others

**pwd**：显示当前目录

**touch**：

1. `touch fileName` - 创建空文件
2. `touch existedFileName` -  更新文件的修改时间 - 用于日志技术中
3. `touch -a existedFileName` - 更新文件的访问时间

**mv**：只影响文件名

`mv s d` - 将文件或目录从s移植d，可以改名

`mv -i s d` - 与 `cp` 类似，如果有重名文件则询问是否覆盖

**rm**：删除文件 通常都加入 `-i`，支持通配符

`rm -i file` - 删除文件，并提供确认机制

`rm -f file` - 无提示直接删除

`rm -r file` - 递归删除目录

**mkdir**：创建目录

`mkdir dirname`

`mkdir -p dir1/dir2/dir3` - 递归创建目录和多级子目录

**rmdir**：删除目录

`rmdir dirname` - 默认情况下，只能删除空目录

**cat**：查看整个文件

`cat filename` - 查看目标文件信息

`cat -n filename` - 标记行号

`cat -b filename` - 标记行号 且 忽略空行

`cat -T filename` - 使用 `^I` 替换制表符，方便某些文件的阅读

**more**：按页显示文本内容 `== cat filename | pager`

**less**：升级版的more命令，能够实现文本文件的前后翻动，支持搜索

**tail**：从尾部查看目标文件 `-n` 参数控制显示的行数

`tail -f filename` - 允许你在其他进程使用该文件时查看文件的内容，使得显示保持活动状态，常用于日志文件的监测。

**head**：从头部查看目标文件，与 `tail` 用法类似

## 链接文件

目的是维护同一文件的多份副本，可以采用保存一份物理文件副本和多个虚拟副本的方法，虚拟副本即为 **链接**

### 软链接

也称符号链接，类似于快捷方式，创建目标文件的软链接，会创建一个软链接文件，指向目标文件。

~~~shell
ln -s /etc/passwd ./gotoetc 
~~~

### 硬链接

创建一个虚拟文件，包含了原始文件的信息及位置，根本上而言是一个文件

硬链接不能跨文件系统（分区）建立，因为在不同的文件系统中，inode 号是重新计算的

硬链接不支持目录

源文件删除后，硬链接仍能够正常访问使用

~~~shell
ln source destination
~~~

## 文件处理

### 排序 sort

默认排序 - 字典序ASC（都当成字符串处理）

~~~shell
sort file
sort -n file # 尝试对目标进行数字识别并排序 - 支持浮点数
sort -g file # 通用数值排序 - 支持浮点数和科学计数法
sort -c file # 检查数据是否有序 - 无序时报告无序位置，有序时无提示
sort -M file # 能够识别月份并排序 - 三字符月份
sort -r file # 逆序
sort -f file # 忽略大小写 - 默认时大写字母在前
sort file -o outputfile # 将排序结果导出

sort -m file file_ # 合并两个已排序的数据文件
sort -b file # --ignore-leading-block 忽略起始的空白
sort -d file # 仅考虑空白和字母 - 不考虑特殊字符
~~~

多键值排序

~~~shell
sort -t file # 指定文件的分隔符用于区分各个键的位置 与-k连用执行多键值排序
# 参数可以紧跟键值名写，逗号区分排序熟悉怒
sort -t':' -k1,1 -k3n,2 /etc/passwd | head -n 3
~~~

### 搜索 grep

支持正则表达式 - 不仅仅是通配符了

~~~shell
grep wildcard file
grep -v file # 反向搜索：不是从底部开始搜，是返回不匹配的数据
grep -n file # 返回信息显示行号
grep -c file # 返回匹配的行数
grep -n -e A -e s file # -e 可以添加匹配模式
~~~

略fgrep and egrep

### 压缩数据

~~~shell
gzip file # 压缩文件 >>> file.gz ## 注意是针对每个文件分别生成压缩
gzcat file # 查看压缩过的文本文件的内容
gunzip file # 解压文件
~~~

#### 略未整理tar

![image-20210322203206637](https://gitee.com/Butterflier/pictures/raw/master/images/20210322203206.png)



![image-20210322203238440](https://gitee.com/Butterflier/pictures/raw/master/images/20210322203238.png)

~~~shell
# 使用tar命令执行后续的压缩功能
tar function [options] object1 object2 ...
tar -cvf aim.tar *.py # 可视化创建归档文件
tar -tf aim.tar # 查看归档文件内的内容
tar -xvf aim.tar -C tar/ # 解压缩到指定目录

# -z 表示使用gzip命令来执行后续的功能 - 具体操作同上
tar -zcvf aim.tar.gz files
tar -zxvf aim.tar.gz -C file/
~~~

# 进程管理

## Prepared

进程 Process：运行着的程序

进程间通信方式：信号，进程的信号就是预定义好的一个消息，进程能识别它并决定忽略还是作出反应

![image-20210322172044566](https://gitee.com/Butterflier/pictures/raw/master/images/20210322172053.png)

## 进程查看与检测

### 略ps

ps名称参数众多，掌握所需即可，**可用处很多，但现在暂时用不到，略2021年3月22日17:02:17**

**进程的状态**：

R 运行，正在运行或在运行队列中等待。

S 中断，休眠中, 受阻, 在等待某个条件的形成或接受到信号。

D 不可中断，收到信号不唤醒和不可运行, 进程必须等待直到有中断发生。

Z 僵死 ，进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放。

T 停止，进程收到SIGSTOP, SIGSTP, SIGTIN, SIGTOU信号后停止运行运行。

**各参数含义**：

F - 内核分配给进程的系统标记

S / STAT - 进程的状态

UID - 进程所属用户ID

PID - 进程ID

PPID - 父进程号

C - CPU占用率

PRI - 进程的优先级（越大的数字代表越低的优先级）

NI - 谦让度值用来参与决定优先级

ADDR - 进程的内存地址

SZ - 假如进程被换出，所需交换空间的大致大小

WCHAN - 进程休眠的内核函数的地址

TTY - 运行终端

TIME - 已用CPU时间

CMD - 命令名称

VSZ  - 该 process 使用掉的虚拟内存量 (Kbytes)

RSS - 该 process 占用的固定的内存量 (Kbytes)

START - 该 process 被触发启动的时间

~~~shell
ps # 显示当前用户的进程 PID TTY TIME CMD)

ps -A # 显示所有进程
ps -a # 显示除控制进程（session leader①）和无终端进程外的所有进程 - 能略很多
ps -d # 显示除控制进程外的所有进程
ps -e # 显示所有进程
ps -ef # 显示所有进程详细信息 UID PID PPID C STIME TTY TIME CMD
ps -u user # 显示与user用户有关的进程
ps -l # 长格式展示

ps aux # 列出目前所有的正在内存当中的程序
# USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND

ps -axjf # 显示进程调用树

 1    49     1     1 ?           -1 S<       0   0:00 [kthread]
49    54     1     1 ?           -1 S<       0   0:00  \_ [kblockd/0]
49    55     1     1 ?           -1 S<       0   0:00  \_ [kblockd/1]
49    56     1     1 ?           -1 S<       0   0:00  \_ [kacpid]

ps -o pid,ppid,pgrp,session,tpgid,comm # 自定义输出指定字段
#   PID  PPID  PGRP  SESS TPGID COMMAND
~~~

### 略top

实时显示进程信息

`q` - 退出

## 进行通信

### kill

（root权限）通过PID，向运行中的进程发出进程信号

~~~shell
kill pid # 发送 TERM(15) 信号
kill -s 信号名称 pid # 发送指定信号
~~~

### killall

kill的升级版，支持通过进程名结束进程，支持通配符

~~~shell
killall http*
~~~

# 磁盘管理

## 文件系统类型

WindowsPC：

vfast - Windows长文件系统

ntfs - Windows NT、XP、Vista以及Windows 7中广泛使用的高级文件系统

iso9660 - 标准CD-ROM文件系统

## mount

挂载媒体

~~~shell
mount # 会输出当前系统上挂载的设备列表
mount -t type device directory
~~~

## umont

通过设备文件或者是挂载点来指定要卸载的设备

~~~shell
umount directory
umount device
~~~

通常和 **lsof** 命令搭配：在卸载设备时，系统提示设备繁忙，使用改命令获得目标文件相关的进程信息

~~~shell
lsof /path/to/device/node
lsof /path/to/mount/point。
~~~

## df

查看所有已挂载磁盘的使用情况

1. 设备的设备文件位置
2. 能容纳多少个1024字节大小的块
3. 已用了多少个1024字节大小的块
4. 还有多少个1024字节大小的块可用
5. 已用空间所占的比例
6. 设备挂载到了哪个挂载点上

~~~shell
df
df -h # 易读形式显示磁盘使用情况
~~~

## du

默认情况下显示：目标目录下文件、目录和子目录的磁盘使用情况

~~~shell
du # 显示当前目录下磁盘使用情况
du -h # 按用户易读的格式输出大小 - K替代千字节，用M替代兆字节，用G替代吉字节
du -c files # 显示每个输出参数的总计 + 总体大小
du -s files # 显示每个输出参数的总计
~~~

# Shell初识

## 进程列表

是一种命令分组（command grouping），语法为 (command; command; …;) ，这样会创建一个子shell执行小括号里面的命令。

进程列表允许嵌套，生成多个子Shell，个数由全局变量 `$BASH_SUBSHELL` 记录

## 后台模式

在处理命令的时候让出 CLI

命令末尾加上字符`&` - 让目标命令在后台执行

~~~shell
sleep 10& # 让命令暂停10秒钟
(pwd; ls; echo $BASH_SUBSHELL; sleep 10;)& # 进程列表后台执行
~~~

**查看后台任务**：除了使用 `ps` 还有专门的 `jobs` 命令

~~~shell
jobs
jobs -l # 详细展示
~~~

**协程**：可以在协程间通信

~~~shell
coproc sleep 10 # 生成子shell，后台执行命令
coproc name { sleep 10; } # 为后台执行的进程起名称 - 注意花括号前后空格问题
~~~

## 外部命令

文件系统命令，bash shell之外的程序

衍生 - 外部命令执行时，会创建出一个子进程

~~~shell
which ps # 返回外部命令 ps 的地址 - 只能显示外部
type -a ps # 返回外部命令 ps 的地址
~~~

## 内建命令

不需要使用子进程来执行

如果使用内建命令的外部版本，通过文件位置调用即可

~~~shell
type cd # >>> cd is a shell builtin - 检查是否为内建命令
type -a pwd # 有些命令有内建版本也有外部版本，使用 -a 查看所有位置
~~~

### history

通过环境变量 `HISTSIZE` 记录指定书目的历史命令输入

~~~shell
history -a # 通常历史命令会存在缓存中，该命令会强制将内容写入文件
history -n # .bash_history只在首个终端中被读取，多终端时，想要强制重新读取.bash_history，更新终端会话的历史记录，可以使用history -n
~~~

使用 `!!` 执行上一次命令，`!!` 指代的是上一次命令，后面还可以扩充

~~~shell
ls -a
!! -l # 表示 ls -a -l
!20 # history命令中有编号，根据编号执行目标命令
~~~

### alias

为常用的命令创建别名：仅在alias被定义的shell内有效（可以通过环境变量解决）

~~~shell
alias -p # 查看已设置的别名
alias lc='ll | wc -l'
~~~

# 环境变量

存储有关 shell 会话和工作环境的信息

## 全局环境变量

对所有 shell 会话都是可见的

名称全部大写：以区别用户定义的局部环境变量

动态环境变量：与用户、登录方式等相关

~~~shell
# 查看全部全局环境变量
env
printenv
# 查看指定全局环境变量
printenv USER
echo $USER
# 更改全局变量信息：更改系统全局模板, 每一个新用户的初始变量都会从这copy
/etc/skel/.*
source /etc/skel/.*
~~~

**可用的全局变量**

~~~shell
SHELL=/bin/bash # 用户使用的shell
SHLVL=1 # 当前 shell 等级 表示存在的子 shell 数目
PATH=...
USER=cjc
PWD=/home/cjc
HOME=/home/cjc
LOGNAME=cjc

LD_LIBRARY_PATH=:/usr/local/cuda/lib64
LS_COLORS=(long output)
SSH_CONNECTION=192.168.131.54 50491 192.168.125.31 22
LESSCLOSE=/usr/bin/lesspipe %s %s
LANG=en_US.UTF-8
DISPLAY=localhost:12.0
JAVA_HOME=/usr/lib/jdk1.7.0_80
CLASSPATH=.:/usr/lib/jdk1.7.0_80/lib:/usr/lib/jdk1.7.0_80/jre/lib:.:/usr/lib/java/jdk1.7.0_80/lib:/usr/lib/java/jdk1.7.0_80/jre/lib:
XDG_SESSION_ID=1117
SSH_CLIENT=192.168.131.54 50491 22
CUDA_HOME=:/usr/local/cuda
XDG_DATA_DIRS=/usr/local/share:/usr/share:/var/lib/snapd/desktop
SSH_TTY=/dev/pts/2
MAIL=/var/mail/cjc
TERM=ansi
XDG_RUNTIME_DIR=/run/user/1001
LESSOPEN=| /usr/bin/lesspipe %s
_=/usr/bin/printenv
~~~

**定义全局变量**

在子 SHELL 中修改了全局变量的值，即使使用 export 命令尝试覆盖，也不会影响到父 SHELL

~~~python
# 先定义局部变量
local_variable="value" # 注意不允许有空格
# 然后导出到全局中
export local_variable
~~~

**删除全局变量**

比较棘手，删除子 SHELL 的局部变量时，无法影响到父SHELL

## 局部环境变量

只对创建它的 shell 可见

**定义局部变量**

~~~shell
local_variable="value" # 注意不允许有空格
~~~

**删除局部变量**

~~~SHELL
unset local_variable
~~~

## PATH环境变量

外部命令搜索目录

~~~shell
# 环境变量信息
PATH=/usr/lib/jdk1.7.0_80/bin:(long output):/usr/local/cuda/bin
# manipulate path
PATH=$PATH:/opt/bin
PATH=$PATH:. # 当前目录 十分方便
# permanent change your path
vim /home/user/.bashrc # then add the command aforementioned
~~~

## 环境变量读取流程

1. 登录 SHELL：从以下 5 个文件中读取命令
   1. `/etc/profile`：主启动文件，每个用户登录时都会执行该文件
   2. `$HOME/.bash_profile`
   3. `$HOME/.bash_login`
   4. `$HOME/.profile`
   5. `$HOME/.bashrc`
2. 交互式 SHELL：非登录系统时启动的
   1. `$HOME/.bashrc`：查看/etc目录下通用的bashrc文件，为用户提供一个定制自
      己的命令别名和私有脚本函数
3. 非交互式 SHELL：没有命令提示符，系统执行SHELL脚本时使用的SHELL
   1. 检查环境变量 `BASH_ENV` 来查看要执行的文件
   2. 作为子 SHELL 继承父 SHELL 的导出变量（全局变量）

## 数组环境变量

目前使用方式和封装结果并不利于使用

~~~shell
arr=(one two three four five)
echo $arr # >>> one
echo ${arr[2]} # >>> three
# 输出整个数组
echo ${arr[*]}
# 更改值
arr[2]=seven
# 删除值 - 并不会移动后续元素，访问目标索引得到空值
unset arr[2]
# 删除数组
unset arr
~~~

# 安全性

`/etc/passwd` 中记录了用户名和UID的对应关系，500以下的UID为预留，有些服务需要使用特定的UID才能正常工作

`/etc/shadow` 中对系统密码管理提供了更多的控制，只有root用户能够访问

## 用户管理

**三类用户**：普通用户 UID > 500、根用户 UID=0、系统用户 UID 1~499

**/etc/passwd**：文件包含了所有系统用户账户列表以及每个用户的基本配置信息

1. 用户名
2. 密码，旧版中显示加密后的密码，现在将密码放在/etc/shadow中
3. UID
4. GID
5. 说明栏：类似于注释，现在不在使用
6. 家目录：用户登录后，所处的目录
7. 登录Shell：用户登录后所使用的shell

~~~shell
root:x:0:0:root:/root:/bin/bash￼
bin:x:1:1:bin:/bin:/sbin/nologin￼
daemon:x:2:2:daemon:/sbin:/sbin/nologin￼
~~~

**/etc/shadow**

1. 用户名
2. 密码
3. 密码的最近修改日：1970.1.1到密码修改日的天数
4. 密码不可修改的天数：修改密码后，几天内不能修改密码
5. 密码重新修改的天数
6. 密码失效前提前警告的天数
7. 密码失效宽限天数：密码到期后，过几天将会失效，无法登陆系统
8. 账号失效日期
9. 保留字段

~~~shell
root:$1$JjIvgikC$YjiVyo3wVahvrwr0IETTV/:15620:0:99999:7:::￼
~~~

**finger username**：查看目标用户的用户信息

### 添加用户

**useradd**：使用系统默认值 `/etc/default/useradd` 新增用户

1. 分配用户UID，记录用户信息在/etc/passwd和/etc/shadow
2. 创建家目录，/home/cjc
3. 复制/etc/skel（默认用户模板）下所有的文件到/home/cjc
4. 新建一个与该用户名一样的用户组

~~~shell
useradd user # 
useradd -m user # 创建用户的同时创建 HOME 目录
useradd -d /home/.. user # 自己指定家目录
useradd -m -e 2021-04-13 user # 指定终止日期，格式为YYYY-MM-DD
useradd -G root,butterflier # 将用户加入不同的用户组 - 逗号分隔
-k # 与 -m 一起使用，将/etc/skel目录的内容复制到用户的HOME目录中 - 默认

-g group # 新用户登入的初始群组，Group Name or GID

-r # 创建系统账户 - uid < 1000 并非具有管理权限
-s shell # 指定shell
-c # command，passwd中的说明栏目、不能添加符号
-n # 创建一个与用户登录名同名的新组
-u uid # 指定UID
-M # 不创建 HOME 目录
~~~

使用 `useradd -D` 查看其默认配置信息

~~~shell
GROUP=100 # 新用户会被添加到GID为100的公共组
HOME=/home # 新用户的HOME目录将会位于/home/loginname
INACTIVE=-1 # 新用户账户密码在过期后不会被禁用
EXPIRE= # 新用户账户未被设置过期日期
SHELL=/bin/bash # 新用户账户将bash shell作为默认shell
SKEL=/etc/skel # 系统会将/etc/skel目录下的内容复制到用户的HOME目录下
CREATE_MAIL_SPOOL=no # 系统不会在mail目录下创建一个用于接收邮件的文件
~~~

更改默认配置信息

~~~shell
useradd -D -s /bin/bash # 修改默认shell
useradd -D -g group # 修改默认组名

useradd -D -b default_home # 修改默认HOME位置
useradd -D -e expiration_data # 修改默认账户的过期日期
useradd -D -f inactive # 更改默认的新用户从密码过期到账户被禁用的天数
~~~

### 删除用户

**userdel**

~~~shell
userdel uername # 仅仅删除 /etc/passwd and /etc/shadow 中的记录
userdel -r username # 递归删除用户家目录 以及 mail 目录 - 需要检查目标用户家目录中是否有其他用户的数据文件
~~~

### 修改用户

***chsh**：修改用户账户的默认登录 shell

~~~shell
chsh -s /bin/bash username 
~~~

***passwd**：修改/设定密码

~~~shell
passwd username # 执行修改密码脚本
passwd -e username # 修改密码，并强制用户下次登录时修改密码
~~~

***usermod**：修改 `/etc/passwd` 文件中大多数字段

~~~shell
usermod -l username # 修改登录名
usermod -L username # 锁定目标用户，使无法登陆
usermod -U username # 解除目标用户的锁定
...
~~~

**chpasswd**：针对大量用户，从文件中读取登录名密码对（colon分割），并更新密码

~~~shell
chpasswd < users.txt
~~~

**chage**：针对临时账户，修改密码过期日期

支持日期格式：`YYYY-MM-DD ` OR `1970.1.1到尽头的天数值`

~~~shell
chage -d # 设置上次修改密码到现在的天数
chage -E # 设置密码过期的日期
chage -I # 设置密码过期到锁定账号的天数
chage -m # 设置修改密码之间最少要多少天
chage -W # 设置密码过期前多久开始出现提醒信息
~~~

**chfn**：修改用户账户的备注信息 - 使用 finger 命令查看

~~~shell
chfn username # 简单的执行脚本即可，有提示信息
~~~

## 组管理

一般的，发行版会为每个新用户创建单独的组，这样使得文件更加安全

**/etc/group**：组信息，组名`:`组密码`:`GID`:`属于该组的用户列表

ps：当一个用户在/etc/passwd文件中指定某个组作为默认组时，用户账户不会作为该组成员再出现在/etc/group文件中

### 创建组

~~~shell
groupadd shared
# 使用usermod分配用户到新组
usermod -G shared coming # 对默认组没有影响
usermod -g shared coming # 新组替换掉默认组
~~~

### 修改组

~~~shell
groupmod -n newname oldname # 修改组名 - new name是-n附带的参数
groupmod -g gid groupname # 修改gid
~~~

### 相关信息

~~~shell
groups￼ # 输出用户所属组
~~~

## 文件权限

`-` - 文件 | `d` - 目录 | `l` - 链接 | `c ` - 字符型设备 | `b ` - 块设备 | `n ` - 网络设备

`r` - read | `w` - write | `x` - 可执行

属主的权限 - 属组的权限 - 其它用户的权限 | 支持采用八进制表示 3 位权限

针对文件：最高权限为 666 (不可执行)，减去掩码即为默认权限分配规则

针对目录：最高权限为 777 （可执行），减去掩码即为默认权限分配规则

### 改变权限

修改 `umask=026` 可以使得后续创建的文件或文件夹使用指定的权限

~~~shell
chmod 760 dir # 完全重新指定权限
# u g o | + - = | r w x
chmod u+x script # 在现有的基础上增加或减去某一权限
chmod -R ... A/ # 递归应用到子文件和子文件夹中
~~~

### 改变所属

~~~shell
chown username filename # 改变filename所有者为username
chown username.groupname filename # 同时改变所属组
chown username. fielname # 默认组名为 username

chgrp groupname file # 改变文件的所属组
~~~

## 文件共享

利用 Linux 为每个文件和目录额外存储的 3 个信息位

SUID - 设置用户ID - 当文件被用户使用时，程序会以文件属主的权限运行

SGID - 设置组ID - 对文件来说，程序会以文件属组的权限运行；对目录来说，目录中创建的新文件会以目录的默认属组作为默认属组

粘着位 - 进程结束后文件还驻留（粘着）在内存中

其中 SGID 对文件共享非常重要

**SGID**

启用SGID位后，你可以强制在一个共享目录下创建的新文件都属于该目录的属组，这个组也就成为了每个用户的属组

~~~shell
chmod g+s testdir
~~~

1. 创建共享目录
2. chgrp 将共享目录的默认属组改为需要共享的用户所在的组
3. 添加 SGID 位

## **相关命令**

**id**

~~~shell
[root@localhost ~]# id
uid=0(root)gid=0(root)groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
~~~

**users**：列出当前系统有哪些用户（登录的）

**who**：查询当前在线用户

1. UserName
2. 用户登录的终端
3. 用户登录的时间

~~~shell
[root@localhost ~]# who￼
root     tty1         2012-10-22 00:13￼
root     pts/0        2012-10-22 21:20 (192.168.179.1)￼
john     pts/1        2012-10-22 22:35 (192.168.179.1)
~~~

**w**

1. UserName
2. 用户登录的终端
3. 用户从网络登录的话显示远程主机的主机名或IP地址
4. 用户登录的时间
5. 用户闲置时间
6. 与终端相关的当前所有运行进程消耗的CPU时间总量
7. 当前WHAT列所对应的进程所消耗的CPU时间总量
8. 用户当前运行的进程

~~~shell
[root@localhost ~]# w￼
23:21:30 up 27 min,2 users,load average: 0.00,0.00,0.00
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT￼
root     tty1     -                23:00    7.00s  0.02s  0.02s-bash￼
root     pts/0    192.168.179.1    22:56    0.00s  0.03s  0.00s w
~~~

**finger**

~~~shell
finger # 显示所有用户简略信息
finger userName # 显示目标用户详细信息
~~~

**su**

~~~shell
su UserName # 没有用户名时，默认切换到root，仅仅切换身份
~~~

**sudo**

使用root的身份执行后续命令，用户首先应该具有执行sudo的权限（检查/etc/sudoers）,这样就避免了root密码的外露，只需要授予一定的权限即可

权限管理：john这个用户可以从任何地方（第二列ALL）登陆后执行任何人（第三列ALL）的任何命令（第四列ALL）

**Tip**：最后一列设置为ALL相当于拥有了root的所有权限，不安全，可以根据工作内容定义命令列表

~~~shell
[root@localhost ~]# visudo￼
......(略去内容)......￼
root    ALL=(ALL)       ALL￼
john    ALL=(ALL)       ALL  # 复制上一行的内容，并修改用户名为john￼
%group1 ALL=(ALL)       ALL  # 所有属于john用户组的用户从任何地方登陆后执行任何人的任何命令
cjc     ALL=(ALL)       NOPASSWD:ALL # cjc使用sudo时不需要输入自己的密码
john    ALL=(ALL)       NOPASSWD:/sbin/shutdown,/user/bin/reboot
......(略去内容)......
~~~

---

**passwd**

创建用户后，设置密码前，用户记录中密码显示为两个叹号，这是不被允许登录系统的

~~~shell
passwd username # 仅仅root可以修改其它用户
passwd # 普通用户只能裸调用，来修改自己的密码
~~~

**usermod**

用户创建完毕后，对用户信息的修改，命令格式同Useradd

~~~shell
usermod -d /cjc -m cjc # -m如果指定用户存在家目录，则自动创建新目录，并修改家目录的指向
usermod -L cjc # 锁定用户，/etc/shadow上密码前多一个！
usermod -U cjc # 解锁用户
~~~

**groupadd**

~~~shell
groupadd groupName
~~~

**groupdel**

~~~shell
groupdel groupName # 前提条件：该组内没有用户
~~~

# 略文件系统

## Basic file system

### ext文件系统

extended filesystem，扩展文件系统

类Unix文件系统：用虚拟目录来操作硬件设备，在物理设备上按定长的块来存储

具体的：采用索引接点系统存放虚拟目录中的文件信息

1. 在每个物理设备创建 索引节点表
2. 存储在虚拟目录中的每个文件在索引节点表中都由一个条目

属性：文件名，文件大小，文件属主，文件属组，文件的访问权限，指向存有文件数据的每个硬盘块指针

缺陷：文件大小不能超过2GB

### ext2

在 ext文件系统 基础上，扩展了索引节点表的格式来保护系统上每个文件的更多信息

扩展信息：创建时间，修改时间，访问时间，文件大小最高达32TB

数据块按组分组，避免 ext 文件系统在整个存储设备中查找某一数据块

缺陷：索引接点表更新频繁，并且非原子化操作 （先将数写入存储设备，在更新索引节点表），常常因为断电等出现异常

## 日志文件系统

先将文件的更改写入到临时文件（日志，journal），在数据成功写到存储设备和索引节点表后，在删除临时文件

![image-20210413144047742](https://gitee.com/Butterflier/pictures/raw/master/images2/20210413144047.png)

**ext3 文件系统**：对存储设备添加日志文件 - 有序模式；缺陷：不支持加密文件

**ext4 文件系统**：支持数据压缩和加密，引入区段和预分配技术

**Reiser文件系统**：日志方式只支持回写模式，两个特性：在线调整已有文件系统的大小，尾部压缩（tailpacking）

**JFS文件系统**：采用有序日志方法

**XFS文件系统**：除了XFS文件系统只能扩大不能缩小

## 写时复制文件系统

写时复制（copy-on-write，COW）

**ZFS文件系统**：没有使用GPL许可

**Btrf文件系统**：B树文件系统

# 包管理系统

package management system，PMS

记录：系统上已安装了什么软件包，每个包安装了什么文件，每个已安装软件包的版本

过程：软件包存储在服务器（仓库，repository）上，利用本地Linux系统上的PMS工具通过互联网访问

## 基于Debian系统

主要有四大命令：`dpkg, apt-get, apt-cache, aptitude`

aptitude工具本质上是apt工具和dpkg的前端。

dpkg是软件包管理系统工具，而aptitude则是完整的软件包管理系统

### aptitude

有助于避免常见的软件安装问题，如软件依赖关系缺失、系统环境不稳定及其他一些不必要的麻烦

软件仓库地址设定：`/etc/apt/sources.list`

~~~shell
# 查看 Information
aptitude # 进去界面查看
aptitude show package_name # 展示目标 package 的详情
aptitude search wine # 查找名称中有 wine 的软件包名
dpkg -L package_name # 所有跟 package 相关的文件列表
dpkg --search absolute_file_name # 查找目标文件属于哪个软件包

# 安装 Install
aptitude install package_name

# 更新 Update
aptitude safe-upgrade # 将所有已安装的包更新到软件仓库中的最新版本
aptitude full-upgrade # 全部更新，不会检查包与包之间的依赖关系

# 卸载 Uninstall
aptitude remove package_name # 只删除软件包，不删除配置及数据
aptitude purge package_name # 删除软件包和相关的数据和配置文件
~~~

## 略基于Red Hat

前端工具 (基于rpm) ：`yum, urpm, zypper`

~~~shell
# 展示 Information
yum list installed
~~~

# 编辑器

## vim

vi improved

~~~shell
hjkl # 左下上右
PageDown - Ctrl + F # 下翻一屏
PageUp - Ctrl + B # 上翻一屏
G # 最后一行
gg # 第一行
num G # 第num行

# 普通模式 - 编辑
# 命令前加数字表示该命令重复多少次
x | dd | dw | d$ | u | ctrl r | a | r char | R test
p | yy | yw | y$ 
J # 删除所在行行尾的换行符 - 实现两行的拼接 
A # 在当前光标所在行行尾追加数据

# 退出方式
q # 安全退出 前提：未修改文件
q! # 取消对文件的所有修改 并 退出
w filename # 将文件保存到另一个文件夹中
wq # 保存并退出
~~~

### 可视模式

可视模式会在你移动光标时高亮显示文本

方式：移动光标到要开始复制的位置，并按下v键，移动光标覆盖文本，y键复制

**查找**：`/` - 进入查找状态：`n` 下一个 `N` 上一个

### 替换

~~~shell
n,ms/old/new/g # 范围是 n-m 行
%s/old/new/g  # 范围整个文件
%s/old/new/gc # 范围整个文件，但替换时提示
~~~

# END