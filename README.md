# SKN Elysia.js Helmet

<p align="center">
  <a href="https://elysiajs.com" target="_blank">
  <img width="150px" src="https://firebasestorage.googleapis.com/v0/b/skn-ultimate-project-la437.appspot.com/o/GitHub%20Library%2F17-TypeScript-SEH.svg?alt=media&token=4eec4531-56a3-452d-b005-5f2725d16641" alt="Elysia Helmet" />
  </a>
</p>

> TypeScript

[![NPM Version](https://img.shields.io/npm/v/%40best-skn%2Felysia-helmet)](https://www.npmjs.com/package/@best-skn/elysia-helmet) [![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/license/mit)

&nbsp;

## **_Introduction:_**

### A comprehensive security middleware for Elysia.js applications that helps to secure your apps by setting various HTTP headers

### This library is originally created by [aashahin](https://github.com/aashahin). Total logic has been written by him. His original repository is [Elysia Helmet](https://github.com/aashahin/elysiajs-helmet). I just exported some types so that it can be imported in separate files while using this library and also added an object holding some readonly properties related to security configurations

### I created this library so that I can manage it all by myself and I don't have to rely on [aashahin](https://github.com/aashahin)

&nbsp;

## **_Features:_**

- 🛡️ Content Security Policy (CSP)
- 🔒 X-Frame-Options protection
- 🚫 XSS Protection
- 🌐 DNS Prefetch Control
- 📜 Referrer Policy
- 🔑 Permissions Policy
- 🔐 HTTP Strict Transport Security (HSTS)
- 🌍 Cross-Origin Resource Policy (CORP)
- 🚪 Cross-Origin Opener Policy (COOP)
- 📝 Report-To header configuration
- ✨ Custom headers support

&nbsp;

## **_Details:_**

### **`ReportToConfig` Interface**

- Configuration interface for Report-To header
- For usage instruction, see `Usage` section

### **`CSPConfig` Interface**

- Configuration interface for Content Security Policy
- For usage instruction, see `Usage` section

### **`HSTSConfig` Interface**

- Configuration inerface for HTTP Strict Transport Security
- For usage instruction, see `Usage` section

### **`SecurityConfig` Interface**

- Configuration interface for Security Headers
- For usage instruction, see `Usage` section

### **`permission` Object**

- An object containing permission related constants for some security configurations
- For usage instruction, see `Usage` section

### **`elysiaHelmet` Function**

- Creates an Elysia middleware that adds security headers to all responses
- Optimized for performance with minimal object spread operations
- For usage instruction, see `Usage` section

&nbsp;

## **_Use Case:_**

- Elysia.js

&nbsp;

## **_Requirements:_**

### This library has peer dependency for Elysia.js 1.2.25. It may or may not work on 2.x

- 💀 Minimum [elysia](https://www.npmjs.com/package/elysia) Version: `1.2.25`

&nbsp;

## **_Usage:_**

### To install the package, type the following in console

> ```zsh
> npm add @best-skn/elysia-helmet
> #or
> yarn add @best-skn/elysia-helmet
> #or
> pnpm add @best-skn/elysia-helmet
> #or
> bun add @best-skn/elysia-helmet
> ```

### Basic Usage

```typescript
import { Elysia } from "elysia";
import { elysiaHelmet } from "@best-skn/elysia-helmet";

const app = new Elysia()
  .use(elysiaHelmet({}))
  .get("/", () => "Hello, Secure World!")
  .listen(3000);
```

> **Note**: Production mode is automatically enabled when `NODE_ENV` is set to `'production'`. In production mode, additional security measures are enforced.

### Advanced Configuration

```typescript
import { Elysia } from "elysia";
import { elysiaHelmet, permission } from "@best-skn/elysia-helmet";

const app = new Elysia()
  .use(
    elysiaHelmet({
      csp: {
        defaultSrc: [permission.SELF],
        scriptSrc: [permission.SELF, permission.UNSAFE_INLINE],
        styleSrc: [permission.SELF, permission.UNSAFE_INLINE],
        imgSrc: [permission.SELF, permission.DATA, permission.HTTPS],
        useNonce: true,
      },
      hsts: {
        maxAge: 31536000,
        includeSubDomains: true,
        preload: true,
      },
      frameOptions: "DENY",
      referrerPolicy: "strict-origin-when-cross-origin",
      permissionsPolicy: {
        camera: [permission.NONE],
        microphone: [permission.NONE],
      },
    })
  )
  .listen(3000);
```

### Types Usage

```typescript
import type { CSPConfig, HSTSConfig, ReportToConfig, SecurityConfig } from "@best-skn/elysia-helmet";
```

#### These types are extremely useful if you want to define configurations in separate files

#### See `Configuration Options` below to get the type info

### Configuration Options

#### Content Security Policy (CSP)

```typescript
export interface CSPConfig {
  /** Default source directive */
  defaultSrc?: string[];
  /** Script source directive */
  scriptSrc?: string[];
  /** Style source directive */
  styleSrc?: string[];
  /** Image source directive */
  imgSrc?: string[];
  /** Font source directive */
  fontSrc?: string[];
  /** Connect source directive */
  connectSrc?: string[];
  /** Frame source directive */
  frameSrc?: string[];
  /** Object source directive */
  objectSrc?: string[];
  /** Base URI directive */
  baseUri?: string[];
  /** Report URI directive */
  reportUri?: string;
  /** Use nonce for script and style tags */
  useNonce?: boolean;
  /** Report-only mode */
  reportOnly?: boolean;
}
```

#### HSTS Configuration

```typescript
export interface HSTSConfig {
  /** Maximum age */
  maxAge?: number;
  /** Include sub-domains */
  includeSubDomains?: boolean;
  /** Preload */
  preload?: boolean;
}
```

#### Report-To Configuration

```typescript
export interface ReportToConfig {
  /** Group name for the endpoint */
  group: string;
  /** Maximum age of the endpoint configuration (in seconds) */
  maxAge: number;
  /** Endpoints to send reports to */
  endpoints: Array<{
    url: string;
    priority?: number;
    weight?: number;
  }>;
  /** Include subdomains in reporting */
  includeSubdomains?: boolean;
}
```

#### Security Configuration

```typescript
export interface SecurityConfig {
  /** Content Security Policy configuration */
  csp?: CSPConfig;
  /** Enable or disable X-Frame-Options (DENY, SAMEORIGIN, ALLOW-FROM) */
  frameOptions?: "DENY" | "SAMEORIGIN" | "ALLOW-FROM";
  /** Enable or disable XSS Protection */
  xssProtection?: boolean;
  /** Enable or disable DNS Prefetch Control */
  dnsPrefetch?: boolean;
  /** Configure Referrer Policy */
  referrerPolicy?:
    | "no-referrer"
    | "no-referrer-when-downgrade"
    | "origin"
    | "origin-when-cross-origin"
    | "same-origin"
    | "strict-origin"
    | "strict-origin-when-cross-origin"
    | "unsafe-url";
  /** Configure Permissions Policy */
  permissionsPolicy?: Record<string, string[]>;
  /** Configure HSTS (HTTP Strict Transport Security) */
  hsts?: HSTSConfig;
  /** Enable or disable Cross-Origin Resource Policy */
  corp?: "same-origin" | "same-site" | "cross-origin";
  /** Enable or disable Cross-Origin Opener Policy */
  coop?: "unsafe-none" | "same-origin-allow-popups" | "same-origin";
  /** Configure Report-To header */
  reportTo?: ReportToConfig[];
  /** Custom headers to add */
  customHeaders?: Record<string, string>;
}
```

#### Permission Configuration

```typescript
export const permission = {
  /** Source: Self allowed */
  SELF: "'self'",
  /** Source: Unsafe Inline allowed */
  UNSAFE_INLINE: "'unsafe-inline'",
  /** Source: HTTPS allowed */
  HTTPS: "https:",
  /** Source: Data allowed */
  DATA: "data:",
  /** Source: None is allowed */
  NONE: "'none'",
  /** Source: Blob allowed */
  BLOB: "blob:",
} as const;
```

### Default Configuration

The middleware comes with secure defaults:

- CSP with `'self'` as default source
- Frame options set to `DENY`
- XSS Protection enabled
- DNS Prefetch Control disabled
- Strict Referrer Policy
- And more secure defaults

You can override any of these defaults by passing your own configuration.

&nbsp;

## **_Dedicated To:_**

- 👩‍🎨`Prodipta Das Logno` & 🧛‍♀️`Atoshi Sarker Prithula`: The two most special ladies of my life. My best wishes will always be with you two. May you two always be happy.
- 💯`My Parents`: The greatest treasures of my life ever.

&nbsp;

## **_License:_**

Copyright (C) 2024 SKN Shukhan

Licensed under the MIT License

&nbsp;

## **_Credits:_**

- All credits for building the logic goes to [aashahin](https://github.com/aashahin)
