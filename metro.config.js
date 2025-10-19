const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

/**
 * Metro configuration
 * https://reactnative.dev/docs/metro
 *
 * @type {import('@react-native/metro-config').MetroConfig}
 */
const config = {
  resolver: {
    // 确保正确解析模块
    unstable_enableSymlinks: false,
  },
  transformer: {
    // 优化转换器配置
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
  server: {
    // 增强服务器稳定性
    enhanceMiddleware: (middleware) => {
      return (req, res, next) => {
        // 添加错误处理
        res.on('error', (err) => {
          console.warn('Metro server response error:', err);
        });
        return middleware(req, res, next);
      };
    },
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
