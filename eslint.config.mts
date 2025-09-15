import js from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";
import { defineConfig } from "eslint/config";
import sapCDSEslintPlugin from '@sap/eslint-plugin-cds';

export default defineConfig([
  { files: ["**/*.{js,mjs,cjs,ts,mts,cts}"], plugins: { js }, extends: ["js/recommended"], languageOptions: { globals: globals.node } },
  tseslint.configs.recommended,
  sapCDSEslintPlugin.configs.recommended,
  {
    rules : {
      '@typescript-eslint/no-unused-vars': [
        'error',
        { argsIgnorePattern: '^_', reportUsedIgnorePattern: true },
      ]
    }
  },
  {
    ignores: ['@cds-models/*'],
  }
]);
