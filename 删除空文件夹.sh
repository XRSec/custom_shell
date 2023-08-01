#!/bin/bash

# 目标文件夹
source_folder="/volume1/影院/"
# 排除文件夹
exclude_folder="/volume1/影院/#recycle"
# 移动到垃圾桶
dest_folder="/volume1/影院/#recycle"

find "$source_folder" -type d -empty| grep -v ${exclude_folder} | while read empty_dir; do
    current_timestamp=$(date +%Y%m%d%H%M%S) # 获取时间戳
    new_dir_name="$(basename "$empty_dir")_${current_timestamp}" # 获取文件名 设置新名字
    printf "将[%s] 移动到 [%s/%s]" "${empty_dir}" "${dest_folder}" "${new_dir_name}" # 打印日志
    mv "${empty_dir}" "${dest_folder}/${new_dir_name}"  # 移动文件
done
