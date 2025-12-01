// Default ESLint configuration for projects without their own config
// This file is used as a fallback by conform.nvim

export default [
  {
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      parserOptions: {
        ecmaFeatures: {
          jsx: true,
        },
      },
    },
    rules: {
      // Use ESLint recommended rules as default
      'no-unused-vars': 'warn',
      'no-undef': 'error',
      'no-console': 'off',
      'semi': ['warn', 'always'],
      'quotes': ['warn', 'single', { avoidEscape: true }],
      'indent': ['warn', 2],
      'comma-dangle': ['warn', 'always-multiline'],
      'object-curly-spacing': ['warn', 'always'],
      'array-bracket-spacing': ['warn', 'never'],
      'arrow-spacing': 'warn',
      'keyword-spacing': 'warn',
      'space-before-blocks': 'warn',
      'space-infix-ops': 'warn',
      'eol-last': ['warn', 'always'],
      'no-trailing-spaces': 'warn',
      'no-multiple-empty-lines': ['warn', { max: 1, maxEOF: 0 }],
    },
  },
];
