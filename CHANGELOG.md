## 0.6.2

- Fix shortcuts

## 0.6.1

- Run task directly without writting `run --task` (optional)
- Pass flags to a task: `autobot run --task some_task:flag1:flag2`

## 0.6.0

[BREAKING CHANGES]

- Rename `--template` argument to `--task`
- Fix readme

## 0.5.6-experimental

[BREAKING CHANGES]

- Change config filed `templateDirecory` to `taskDir`
- Remove config file `environmentFilePaths` -> Use `read` step instead

## 0.5.5-experimental

- Render all `read` and `runTask` fields

## 0.5.4-experimental

[BREAKING CHANGES]

- Change task layout

## 0.5.3

- Add path option for init command

## 0.5.2

- Render mustache templates in shell script
- Test shell scripts

## 0.5.1+1

- Add tests

## 0.5.0+1

- Support for nested mustache variabels
- Allwos for adding shell scripts to the script section
- Adds the `input-file` option argument for reading variables from a yaml file

## 0.4.0

- Allow javascript section in template

## 0.3.0+2

- Allow to set input value via arguments

## 0.2.0

- Allow `writeMethod` field for template outputs

## 0.1.0

- Include environment variables for rendering outputs
- Read yaml file and expose its variables to environment

## 0.0.0+8

- Add readme and wiki

## 0.0.0+5

- Fix reading pubspec

## 0.0.0+4

- Add executable.

## 0.0.0+3

- Initial version.
