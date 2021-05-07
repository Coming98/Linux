# Tricks

basename：返回不包含路径的脚本名 `name=$(basename $0)`

shift：左移动参数，移出的参数值就丢失了，一种自定义遍历参数的方法

getopt：`getopt optstring parameters` 基于 optstring 解析 parameters，每个需要参数的选项字母后加一个 `:` 

# date

~~~shell
date # Wed Apr 14 08:46:16 UTC 2021
date '+%Y-%m-%d %H:%M:%S' # 2021-04-14 08:47:24

%y # 二位年
~~~

# wc

~~~shell
wc # 2 11 60 - 分别表示文件内的  行数  词数  字节数
~~~

# bc

bash 计算器 - 本质为编程语言

能够识别：数字 - 整数和浮点数，变量，数组，注释，表达式，编程语句，函数

~~~shell
# 使用 bc 命令系统
bc # 启动 bash 计算器
scale = n # 设定保留小数位数为n
var = 10 # 定义变量
ans = var / 10 # 使用变量
print ans # 输出变量
quit # 退出

# 脚本中使用 bc
variable=$(echo "options; expression" | bc)
var1=$(echo "scale=4; 3.44 / 5" | bc) # example
# options - 设置变量 - 多个变量使用 ; 分割
# expression - 表达式

# 针对大型计算 - 使用内联输入重定向
variable=$(bc << EOF
options
statements
expressions
EOF
)
var5=$(bc << EOF
scale = 4
a1 = ( $var1 * $var2)
b1 = ($var3 * $var4)
a1 + b1
EOF
)
~~~

