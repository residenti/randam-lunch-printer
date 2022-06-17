# randam-lunch-printer

## Installation
### Using Homebrew (Linux, macOS)
If you’re using Homebrew or Linuxbrew, install the lunch formula:
```
brew install residenti/lunch/lunch
```

### Using Git
```
% git clone git@github.com:residenti/randam-lunch-printer.git
% cd randam-lunch-printer
% stack install
```

### From binaries (Linux, macOS, Windows)
Download [the release binary](https://github.com/residenti/randam-lunch-printer/releases) for your system.
Set the PATH environment variable.

## Setup
Prepare "Lunch Category List" (`lunch` command randomly prints Lunch Category from this "Lunch Category List").  
Execute the following command to create "Lunch Category List"!
```
% lunch --setup
```
"Lunch Category List" is just `$HOME/categories.csv`. So it is possible to prepare on your own.

## Usage
To decide what to eat for lunch, Just execute `lunch` comand!!!
```
% lunch
イタダキマ～ス♪(●人´∀｀) ＼ステーキ／
```
