<p align="center"><img  width="460" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large_dark_mode.png#gh-dark-mode-only"></p>

<p align="center">
  <img  width="460" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large.png#gh-light-mode-only">
</p>

<p align="center">
  <h1 align="center" >autobot</h1>
</p>

<p align="center">
  <h6 align="center" >A command line tool for automating common development tasks like generate files, manage environment, configure projects or setup for CI.</h6>
</p>


## Installation

1. Install Dart following [these](https://dart.dev/tutorials/server/get-started#2-install-dart) instructions.

2. Activate autobot running the following command:
```bash
$ dart pub global activate autobot  
```

## Commands

### **version**

Prints the autobot version.
```bash
$ autobot version
```

### **init**
Initializes a `autobot_config.yaml` in the working directory. 
```bash
$ autobot init
```
Use `init -g` to initialize a global config file in your home directory.
```bash
$ autobot init -g
```

### **run**
The run command has the `-t`(`template`) option. Use `run -t <template_file_name_without_yaml_extension>` to run a template. 
```bash
$ autobot run -t myTemplateName
```

Make sure that you have either initialized a directory specific `autobot_config.yaml` or a global `.autobot_config.yaml` using the `init` command. The template file must be places inside the `templateDirectory` which can be definid in the `autobot_config.yaml` file.

#### Input values in CI
Since a CI doesn't support interactive script execution, `autobot` offers the possibility to set input values via arguments using the `-i` or `--input` option:
```bash
$ autobot run -t myTemplateName -i userName=somename,userAge=23
```
This will skip the interactive command line prompt for all given values.

## Templates
A autobot template is a [yaml file](https://yaml.org). It describes what autobot has to do.

### **inputs**
Add a list of inputs to tell autobot that you need some information from the user.

```yaml
inputs:
  - key: userName
    prompt: What is your name?
  - key: userAge
    prompt: How old are you?
```

Running this template, autobot will print the two prompts to the user and assign the
input values to the keys.

### **outputs**
Add a list of outputs to tell autobot that you what to write some files.

```yaml
inputs:
  - key: userName
    prompt: What is your name?
  - key: userAge
    prompt: How old are you?

outputs:
  - path: some/relative/path.txt
    write: true
    content: Hi {{ userName }}
  - path: /some/non_relative/path.txt
    write: true
    content: |
      Hi {{ userName }},
      is it true that you are {{ userAge }} years old?
```

Autobot uses [mustache](http://mustache.github.io) to redner the output fields. This means that you can use the input keys to render dynamic values in `path`, `write` or `content`, `writeMethod` field of a output definiton.

#### Fields
| Name          | Description                                                                                         | Value                                                   | Example                                                                                    |
| ------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `path`        | The output path of the file which will contain the `content`                                        | any valid path                                          | `path: some/path/relative_to/working_directory/filename.txt`                               |
| `write`       | Whether to write the output or not                                                                  | `true`, `yes`, `y` or `false`, `no`, `n`                | `write: yes`                                                                               |
| `writeMethod` | The method which should be used for creating the file                                               | `keepExistingFile`, `replaceExistingFile`, `extendFile` | `writeMethod: extendFile`                                                                  |
| `extendAt`    | The position where the file should be extended. This field works only for `writeMethod: extendFile` | `top`, `bottom` or any reqular expression.              | `extendAt: top` or `extendAt: top` or `extendAt: some text that matches a part of content` |

## autobot_config
The `autobot_config.yaml` is necessary for some commands like `run`.

The following fields are supported:

- `templateDirectory`: **String**
  Allows to define a directory path where autobot should search for templates.
- `environmentFilePaths`: **String array**
  Allows to define yaml files from which autobot should read the key-value pairs and insert them into its environment.

## Environment
Autobot automatically reads all variables from the environment and uses them for rendering outputs. So you can expose any variables to the environment in order to give autobot access to them. Alternatively you can define some yaml files containing key-value pairs and set the path to `environmentFilePaths` of `autobot_config.yaml`. Autobot will automatically read all the key-value pairs of the file and insert them into its environment.

**environment.yaml**
```yaml
apiKey: faij0394jfh3q490herfae
secret: fj390;rea009hjhj09dj
baseUrl: https://www.some_random_url.io
```

**autobot_config.yaml**
```yaml
config:
  templateDirectory: some/path/to/template_directory/
  environmentFilePaths: 
    - /some/path/to/environment.yaml
```

**Use values from environment inside template**
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
```