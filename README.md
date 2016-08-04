# qing-build

General build scripts for all qing module.

## Installation

Install via npm:

```bash
npm install --save-dev qing-module
```

## Usage

Set build configuration in `gulpfile.coffee` in your component:

```coffee
gulp = require 'gulp'
build = require 'qing-build'
pkg = require './package.json'

build
  gulp: gulp
  name: pkg.name
  githubOwner: 'mycolorway'
  version: pkg.version
  homepage: pkg.homepage
  umd:
    dependencies:
      cjs: Object.keys(pkg.dependencies)
      global: ['jQuery', 'QingModule']
      params: ['$', 'QingModule']
  karma:
    dependencies: [
      'node_modules/jquery/dist/jquery.js'
      'node_modules/qing-module/dist/qing-module.js'
    ]
```

`qing-build` will register four gulp tasks for you: default, compile, test and publish.
