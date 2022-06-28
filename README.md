# randam-lunch-printer

## Installation

### Using Git
```
% git clone git@github.com:residenti/randam-lunch-printer.git
% cd randam-lunch-printer
% stack install
```

### From binaries
Download [the release binary](https://github.com/residenti/randam-lunch-printer/releases) for your system.
Set the PATH environment variable.

## Usage

### 1. Put Lunch Category
```
% lunch
イタダキマ～ス♪(●人´∀｀) ＼ステーキ／
```
`lunch` command randomly prints Lunch Category from "Lunch Category List".  
This "Lunch Category List" is just `$HOME/categories.csv`. So it is possible to prepare on your own and be customized.

### 2. Put Lunch Shop
one randomly selected shop within 1000m of the specified latitude and longitude.
```
# `--s ${latitude} ${longitude}`
% lunch --s 35.658584 139.7454316
サンプル焼肉ショップ
```
