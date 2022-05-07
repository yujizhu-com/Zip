#! /bin/bash

#读取路径中所有文件夹
function ReadDir()
{
	#用?替换文件夹名中空格
    for file in `ls -a "$1" | tr " " "\?"`
    do
    	#用空格替换文件夹名中?
    	file=`tr "\?" " " <<<$file`
  
		local absolutePath="$1"/"$file"
        if [ -d "$absolutePath" ] ;then
        	#过滤 上级目录 当前目录
            if [[ "$absolutePath" =~ ^.*[.,..]+ ]] ;then
            	echo '跳过上层目录和当前目录'
            elif [[ "$absolutePath" =~ ^.*__zip ]];then
            	echo "跳过文件夹$DIR"
            else
                ZipFile "$file"
            fi
        fi
    done
}

#压缩文件夹
function ZipFile()
{
	local file="$1" 
    #red998Jigsaw123Bulldog
	zip -1 -rP red998Jigsaw123Bulldog "$DIR"'/'"$file" "$file" 
}

#主方法
function main()
{
    echo "\n\t------ 开始转换 ------\n"
    cd "$INPUT"

    DIR="$INPUT"'/__zip'
    rm -rf '__zip'
	mkdir "$DIR"

    ReadDir "$1"
    echo "\n\t------ 转换结束 ------\n"
}

#输入路径
read -p 输入文件夹所在路径: INPUT
echo "$INPUT"

#入口
main "$INPUT" 