#!/bin/bash

# 获取当前电源模式
current_mode=$(powerprofilesctl get)

# 定义所有电源模式
modes=("performance" "balanced" "power-saver")

# 找到当前模式在数组中的索引
current_index=-1
for i in "${!modes[@]}"; do
    if [[ "${modes[$i]}" == "$current_mode" ]]; then
        current_index=$i
        break
    fi
done

# 计算下一个模式的索引
next_index=$(( (current_index + 1) % ${#modes[@]} ))

# 设置下一个模式
next_mode="${modes[$next_index]}"
powerprofilesctl set "$next_mode"

# 通知当前模式（可选）
notify-send "Power Profile Switched" "Current mode: $next_mode"
