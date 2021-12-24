<p align="center"><img  width="460" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large_dark_mode.png#gh-dark-mode-only"></p>

<p align="center">
  <img  width="460" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large.png#gh-light-mode-only">
</p>

Autobot is a command-line templating engine for automating standardised repetitive operations, such as creating a new project with a specific folder structure or creating files and classes according to a predefined scheme to ensure compliance with architectural specifications. Autobot can also be used for configuring projects by creating build configurations both locally and in the CI.

- [Installation](#installation)
- [Configuration](#configuration)
- [Run an autobot-task](#run-an-autobot-task)
- [autobot-task](#autobot-task)
  - [inputs](#inputs)
  - [scripts](#scripts)
  - [outputs](#outputs)
- [Autobot and CI](#autobot-and-ci)
- [Environment](#environment)

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
Autobot requires a configuration file named `autobot_config.yaml`. It can be located in the working direktory or in the home directory. The configuration is a YAML file and can be easily created using the `init` command.

Create a `autobot_config.yaml` in the working directory:
```bash
$ autobot init
```
Create a `.autobot_config.yaml` in the home directory:
```bash
$ autobot init -g
```

All configurations fields must belong to the `config` field.
The following fields are supported:

- `templateDirectory` | **String**
  Allows to define a directory path where autobot should search for autobot-tasks.
- `environmentFilePaths`: | **List of String**
  Allows to define paths of yaml files that autobot should read in to make its values available for the `scripts` and `outputs` sections.

**Example: autobot_config.yaml**
```yaml
config:
  templateDirectory: some/relative_path/to_tasks_directory/
  environmentFilePaths:
    - some_file_in_working_directory.yaml
    - /User/some_dir/urs/some_environment_file.yaml
```

# Run an autobot-task
Assuming that there is a autobot-task named `create_app.yaml` on your machine,
the command to run it be the following:
```bash
$ autobot run -t create_app
```
Please make sure that autobot can make use of `create_app.yaml` by setting its directory path to `templateDiectory` in `autobot_config.yaml`.

# autobot-task
A autobot-task is a YAML file that describes what needs to be done. It consists of three optional sections: inputs, scripts and outputs.

**example-autobot-task.yaml**
```yaml
inputs:
  - key: userName
    prompt: What is your name?
  - key: userAge
    prompt: How old are you?

scripts:
  - js: |
      // Read the userName value from autobot
      var userName = autobot.inputs.userName

      // Check whether userName is blank. If yes, set a fallback value.
      if (!userName || userName.length === 0) {
        autobot.inputs.userName = 'Some fallback name'
      }

      // Define a new variable
      autobot.inputs.varFormJs = 'Hello!'

outputs:
  - path: some/relative/path.txt
    content: Hi {{userName}}
  - path: /some/non_relative/path.txt
    content: |
      Hi {{userName}},
      is it true that you are {{userAge}} years old?
      This is a value from javascript: {{varFormJs}}
```

## inputs
The `inputs` field accepts only a list of prompt objects. A prompt object requires a `key` and a `prompt`. Such an object describes with `prompt` what autobot should ask the user via the command line and with `key` that the value entered by the user should be assigned to this key. These keys can be used in the `scripts` and `outputs` sections to access the values.

## scripts
The `scripts` field accepts a list of script objects. A scrip object requires a script key which is either `js` (this stands for javascript) or `shell`. The value of those keys hast to be a string containing the related script.

Autobot provides the `autobot` object to all javascripts for accessing and modifing variables. The variables are contained in the `autobot.inputs` object. See the `scripts` in the example-autobot-task.yaml above.
**NOTE**: Running javascripts requires that `node` is installed in your comman line tool! Otherwise autobot will fail executing the javascripts.
## outputs
The `outputs` field accepts a list of output objects. An output object must contain at least the following keywords: `path` and `content`. `path` defines where a new file will be created and `content` defines the content of this file. See the available fields of output object in the list below. All values of the output object fileds can be a [mustache](https://mustache.github.io) template. This means that the string values can have variables enclosed in double or triple curly braces, like for example `"Hello {{userName}}"`. `{{userName}}` will then be replaced by the value assigned to `userName`.

| Field         | Description                                                                                         | Value                                                   | Example                                                                                    |
| ------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `path`        | The path where the new file should be created                                                       | any valid path                                          | `path: some/path/relative_to/working_directory/filename.txt`                               |
| `write`       | Whether to write the file or not                                                                    | `true`, `yes`, `y` or `false`, `no`, `n`                | `write: yes`                                                                               |
| `writeMethod` | The method which should be used for creating the file                                               | `keepExistingFile`, `replaceExistingFile`, `extendFile` | `writeMethod: extendFile`                                                                  |
| `extendAt`    | The position where the file should be extended. This field works only for `writeMethod: extendFile` | `top`, `bottom` or any reqular expression.              | `extendAt: top` or `extendAt: top` or `extendAt: some text that matches a part of content` |

# Autobot and CI
Since a CI doesn't support interactive scripts, `autobot` offers the possibility to set input values via arguments using the `-i` or `--input` option:
```bash
$ autobot run -t some_autobot_task -i userName=somename,userAge=23
```
This will skip the interactive command line prompt for all given values.


# Environment
Autobot automatically reads all variables from the environment and provides them to `scripts` and `outputs`. So you can expose any variables to the environment in order to give autobot access to them. This is very helpful if you want autobot to use variables from your CI or if you want integrate autobot into so existing processes or cli commands. 
Alternatively autobot can read yaml files (defined in `environmentFilePaths` of the `autobot_config.yaml`) and insert them into its environment, so that they can be used in `scripts` and `outputs`. See the following example:

**my_environment.yaml**
```yaml
apiKey: faij0394jfh3q490herfae
secret: fj390;rea009hjhj09dj
baseUrl: https://www.some_random_url.io

someMap:
  var: 1
  var: 2
  var: 3
```

**autobot_config.yaml**
```yaml
config:
  templateDirectory: some/path/to/template_directory/
  environmentFilePaths: 
    - /some/path/to/my_environment.yaml
```

**Use values from environment file in outputs**
```yaml
inputs:
  ...

outputs:
  - path: some/relative_path/build_config.dart
    content: |
      class BuildConfig {
        static const String someApiKey = "{{apiKey}}";
        static const String someSecret = "{{secret}}";
        static const String someBaseUrl = "{{baseUrl}}";
      }
  - path: some/relative_path/count.txt
    content: |
      {{#someMap}}
        - {{var}}
      {{/someMap}}
```

The content of the first file will be:
```txt
class BuildConfig {
  static const String someApiKey = "faij0394jfh3q490herfae";
  static const String someSecret = "fj390;rea009hjhj09dj";
  static const String someBaseUrl = "https://www.some_random_url.io";
}
```
The content of the second second will be:
```txt
- 1
- 2
- 3
```