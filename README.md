<!-- <p align="center">
  <img width="240" height="240" src="assets/aoutobot_logo.png">
</p> -->

<p align="center">
  <img  height="240" src="https://github.com/DeveloperZoneIO/autobot/raw/develop/assets/aoutobot_logo_large.png">
</p>


<p align="center">
  <h1 align="center" >autobot</h1>
</p>

<p align="center">
  <h6 align="center" >A command line tool for automating common development tasks like generate files, manage environment, configure projects or setup for CI.</h6>
</p>


## Installation

1. Install Dart following [this](https://dart.dev/tutorials/server/get-started#2-install-dart) instructions.

2. Activate autobot running the following command:
```bash
$ dart pub global activate autobot  
```

## Usage

### Build in commands

#### `version`
Prints the autobot version.

#### `init`
Initializes a `autobot_config.yaml` in the working directory.
Use `init -g` to initialize a global config file in your home directory.

#### `run`
The run command has the `-t`(`template`) option.
Use `run -t <template_file_name_without_yaml_extension>` to run a template.
Make sure that you have either initialized a directory specific `autobot_config.yaml` or a global `.autobot_config.yaml` using the `init` command. The template file must be places inside the `templateDirectory` which can be definid in the `autobot_config.yaml` file.

### Templates
A autobot template is a [yaml file](https://yaml.org). It describes what autobot has to do.

#### inputs
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

#### outputs
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

Autobot uses [mustache](http://mustache.github.io) to redner the output fields. This means that you can use the input keys to render dynamic values in `path`, `write` or `content` field of a output definiton.

### autobot_config
The `autobot_config.yaml` is necessary for some commands like `run`.
Currently it support only the `templateDirectory` field. This allows for defining in which directory autobot should search for templates.