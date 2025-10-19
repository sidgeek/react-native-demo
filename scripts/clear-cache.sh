#!/bin/bash

# React Native 缓存清理脚本
# 用于解决Transform Error和Jest worker异常

echo "🧹 开始清理React Native缓存..."

# 1. 停止所有Metro进程
echo "📱 停止Metro进程..."
lsof -ti:8081 | xargs kill -9 2>/dev/null || true
lsof -ti:8082 | xargs kill -9 2>/dev/null || true
lsof -ti:8083 | xargs kill -9 2>/dev/null || true

# 2. 清理Watchman
echo "👀 重置Watchman..."
watchman watch-del-all 2>/dev/null || true
watchman shutdown-server 2>/dev/null || true

# 3. 清理Metro缓存
echo "🚇 清理Metro缓存..."
npx react-native start --reset-cache --port 8083 &
sleep 2
kill %1 2>/dev/null || true

# 4. 清理npm/pnpm缓存
echo "📦 清理包管理器缓存..."
pnpm store prune 2>/dev/null || npm cache clean --force 2>/dev/null || true

# 5. 清理临时文件
echo "🗑️  清理临时文件..."
rm -rf /tmp/react-* 2>/dev/null || true
rm -rf /tmp/metro-* 2>/dev/null || true
rm -rf /tmp/haste-map-* 2>/dev/null || true

# 6. 清理Android构建缓存
echo "🤖 清理Android缓存..."
cd android && ./gradlew clean 2>/dev/null && cd .. || true

echo "✅ 缓存清理完成！"
echo "💡 现在可以运行: pnpm start --reset-cache --port 8083"