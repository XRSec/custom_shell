#!/bin/bash

source_folder="/volume1/影院/"
exclude_folder="/volume1/影院/#recycle"
dest_folder="/volume1/影院/#recycle"

find "$source_folder" -type d -empty| grep -v ${exclude_folder} | while read dir; do
    if ! [ -L "$dir" ]; then # 跳过软链接
        dir_size=$(du -s "$dir" | awk '{print $1}') # 获取目录大小
        if [ "$dir_size" -lt 10 ]; then # 小于10KB的目录
            current_timestamp=$(date +%Y%m%d%H%M%S) # 当前时间戳
            new_dir_name="$(basename "$dir")_${current_timestamp}" # 新文件名
            printf "将[%s] 移动到 [%s/%s]\n" "${dir}" "${dest_folder}" "${new_dir_name}" # 打印日志
            mv "$dir" "${dest_folder}/${new_dir_name}" # 移动目录
        fi
    fi
done
