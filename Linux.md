$$
There\ is\ more\ than\ one\ way\ to\ get\ the\ job\ down.
$$

参考：

1. Linux命令行与shell脚本编程大全（第3版）
2. Linux系统命令及Shell脚本实践指南
3. Life

[TOC]

# 其它问题

## 输入光标不见

~~~shell
echo -e "\033[?25l"  # 隐藏光标
echo -e "\033[?25h"  # 显示光标
python run_cnn.py -o "ew_ef_fcnt.result" -s "union_normal_ew_ef_fsize/$ew-$ef" -d 'union_normal' -e $ew $ef -f $fcnt --fsize 3 4 5 6 --l2 1e-4 --dropouts 0.25 0.5 -a 0 -n 2 -b 256
~~~

# Linux

一切皆文件

## 基础概念

Linux可划分为以下四部分

**Linux内核**：控制着计算机系统上的所有硬件和软件，主要负责四种功能：

* 系统内存管理

* 软件程序管理

  > 运行中的程序即为进程，进行可以在前台或后台进行。
  >
  > 内核创建了第一个进程：init进程，这一进程负责启动其它进程
  >
  > `/etc/inittab`：管理系统开机时要自动启动的进程 - 一些发行版适用
  >
  > `/etc/init.d`：开机时启动或停止某个应用的脚本
  >
  > 运行级：1 - 2 - 3 - 4 - 5

* 硬件设备管理

  > 加载相关硬件驱动程序

* 文件系统管理

**GNU工具**：

**图形化桌面环境**：

**应用软件**：

<img src="https://gitee.com/Butterflier/pictures/raw/master/images/20210319172005.png" alt="image-20210319171942852" style="zoom:33%;" />

---

**/boot分区**：放置Linux启动所用到的文件

**DHCP**：Dynamic Host Configuration Protocol、动态主机配置协议，对网络节点上的主机进行IP地址配置

**Grub**：系统引导工具，用于加载内核，引导系统启动

**交换分区**：作用相当于windows下的虚拟内存，一般设置为物理内存的两倍，最大不建议超过8G（过大没有意义）

文本命令行界面：Command Line Interface - CLI

## 启动流程

1. 计算机加载BIOS，对硬件进行一次检查。
2. 硬件检查完毕后，BIOS默认会从硬盘上的第0柱面、第0磁道、第一个扇区中读取MBR（主引导记录）

## 基础命令

* 严格区分大小写

**date**

~~~shell
[root@localhost ~]# date￼
Thu Oct 11 23:05:54 CST 2012
~~~

**cat**：显示文件内容

---

<img src="https://gitee.com/Butterflier/pictures/raw/master/images/20210319190926.png" alt="image-20210319190926203" style="zoom:50%;" />

颜色列表：`black  red  green  yellow  blue  magenta  cyan  white`

对调背景色与文本色：

`setterm -inversescreen on` or `setterm -inversescreen off`

修改背景色：`setterm -background white`

修改文本色：`setterm -foreground black`

## 目录说明

`etc/shells` - 查看系统内已安装的 shell 列表

# HERE

# 定时任务管理

**at**：单一时刻执行一次

默认所有用户都可以使用at命令来创建自己的任务，如果要进制，需要操作/etc/at.deny

~~~shell
[root@localhost ~]# at now + 30 minutes
at> /sbin/shutdown-h now
at> <EOT>				  		# CTRL+D 表示输入结束
job 1 at 2020-10-20 17:40 		# job 编号 at 时间
~~~

~~~shell
[root@localhost ~]# atq			# 列出超级用户之外的所有定时任务
6		2020-10-20 17:29 a cjc  # 任务id 时间 a 创建任务的用户
[root@localhost ~]# atrm 6		# 删除目标任务
~~~

**corn**：周期性执行任务

# 文件管理

**绝对路径**：从根目录开始的路径`/`

**相对路径**：从当前目录开始的路径`./`

`.`：表示当前目录

`..`：表示上层目录

## FHS定义

FHS：Filesystem Hierarchy Standard：文件系统目录标准

| 目录        | 用途                                   |
| ----------- | -------------------------------------- |
| /bin        | 常见的用户命令                         |
| /boot       | 内核、启动文件                         |
| /dev        | 设备文件                               |
| /etc        | 系统和服务的配置文件                   |
| /home       | 普通用户默认的家目录                   |
| /lib        | 系统函数库目录                         |
| /lost+found | ext3文件系统需要的目录，用于磁盘检查   |
| /mnt        | 系统加载文件系统时常用的挂载点         |
| /opt        | 第三方软件安装目录                     |
| /proc       | 虚拟文件系统                           |
| /root       | root用户家目录                         |
| /sbin       | 存放系统管理命令                       |
| /tmp        | 临时文件的存放目录                     |
| /usr        | 存放与用户直接相关的文件和目录         |
| /media      | 系统用来挂载光驱等临时文件系统的挂载点 |

## 权限管理

> 对于root用户，文件的默认权限是644，目录的默认权限是755；
>
> 对于普通用户，文件的默认权限是664，目录的默认权限是775。
>
> 在Linux下，定义目录创建的默认权限的值是“umask遮罩777后的权限”，定义文件创建的默认权限是“umask遮罩666后的权限”。
>
> 代码参考/etc/profile文件中，通过第51行至55行的一段代码设置了不同用户的遮罩

> ps：注意Umask文件遮罩

**chattr**：为文件添加隐藏属性

| 属性 | 描述                          | 作用(限制root)                 |
| ---- | ------------------------------ |---------------------------|
| a    | append only | 只能在尾部增加数据而不能被删除 |
| c | compressed |  |
| d | no dump |  |
| i    | immutable | 无法写入、改名、删除           |
| j | data journalling |                                |
| s | secure deletion | |
| t | no tail-merging | |
| u | undeletable | |
| A | no atime updates | |
| D | synchronous directory updates | |
| S | synchronous updates | |
| T | top of directory hierarchy | |

~~~shell
chattr +a filename
~~~

**chmod**：改变文件权限

| 特殊权限 | 作用                                                         | 备注               |
| -------- | ------------------------------------------------------------ | ------------------ |
| SUID     | 普通用户可以使用root的身份来执行这个命令                     | 只能用于二进制文件 |
| SGID     | 该文件的用户组中所有的用户将能够以该文件的用户身份去运行     | 只能用于二进制文件 |
| Sticky   | 任何人都可以在该目录中创建和修改文件，但是只有该文件的创建者和root可以删除自己的文件 | 只能用于目录       |

~~~shell
chmod u+r filename 		# u 可以替换为 g 或者 o 表明，所有者，所有组，其他
chmod u=rx filename
chmod a+x fiflename		# 给所有人设置权限
chmod 754 filename		# r=4,w=2,x=1,则所有者权限为rwx，所有组权限为r-x,其他人权限为r--
chmod -R 754 dirname	# 递归修改目录权限时需要 -R
chmod u+s filename		# 添加特殊权限：SUID
chmod g+s filename		# 添加特殊权限：SGID
chmod o+t directory		# 添加特殊权限：Sticky
~~~

**chown**：改变文件的所有者、所有组

~~~shell
chown cjc filename		# 修改文件的所有者为cjc
chown :cjc filename		# 修改文件的所有组为cjc所在的组
chown cjc:cjc filename 	# 同时修改
chown -R cjc filename	# 递归修改目录
~~~

**chgrp**：改变文件的所有组

~~~shell
chgrp [-R] groupName filename or directory
~~~

**file**：查看文件类型

~~~shell
file filename		# 查看目标文件详细的类型
~~~

**lsattr**：显示文件的隐藏属性

默认隐藏属性均无设置，所以会显示13个短横线 + 文件名

**ls -al**：查看权限

1. 文件类别和权限：10个字符

   * 第一个字符表明文件的类型：d（目录）、-（普通文件）、l（链接文件）、b（块文件）、c（字符文件）、s（socket文件）、p（管道文件）

   * 2~4个字符代表改文件的所有者的权限：rwx – 读写执行

   * 5~7个字符代表文件所有组的权限

   * 8~10个字符表示其他用户的权限

2. 连接数：除了目录文件外，其他所有文件的连接数均为1；目录文件的连接数为目录中包含其他目录的总个数+2

3. 该文件的所有人

4. 该文件的所有组

5. 文件大小

6. 文件的创建时间 或 最近更新的时间

7. 文件名称

## 文件相关命令

**cat**：查看文件

concatenate的简写

~~~shell
cat fileName		# 查看目标文件
cat -n filename		# 查看时显示行号
~~~

**dos2unix**：解决系统之间换行符等问题

~~~shell
dos2unix filename
~~~

**head**：查看文件头

~~~shell
head filename		# 默认显示前10行
head -n 20 filename # 自定义显示行数
~~~

**mv**：移动或重命名文件

~~~shell
mv test.txt /mnt/		# 将test.txt移动到/mnt/下，并不改变命名
mv test.txt /mnt/newName.txt # 同时改变命名
~~~

**pwd**：查看当前目录

**tail**：查看文件尾部

~~~shell
tail filename		# 查看文件尾部，默认为10行
tail -n 20 filename
tail -f filename	# 允许动态的查看文件，一些日志信息...
~~~

**touch**：创建文件

文件存在时会修改时间戳，因此利用这一点可以来优化备份

对于使用频率低的文件，我们对比时间戳后就可以不必重复备份

1. 初次全部备份后，在备份处新建一个Time_stamp文件来记录当前时间戳
2. 下次备份时间时，将目标文件时间戳与Time_stamp文件时间戳对比，如果大，则代表目标文件更新了，需要再次备份
3. 全部备份完成后，touch一下Time_stamp即可。

~~~shell
touch fileName		# 如果当前目录存在目标文件，除了更新创建时间等属性外不会有任何影响
~~~

## 目录相关命令

**cp**：复制文件、复制目录

~~~shell
cp source aim/
cp -r sourceDir aim/	 # 能够复制目录
~~~

**mkdir**：创建目录

~~~shell
mkdir -p /home/cjc/dir1/dir2/dir3...		# 一次性创建到底
~~~

**rm**：删除文件、删除目录（-r）、递归删除(-r, -rf)

~~~shell
rm -rf /		# 恐怖的命令，俗称：删库！
~~~

**rmdir**：只能删除空目录

## 查找文件

**find**

| 名称  | 效果       |
| ----- | ---------- |
| -name | 查找文件名 |
|       |            |
|       |            |

~~~shell
find path -name filename		# 在目标路径下朝招目标文件
~~~

**locate**：数据库查找

Linux系统默认每天会检索一下系统中的所有文件，然后将检索到的文件记录到数据库中

~~~shell
updatedb
locate filename
~~~

**which**

从系统的PATH变量所定义的目录中查找可执行文件的绝对路径

~~~shell
which passwd
>>> /usr/bin/passwd
~~~

**whereis**

从所有路径查找可执行文件，但不能找出其二进制文件

此外whereis还能查找到man手册

~~~shell
whereis passwd
>>> /usr/bin/passwd /etc/passwd/ ... /usr/share/man/man5/passwd/5.gz
~~~

## 压缩与打包

**bzip2**：来自baidu，只针对单个文件，不针对目录，类似于gzip

| 命令 | 描述 |
| ---- | ---- |
| -z   | 压缩 |
| -d   | 解压 |

~~~shell
bzip2 install.log		# 自动命名时在原文件名的基础上 .bz2
bzip2 -d install.log.bz2
~~~

**cpio**：一般和find命令一同使用

find按照条件找出需要本分的文件列表后，通过管道的方式传递给cpio进行备份，生成/tmp/conf.cpio文件，然后再将其中包含的文件列表完全还原回去

~~~shell
#备份：
[root@localhost ~]# find /etc-name *.conf | cpio-cov > /tmp/conf.cpio￼
#还原：￼
[root@localhost ~]# cpio--absolute-filenames-icvu < /tmp/conf.cpio
~~~

**gzip & gunzip**：针对单个文件

~~~shell
gzip install.log		# 会删除源文件
gunzip install.log.gz	# 会删除压缩包
~~~

**tar**

| 命令 | 描述                 |
| ---- | -------------------- |
| -z   | 表示使用gzip         |
| -c   | 表示创建压缩文件     |
| -v   | 显示当前被压缩的文件 |
| -f   | 使用文件名           |
| -x   | 表示解压             |
| -C   | 指定解压到目标目录   |

~~~shell
tar -zcvf boot.tgz /boot
tar -zxvf boot.tgz
tar -zxvf boot.tgz -C /tmp	
~~~

**unzip**

~~~shell
unzip **.zip -d /opt/vpnbook
~~~



# Linux文件系统

文件系统+虚拟文件系统（Virtual File System）

**文件系统**：文件系统是操作系统用于明确磁盘或分区上相关文件的方法和数据结构。即在磁盘上组织文件的方法。

格式化就是简历文件系统的一种方式

**通用结构**

| 结构名称                | 作用                                                         |
| ----------------------- | ------------------------------------------------------------ |
| 超级块：superblock      | 文件系统的总体信息，是文件系统的核心，所以会存在多个超级块（备份） |
| i节点：inode            | 存储所有与文件有关的元数据（文件所有者，权限，指向的数据块），不包括文件名和文件内容 |
| 数据块：data block      | 文件数据，默认4KB/块                                         |
| 目录块：directory block | 文件名和文件在目录中的位置，文件的i节点信息                  |

**ext2文件系统**

The Second Extended File System：极好的存储性能

**结构**：整体结构和通用结构类似，数据块，inode，超级块

**缺陷**：不支持日志功能

**ext3文件系统**

继承自ext2，向下兼容

**日志功能**：两阶段提交

> 1. 写入数据前，文件系统现在日志中写入相关记录信息
>
> 2. 然后再开始真实的写数据
> 3. 写完数据后将之前写入日志中的内容删除

## 分区到挂载

**分区**

0. 新插入一个磁盘 /dev/sdb
1. `fdisk /dev/sdb`：进入目标磁盘操作界面
2. `n`：表示new，新建分区
3. `p`：表示创建主分区，primary partition
4. `1`：表示柱面开始的位置
5. `130`：表示柱面结束的位置
6. `w`：将刚刚创建的分区写入分区表

**创建文件系统**

`mkfs.ext3 /dev/sdb1`

**磁盘挂载**

~~~shell
mount DEVICE MOUNT_POINT	# 将具体设备挂载到目标挂载点，挂载点只能是一个目录
~~~

1. `mkdir DEVICE MOUNT_POINT`：创建目录作为挂载点
2. `mount /dev/sdb1 newDisk`：挂载
3. `mount`：查看所有的挂载，发现挂载成功

**启动自动挂载**

将`/dev/sdb1`挂载到`/root/newDisk`，文件系统为`ext3`，挂载参数`默认`，第五部分是决定dump命令在进行备份时是否要将这个分区存档，默认为0；第六部分是设定系统启动时是否对该设备进行fsck：1 - 保留给根分区，其他分区使用2（检查完根分区后检查）或者0（不检查）

~~~shell
echo “/dev/sdb1 /root/newDisk ext3 defaults 0 0” >> /etc/fstab
~~~

**umount**

参数为设备路径或者是挂载点

~~~shell
umount /dev/sdb1
umount /root/newDisk
~~~



## 磁盘检查

**fsck**

需要磁盘是未挂载状态，否则会造成文件系统损坏

~~~shell
fsck -t ext3 /dev/sdb1
~~~

**badblocks**：确认磁盘是否有物理坏道

~~~shell
badblocks -v /dev/sdb1
~~~

## 逻辑卷

逻辑卷就是使用逻辑卷组管理（Logic Volume Manager）创建出来的设备

**物理卷**：物理磁盘分区 Physical Volume

**卷组**：也就是物理卷的集合

**逻辑卷**：物理卷中划出来的一块逻辑磁盘

**制作步骤**

1. 创建物理卷

## 硬链接和软连接

**硬链接**：实际链接，通过索引接点来进行的链接。它允许一个文件拥有多个有效路径名称

1. 不允许给目录创建硬链接。
2. 只有在同一文件系统中的文件才能创建链接。

~~~shell
ls -li	# 显示文件编号
ln hard01 hard01_hlink
~~~

**软连接**：符号链接，是一个包含了另一个文件路径名的文件，可以指向任意文件或目录，也可以跨文件系统，类似于快捷方式。如果源文件删除，则软连接出现断链。

~~~shell
ln -s soft01 soft01_slink
~~~

# 字符处理

**管道**：就是一个固定大小的缓冲区，1页，4KB，使用频繁的通信机制，将一个命令的输出当做下一个命令的输入

**cut**：截取文本

处理一行文本，选取所需要的部分

| 操作 | 描述                                          |
| ---- | --------------------------------------------- |
| -f   | 展示的列，索引从1开始，逗号分隔，中横线相连   |
| -d   | 分隔一行所用的分隔符                          |
| -c   | 没有分隔符时，输入想要选取的字符，索引从1开始 |

~~~shell
cat /etc/passwd | cut -c 1-3
cat /etc/passwd | cut -f 1,6-7 -d ':'
~~~

**grep**

| 操作 | 描述               |
| ---- | ------------------ |
| -i   | 不区分大小写       |
| -c   | 统计包含匹配的行数 |
| -n   | 输出行号           |
| -v   | 反向匹配           |

~~~shell
grep [-ivnc] '需要匹配的字符' filename
~~~

**paste**：将文件按照行合并，中间使用`tab`分开

| 操作 | 描述       |
| ---- | ---------- |
| -d   | 指定分隔符 |
|      |            |

~~~shell
paste a.txt  b.txt
paste -d '-' a.txt b.txt
paste -d ':' a.txt b.txt > pasteall.txt
~~~

**sort**

| 操作 | 描述       |
| ---- | ---------- |
| -n   | 数字升序   |
| -t   | 指定分隔符 |
| -k   | 指定第几列 |
| -r   | 反向排序   |

~~~shell
sort -[ntkr] filename
cat sort.txt | sort -t ":" -k 2 -nr
~~~

**split**：分隔大文件

之前收到存储的限制，大文件的转移往往需要通过分隔成小文件分别存储，然后在合并这样一种方式来实现

二进制文件没有行的概念！只能按照大小来分，不能按照行来分

~~~shell
split -l 500 big_file.txt small_file_	# 按照行来分 500行一个
>>> small_file_aa small_file_ab ... small_file_za ...

split -b 64m big_bin small_bin_			# 按照大小来分 64M一个
~~~

**tr**：文本转换和删除

| 操作 | 描述                       |
| ---- | -------------------------- |
| -d   | 输入要删除的内容，结合正则 |
|      |                            |

~~~shell
cat /etc/passwd | tr '[a-z]' '[A-Z]'
cat /etc/passwd | tr -d '[c,:]'
~~~

**uniq**：删除重复内容

一般和sort合作使用，先排序，后删除连续完全一致的行

| 操作 | 描述         |
| ---- | ------------ |
| -i   | 忽略大小写   |
| -c   | 计算重复行数 |

# 网络管理

## 网络接口配置

**ifconfig**：输出当前系统中所有处于活动状态的网络接口

> eth0表示的是以太网的第一块网卡。其中eth是Ethernet的前三个字母，代表以太网，0代表是第一块网卡，第二块以太网网卡则是eth1，以此类推。Link encap是指封装方式为以太网；HWaddr是指网卡的硬件地址（MAC地址）；inet addr是指该网卡当前的IP地址；Broadcast是广播地址（这部分是由系统根据IP和掩码算出来的，一般不需要手工设置）；Mask是指掩码；UP说明了该网卡目前处于活动状态；MTU代表最大存储单元，即此网卡一次所能传输的最大分包；RX和TX分别代表接收和发送的包；collision代表发生的冲突数，如果发现值不为0则很可能网络存在故障；txqueuelen代表传输缓冲区长度大小；第二个设备是lo，表示主机的环回地址，这个地址是用于本地通信的。

~~~shell
ifconfig
ifconfig eth0

ifconfig eth0 192.168.159.130 netmask 255.255.255.0	# 手动指定ip，系统重启后丢失
ifconfig eth0 192.168.159.130/24 # 上述简写，能自动计算广播地址：192.168.159.255
~~~

> DEVICE变量定义了设备的名称；BOOTPROTO变量定义了获取IP的方式，这里BOOTPROTO=dhcp的含义是：系统在启用这块网卡时，IP将会通过dhcp的方式获得；还有个可选的值是static，表示静态设置的IP；ONBOOT变量定义了启动时是否激活使用该设备，yes表示激活，no表示不激活。

~~~shell
/etc/sysconfig/network-scripts/ifcfg-eth0		# eth0的配置文件
# 修改文件，BOOTPROTO=static，添加
# IPADDR=192.168.159.129
# NETMASK=255.255.255.0
重启端口 或 重启网络服务（不可远程操作）
~~~

## 路由和网关

# 进程管理

**进程**：程序的一次执行过程

* 交互进程：由shell启动的进程，既可以前台进行也可以后台运行
* 批处理进程：与终端没有联系，是一个进程序列
* 监控进程：别名为系统守护进程，系统启动时启动，保持在后台运行

**ps**：静态观察进程

| 操作    | 描述                         |
| ------- | ---------------------------- |
| -A / -e | 列出所有的进程               |
| -a      | 列出不和本终端有关的所有进程 |
| -w      | 加宽，显示更多信息           |
| -u      | 显示有效使用者相关的进程     |
| aux     | 显示所有包含其他使用者的进程 |

1. USER：进程拥有者
2. PID：进程ID
3. %CPU：占用CPU使用率
4. %MEM：占用内存使用率
5. VSZ：占用的虚拟内存大小
6. RSS：占用的内存大小
7. TTY：运行的终端号码
8. STAT：进程状态：D（不可中断）、R（运行中）、S（休眠）、T（暂停）、Z（僵尸进程）、W（没有足够的内存可分配）、<（高优先级进程）、N（低优先级进程）
9. START：进程开始的时间
10. TIME：累计使用CPU的时间
11. COMMAND：执行的命令

![image-20201022113940487](https://gitee.com/Butterflier/pictures/raw/master/images/20210321112301.png)

**top**：动态显示进程信息

> 第一行是服务器基础信息，包括top命令的刷新时间为13:37:47，系统已经启动的时间为100天19个小时又两分钟，当前有1个用户登录，系统的负载（load average）为：最近1分钟内的平均系统负载为0.05，最近5分钟内的平均系统负载为0.02，最近15分钟内的平均系统负载为0.00（这说明系统基本是闲置的）。
> 第二行是当前系统进程概况，一共有69个进程，其中1个正在运行中，68个处于休眠，没有停止的进程，没有僵尸进程。
> 第三行是CPU信息，us代表用户空间占用的CPU百分比，sy代表内核空间占用的CPU百分比，ni代表改变过优先级的进程占用的CPU百分比，id代表空闲CPU百分比，wa代表I/O等待百分比，hi代表硬中断占用的CPU百分比，si代表软中断占用的CPU百分比。现代计算机一般有多核CPU，要想查看每个逻辑CPU的使用情况，可以在top显示界面中按数字键1。
> 第四行是物理内存的使用状态，从左到右分别表示物理内存总量、已使用的内存、空闲内存、缓存使用的内存。
> 第五行是虚拟内存的使用状态，其中，前三列和物理内存的意义一致，最后一个是代表缓冲的交换区总量。

![image-20201022114033493](https://gitee.com/Butterflier/pictures/raw/master/images/20210321112305.png)

> 如果要显示更多的字段，可以在top显示界面中按字母键f。按该键后，前面打了*号的就是当前显示的字段，要想显示更多的字段可以按一下字段前面的字母对应的键。
>
> 如果要另选排序规则怎么办呢？可以按**大写字母O**键进入排序选择页，然后按一下字段前面的字母对应的键来选择排序字段，之后按回车键返回即可
>
> 快捷键定位排序方式：P（CPU使用率），M（内存使用率），N（PID排序），T（CPU使用时间）
>
> 小写k，输入PID后杀死目标进程
>
> 小写r，输入PID后重新定义进程优先级
>
> ？进入帮助模式

1. PID：进程ID
2. USER：进程所有者
3. PR：进程优先级
4. NI：nice值，负值表示高优先级，正值表示低优先级
5. VIRT：进程使用的虚拟内存总量，单位为Kb，VIRT=SWAP+RES
6. SHR：共享内存大小，单位为Kb
7. %CPU：上次更新到现在的CPU时间占用百分比
8. %MEM：进程使用的物理内存百分比
9. TIME+：进程使用CPU时间总计，单位为1/100秒
10. COMMAND：进程名称（命令名/命令行）

![image-20201022135506935](https://gitee.com/Butterflier/pictures/raw/master/images/20210321112310.png)

**kill**

ps查找到目标进程的PID然后kill掉

信号代码：HUP（1，重启）、KILL（9，强行杀掉）、TERM（15，正常结束）

> 强行杀死进程可能会造成内存泄露，正常结束时默认的杀死进程的方式

**killall**：直接使用进程名来杀死进程

~~~shell
killall httpd
~~~

**lsof**：查询进程打开的文件

list open files：列出当前系统所有打开的文件、需要的访问权限高，切换到root后执行

~~~shell
lsof filename		# 显示打开指定文件的所有进程
lsof -c string		# 显示COMMAND列中包含指定字符的进程所有打开的文件
lsof -u username	# 显示所属user打开的文件
lsof -g gid			# 显示归属于gid的进程情况
lsof +d /DIR/		# 显示目录下一层被进程打开的文件
lsof +D /DIR/		# 递归显示所有...
lsof -d FD			# 显示指定文件描述符的进程
lsof -n				# 不将IP转换为hostname
lsof -i				# 显示符合条件的进程情况
lsof -i [4,6] [protocol] [@hostname|hostaddr][:service|port]
		# IPV4 or IPV6
		# protocol: TCP or UDP
		# hostname: 主机名、hostaddr：IPV4地址
		# service：/etc/sercive 中的 service name
		# port 端口号
~~~

> COMMAND：进程的名称
>
> PID：
>
> USER：进程所有者
>
> FD：文件描述符，应用程序通过文件描述符识别该文件
>
> TYPE：文件类型
>
> DEVICE：磁盘的名称
>
> SIZE：
>
> NODE：索引节点
>
> NAME：打开文件的全路径名称

恢复误删除的文件：文件正在被某个进程使用，而且该进程未停止（依然拥有打开文件的句柄）

~~~shell
lsof | grep message
>>> syslogd 2449 root 1w REG 253,0 149423 4161767 /var/log/messages

cat /proc/2449/fd/2 > /var/log/messages
Service syslogd restart
~~~

**nice**：进程优先级[-20 ~ 19]，数值越低代表优先级越高，也就能更多的被操作系统调度运行

Linux内的动态优先级机制：最终优先级=优先级+nice优先级

~~~shell
nice -n -10 ./job.sh
~~~

**renice**：针对已经启动的进程

~~~shell
renice -10 -p 5555
~~~

# 软件的安装

**解释型语言**：计算机逐条取出源码文件的指令，将其转化成机器指令，并执行这个指令的过程。

**编译型语言**：在程序运行前就将所有的源代码一次性转化为机器代码（一般为二进制程序），再运行这个程序的过程。

# vi与vim编辑器

**vi**：Visual Interface，

**vim**：vi的升级版，许多额外的功能：代码补全，错误跳转，方便编程

**三种模式**：

![image-20210321113105277](https://gitee.com/Butterflier/pictures/raw/master/images/20210321113105.png)

> * 一般模式：移动光标+按键实现基本操作：复制，粘贴，删除等
> * 编辑模式：`i`键进入，移动光标+输入字符
> * 末行模式：`:`键进入

| 一般模式：操作 | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
|                |                                                              |
| CTRL+f         | 向下移动一页                                                 |
| CTRL+b         | 向上移动一页                                                 |
| CTRL+d         | 向下移动半页                                                 |
| CTRL+u         | 向上移动半页                                                 |
| CTRL+r         | 重做操作                                                     |
| CTRL+g         | 显示当前浏览进度                                             |
| CTRL+O         | 回到光标上一处所在                                           |
| CTRL+I         | 撤销CTRL+O                                                   |
| a              | 在当前光标下一个字符处开始编辑                               |
| A              | 在当前光标所在行的最后一个字符处添加内容                     |
| c              | 和d类似，但是删除后会进入编辑状态                            |
| d              | dd(删除一行)、de(删除到单词尾部)、dw(删除一个单词)、d$(删除光标至行尾) |
| ndd            | 删除n行，包括当前行在内的n行                                 |
| d[n]           | 删除n+1行，向下n行+当前行                                    |
| G              | 移动到整个文件的末尾，注意大小写！                           |
| nG             | 回到第n行                                                    |
| gg             | 回到文章开头                                                 |
| hjkl           | ←↑↓→                                                         |
| I              | 在当前行第一个非空字符处开始编辑                             |
| [num]          | 需要回车表示输入完毕，向下移动n行                            |
| o              | 在下一行插入新行开始编辑                                     |
| O              | 在上一行插入新行开始编辑                                     |
| p              | 粘贴                                                         |
| r              | 针对一个字符的错误，输入r后可以进行更改，不必进入编辑模式    |
| u              | 撤销                                                         |
| U              | 撤销对该行的所有操作                                         |
| CTRL+R         | 反撤销                                                       |
| x              | 向后删除                                                     |
| X              | 向前删除                                                     |
| yy             | 复制一行                                                     |
| nyy            | 复制n行                                                      |
| $              | 移动到行尾                                                   |
| 0              | 回到单词头                                                   |
| 2w             | 向前移动两个单词长度，并定位到单词头                         |
| 2e             | 向前移动两个单词长度，并定位到单词尾                         |
| %              | 匹配括号，快速跳转                                           |
|                |                                                              |

| 命令模式：操作 | 效果                 |
| -------------- | -------------------- |
|                |                      |
| wq             | 写入并退出           |
| [num]          | 移动到第n行          |
| x              | 等同于wq，写入并退出 |
|                |                      |

## 关键字搜素

**搜索**

~~~shell
:/HostKey	# 默认向下开始寻找关键字
:n			# 向下继续寻找
:N			# 向上继续寻找

:?			# 默认向上开始寻找关键字
:n			# 向上继续寻找
:N			# 向下继续寻找

set ic		# 忽略大小写 ignorecase
set hls		# 高亮搜索 hlsearch
set is		# 部分匹配 incsearch
set noic nohls nois # ...
~~~

**替换**

~~~shell
:n1,n2s/word1/word2/g  	# 将n1行到n2行之间的所有word1替换为word2
:s/word1/word2/g		# 将本行的word1替换成word2
:s/word1/word2			# 将本行第一次出现的word1替换为word2
:%s/old/new/g			# 整个文件中进行替换
:%s/old/new/gc			# 整个文件逐个询问进行替换
~~~

~~~shell
:! command				# 能够允许内部执行shell命令：：
~~~



## vim的扩展

**多行编辑**：可以选择多行（类似于windows中的Alt键）

**多文件编辑**：`vi file1.txt file2.txt`

~~~shell
# 在第一个文件复制一些内容
:n		# 切换到下一个文件
p		# 粘贴目标内容
:w		# 写入
:w filename # 写入目标文件(新建)
:N		# 回到第一个文件，改动了不写入是无法回到第一个文件的
:r data # 将data所代表的的内容插入到光标之下：可以是filename，也可以是!shell命令
~~~

# SHELL脚本

* `#!`：一个shell脚本永远以`#!`开头，这是一个脚本开始的标记，其告知系统执行这个文件需要使用某个解释器
* `bash -x filename`：观察脚本的运行情况

* 位置参数

  > 从左到右第一个参数为`$1`，`$2`，…， `${10}`，`${11}`…
  >
  > 所有的参数为：`$@` 或 `$*`
  >
  > 参数的总个数为：`$#`
  >
  > 脚本本身名称记为：`$0`

**变量**：弱类型变量，声明变量不需要指定其变量类型,设置变量先声明在使用：`shopt-s-o nounset`

**取消变量**：`unset 变量名 / 函数名`

**局部变量**：每个shell都有自己的变量空间，默认互不影响

**环境变量**：

~~~shell
$BASH			# BASH Shell的全路径
$BASH_VERSION
$CDPATH			# 快速进入某个目录 
	CHPATH="/etc/sysconfig/"	# 如果经常在A目录下工作，令CDPATH="/...A/" 
	cd network-scripts			# 则访问A目录下B则可以直接访问(先检查当前目录，再检查CDPATH)
$EUID			# 当前用户的UID
$FUNCNAME		# 脚本内部，输出当前执行函数的函数名称
$HISTCMD		# 记录下一条命令在history中的编号
$HISTFILE		# 记录history命令记录文件的位置 /home/.bash_history
$HISFILESIZE	# 设置HISFILE文件记录命令的行数
$HISTSIZE		# 定义命令记录缓冲区的大小，缓冲区满或者退出时才写入HISTFILE
$HOSTNAME		# 主机名
$HOSTTYPE		# 主机架构
$MACHTYPE		# 主机类型的GNU标识：主机架构-公司-系统-gnu
$LANG			# 设置当前系统的语言环境
	export LANG=zh_CN.UTF-8
$PWD			# 记录当前目录
$OLDPWD			# 记录之前所在的目录
$PATH			# 命令的搜索路径
	export PATH=/some/path:$PATH
$PS1			# 提示符
~~~

**PS**：如果变量值引用的是其他变量，则必须使用双引号，单引号会阻止Shell解释特殊字符$

~~~shell
name=john
name1="$name"
echo $name1 >>> john
~~~

**数组变量**：只支持一维数组

* 定义与赋值

~~~shell
declare-a Array					# 声明为数组变量
Array[0]=0
Array[1]="Hello"

declare-a Name=('cjc' 'zh')		# 初始化时即可赋值
Name[2]='iie'

Name=('cjc' 'sjq')				# 不用声明即可创建
Score=([3]=3 [5]=5 [7]=7)		# 跳号赋值
~~~

* 取值

~~~shell
${Array[0]}
echo ${Array[@]}				# 取出所有值 输出以空格隔开的元素值
echo ${Array[*]}				# 输出一整行字符串
echo ${#Array[@]}				# 获取数组长度
echo ${Array[@]:1:3}			# 切片 目前：步长为1不可调 不支持负索引
allName = (${Name[@]} ${Nmae[@]})	# 合并多个数组
Array=(${Name[@]/john/cjc})		# 替换元素把john换为cjc
unset Array[1]					# 取消数组中的第一个元素
unset Array						# 取消整个数组
~~~

* 引用

~~~shell
""								# 部分引用，引用除 $符 反引号 转义符 之外的所有字符
''								# 单引号，引用所有字符 
``								# 反引号，将其中的内容解释为系统命令
	echo `date`					# can be used in several unix shell
	echo $date					# only be used in bash shell
/								# 转义符，
~~~



## 内建命令

**.**：没错一个`.`用于只执行某个脚本

~~~shell
. ./HelloWorld.sh		# 执行脚本命令 与source类似
~~~

**alias**：创建命令的别名，例如`ll`就是`ls -l`的别名

~~~shell
alias								# 列出当前用户使用了别名的命令
alias Snow='shutdown -h now'		# 仅当前Shell环境中有效
									# 写入.bashrc中使得永久生效
~~~

**break**：跳出循环

~~~shell
break n		# 表示跳出n层循环
~~~

**continue**：跳到某一层循环

~~~shell
continue n	# 跳出n层循环后继续执行
~~~

**declare**：声明变量

~~~shell
num = 1						# 默认不用指明类型
declare -i num2 = 2			# 指明为整数类型
declare -r readonly = 100	# 声明为只读类型
declare -a arr='([0]="a" [1]="b" [2]="c")' # 声明为数组类型
	echo ${arr[0]}
declare -F					# 显示脚本中定义的函数
declare -f					# 详细显示函数体
~~~

**echo**：打印内容

~~~shell
echo "data"			# 默认带有换行符
echo -n "data"		# 取消换行符
echo -e "data\n"	# 能够识别转义字符
~~~

**eval**：将所跟的参数作为Shell的输入，并执行产生命令

~~~shell
eval echo "$name2"		# 执行的命令是 echo $name2
~~~

**exit**：退出当前脚本

~~~shell
exit n					# 以状态n退出，默认是5、注意要bash exit.sh运行，不能. ./exit.sh
echo $?					# 查看之前脚本的退出状态
~~~

**export**：扩大变量的作用域

用户登录后所在的shell为父shell，执行脚本会递归创建子shell

默认情况下，父shell中的变量是局部的，不会被子shell看见

使用了`export`后，有了值的传递，但是并非指针的意思，子shell中的更改不会影响到父shell

~~~shell
export var=100			# 使得父shell中定义的变量作用域扩大
~~~

**kill**：发送信号给指定PID或进程

**let**：整数运算

~~~shell
let L=15/7				# L=2,计算结果为整数
let N=2**3				# 整体语法类C,这个类Python
~~~

**local**：在脚本中声明局部变量

**pwd**：显示当前工作目录

~~~shell
pwd -P					# 会处理软链接，显示真实的路径
~~~

**read**：交互性命令，读取一行输入

~~~shell
declare N
read N
read -p "How many box do you want:" N
read					# 不指定保存的变量名称
echo $REPLY				# 自动保存在变量REPLY中
~~~

**return**：定义函数的返回值

~~~shell
return n
echo $?					# 查看之前函数的返回值
~~~

**shift**：偏移参数

如果最初参数为`A,B,C`，shift一次后则为`B,C`…

**type**：

~~~shell
type commandname		# 判断该命令类型
~~~

**unalias**：删除别名，仅针对当前shell环境

~~~shell
unalias ll			# 删除别名ll
unalias -a			# 删除所有别名
~~~

## 运算符

**算术运算符**：shell只支持整数计算：`+ - * / % **`

**位运算**：`<< >> & | ~(非) ^(异或)`，`~a=-(a+1)`

**运算命令**：`let a=b+c`、`echo $[b+c]`

**expr**：也能用于整数运算，但是要求操作数和操作符之间使用空格隔开，否则只会打印出字符串

~~~shell
expr 1+1			# 1+1
expr 1 + 1			# 2
expr 2 * 2			# syntax error 特殊符号需要用转义符转义
expr 2 \* 2			# 4
~~~

**declare**：显示定义变量类型，Shell会自动解析

**bc**：一类支持浮点运算的语言

~~~shell
TOTAL=$(echo "$NUM1+$NUM2" | bc)
echo $TOTAL
~~~

## 特殊字符

**通配符**

*****：任意长度的字符串、不包括点号和斜线号

**?**：匹配任意一个字符

[abc]：匹配其中任意一个字符



