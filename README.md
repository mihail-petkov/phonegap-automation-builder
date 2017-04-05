# phonegap-automation-builder
Automate uploading builds to PhoneGap.

## Description

phonegap-automation-builder allows users to automate the procees of creating new zip archives and uploading them to PhoneGap application through the terminal.


## Dependencies

    $ gem install rubyzip

## Usage

### Without parameters

**Note:** If you want to run the script without parameters, you should edit the constants in the script.

```bash
  ruby phonegap-builder.rb
```


### With parameters

```bash
  ruby phonegap-builder.rb application/source 1234567 email@phonegap.com application.zip
```
where

 - *application/source* - path to the source folder
 - *1234567* - PhoneGap application id
 - *email@phonegap.com* - email account related to application id
 - *application.zip* - name of the generated zip
