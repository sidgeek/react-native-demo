#!/bin/bash

# React Native 符号链接修复脚本
# 用于解决 pnpm 环境下 React Native 包缺失问题

echo "🔧 修复 React Native 符号链接..."

# 获取项目根目录
PROJECT_ROOT="$(pwd)"

# 修复 @react-native/gradle-plugin
echo "📦 修复 @react-native/gradle-plugin..."
GRADLE_PLUGIN_SOURCE="$PROJECT_ROOT/node_modules/.pnpm/@react-native+gradle-plugin@0.82.0/node_modules/@react-native/gradle-plugin"
GRADLE_PLUGIN_TARGET="$PROJECT_ROOT/node_modules/@react-native/gradle-plugin"

if [ -d "$GRADLE_PLUGIN_SOURCE" ]; then
    rm -rf "$GRADLE_PLUGIN_TARGET"
    ln -sf "$GRADLE_PLUGIN_SOURCE" "$GRADLE_PLUGIN_TARGET"
    echo "✅ @react-native/gradle-plugin 符号链接已创建"
else
    echo "❌ 找不到 @react-native/gradle-plugin 源目录"
fi

# 修复 @react-native/codegen
echo "📦 修复 @react-native/codegen..."
CODEGEN_SOURCE="$PROJECT_ROOT/node_modules/.pnpm/@react-native+codegen@0.82.0_@babel+core@7.28.4/node_modules/@react-native/codegen"
CODEGEN_TARGET="$PROJECT_ROOT/node_modules/@react-native/codegen"

if [ -d "$CODEGEN_SOURCE" ]; then
    rm -rf "$CODEGEN_TARGET"
    ln -sf "$CODEGEN_SOURCE" "$CODEGEN_TARGET"
    echo "✅ @react-native/codegen 符号链接已创建"
else
    echo "❌ 找不到 @react-native/codegen 源目录"
fi

# 验证符号链接
echo "🔍 验证符号链接..."
if [ -L "$GRADLE_PLUGIN_TARGET" ] && [ -e "$GRADLE_PLUGIN_TARGET" ]; then
    echo "✅ @react-native/gradle-plugin 符号链接正常"
else
    echo "❌ @react-native/gradle-plugin 符号链接异常"
fi

if [ -L "$CODEGEN_TARGET" ] && [ -e "$CODEGEN_TARGET" ]; then
    echo "✅ @react-native/codegen 符号链接正常"
else
    echo "❌ @react-native/codegen 符号链接异常"
fi

echo "🎉 符号链接修复完成！"