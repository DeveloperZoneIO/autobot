<p align="center"><img  width="460" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large_dark_mode.png#gh-dark-mode-only"></p>

<p align="center">
  <img  width="460" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large.png#gh-light-mode-only">
</p>

<p align="center">
<!-- version badge -->
<a href="https://pub.dev/packages/autobot"><img src="https://img.shields.io/pub/v/autobot?logo=dart" alt="Pub"></a>
<!--pub points badge -->
<a href="https://pub.dev/packages/autobot/score"><img src="https://badgen.net/pub/points/autobot" alt="autobot pub score"></a>
<!-- release status badge -->
<a href="https://github.com/DeveloperZoneIO/autobot/actions/workflows/deploy_production.yml"><img src="https://github.com/DeveloperZoneIO/autobot/actions/workflows/deploy_production.yml/badge.svg" alt="pipeline/ci release status"></a>
<!-- develop status badge -->
<a href="https://github.com/DeveloperZoneIO/autobot/actions/workflows/test_develop.yml"><img src="https://github.com/DeveloperZoneIO/autobot/actions/workflows/test_develop.yml/badge.svg" alt="pipeline/ci delevop status"></a>
<!-- platform badge -->
<a href="https://dart.dev/overview"><img src="https://badgen.net/pub/dart-platform/autobot" alt="dart supported platforms"></a>
<!-- dart sdk badge -->
<a href="https://dart.dev/get-dart"><img src="https://badgen.net/pub/sdk-version/autobot" alt="dart sdk version"></a>
<!-- license badge -->
<a href="https://github.com/DeveloperZoneIO/autobot"><img src="https://badgen.net/github/license/DeveloperZoneIO/autobot" alt="MIT-license"></a>
</p>

Autobot is a command-line templating engine for automating standardised repetitive operations, such as creating a new project with a specific folder structure or creating files and classes according to a predefined scheme to ensure compliance with architectural specifications. Autobot can also be used for configuring projects by creating build configurations both locally and in the CI.

- [Installation](#installation)
- [Configuration](#configuration)
- [Tasks](#tasks)
  - [Available steps](#available-steps)
    - [ask](#ask)
    - [command](#command)
    - [javascript](#javascript)
    - [read](#read)
    - [runTask](#runtask)
    - [vars](#vars)
    - [write](#write)
- [Environment](#environment)
- [Autobot and CI](#autobot-and-ci)
- [Examples](#examples)
  - [Javascript example](#javascript-example)
  - [Read example](#read-example)

# Installation

1. Install Dart following [these](https://dart.dev/tutorials/server/get-started#2-install-dart) instructions.

2. Activate autobot running the following command:

```bash
$ dart pub global activate autobot
```

Check for the autobot version to see if autobot was successfully installed:

```bash
$ autobot version
```

# Configuration

Autobot needs a `.autobot_config.yaml` file. Create a local or global one via the following commands:

```bash
# creates local config file in current working directory
$ autobot init
```

```bash
# creates local config file in given path (-p)
$ autobot init -p subfolder/subsubfolder/
```

```bash
# creates global config file in home directory
$ autobot init -g
```

This is a `.autobot_config.yaml` with all available configuration.

```yaml
config:
  # tell autobot where is should search for tasks
  taskDir: some/relative_path/to_tasks_directory/
```

# Tasks

Run an autobot task via the following command:

```bash
# assuming there is a my_task.yaml inside taskDir
$ autobot run --task my_task
# use -t instead of --task if you like short cuts :)
```

You can also omit `run --task` if you want:
```bash
$ autobot my_task
```

Autobot tasks are YAML files witch describe what needs to be done.

Pass flags to a task using `:` as prefix like so:
```bash
$ autobot my_task:first_flag:second_flag
```
Autobot assigns the flags to keys with the following schema `flag<index>`:
This means that the first flag will be assigned to `flag1`, the second will be assigned to `flag2` and so on.

You can add some meta data like name and description to a task like this:

```yaml
meta:
  name: My task
  description: This is my autobot task
```

Use `steps` to define the actuall work like this:

```yaml
meta:
  name: My task
  description: This is my autobot task

steps:
  - read:
    file: some/path/to/file.yaml

  - ask:
    key: name
    prompt: Whats your name?

  - ask:
    key: age
    prompt: How old are you?

  - write:
    file: some/path/output_file.txt
    content: My name is {{name}} and I'm {{age}} years old.
```

## Available steps

Check out all available steps. Keep in mind that all fields of all steps (except `vars`) can be [mustache](https://mustache.github.io) templates for dynamic customization. Check out the [Examples](#examples) for more details.

### ask

Asks the user for input and assigns that input to the key.

```yaml
- ask:
  key: # String -> the key the value should be asssigned to
  prompt: # String -> the prompt to print
```

### command

Runs a shell command.

```yaml
- command:
  run: # String -> shell command
```

### javascript

Runs a javascript.
**NOTE**: Requires that `node` is installen in your commond line tool.

```yaml
- javascript:
  run: # String -> javascript
```

### read

Reads a yaml file. The data can then be used in other spets like `write` or `javascript`.

```yaml
- read:
  file: # String -> path of yaml file
```

### runTask

Runs a sub task.

```yaml
- runTask:
  file: # String -> name of that which is loacted in taskDir of .autobot_config.yaml
```

### vars

Define some data that can be used in other steps like `write` or `javascript`.

```yaml
- vars:
  key: value # some key value pair
  dataArray: [a, b c] # some array
  dataMap:
    key: value
    key2: value2
  otherDataArray:
    - a
    - b
    - c
  someText: |
    Lorem ipsum...
```

### write

Writes a file.

```yaml
- write:

  # The path of the file which should be written
  file:

  # Whether writting is enabled or not.
  enabled: # n, no, false or y, yes, true

  # How the file should be written
  writeMethod: # keepExistingFile (default), replaceExistingFile, extendFile

  # Works only if writeMethod is extendFile
  extendAt: # Values: top, bottom, custom regex.

  # The content of the file
  content:
```

# Environment

Autobot automatically reads all variables from the environment and provides them to all steps. This is very helpful if you want autobot to use variables from your CI or if you want integrate autobot into so existing processes or cli commands.

# Autobot and CI

Since a CI doesn't support interactive scripts, `autobot` offers the possibility to set input values via arguments using `-i` or `--input`:

```bash
$ autobot run --task some_autobot_task --input userName=somename,userAge=23
```

This will skip the interactive command line prompt for all set values.

# Examples

## Javascript example

```yaml
steps:
  - aks:
    key: userName
    prompt: What is your name?

  - ask:
    key: userAge
    prompt: How old are you?

  - javascript:
    run: |
      // Access the value of userName
      var userName = autobot.variables.userName
      // Check whether userName is blank. If yes, set a fallback value.
      if (!userName || userName.length === 0) {
        autobot.variables.userName = 'Some fallback name'
      }
      // Define a new variable
      autobot.variables.varFormJs = 'Hello!'

  - write:
    file: some/relative/path.txt
    content: Hi {{userName}}

  - write:
    file: /some/non_relative/path.txt
    content: |
      Hi {{userName}},
      is it true that you are {{userAge}} years old?
      This is a value from javascript: {{varFormJs}}
```

This example task ask the user for his name and age and will create two files.
The first file will be `$pwd/some/relative/path.txt` with the following content:

```
Hi Peter
```

The second file will be `/some/non_relative/path.txt` with the following content:

```
Hi Peter,
is it true that you are 30 years old?
This is a value from javascript: Hello!
```

## Read example

Assuming there is a yaml file like this on your machine called `task_data.yaml`:

```yaml
key1: value1
key2: value2

varMap:
  mapKey1: mapValue1
  mapKey2: mapValue2

varList:
  - key: a
  - key: b
  - key: c
```

The task:

```yaml
steps:
  - read:
    file: task_data.yaml

  - write:
    file: output.txt
    content: |
      Pairs: {{key1}}, {{key2}}
      Map pairs: {{varMap.mapKey1}} {{varMap.mapKey2}}
      List:
      {{#varList}}
        -> {{key}} <-
      {{/varList}}
```

Tis task will read the `task_data.yaml` and create the following file:

```
Pairs: value1, value2
Map pairs: mapValue1 mapValue2
List:
  -> a <-
  -> b <-
  -> c <-
```
