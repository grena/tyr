# TYR

**TYR** helps any Akeneo PIM developer to know **how to launch a test file** with the correct commands.

## How to use?
Install the CLI tool on your machine:
```bash
# Download the .sh script
wget https://raw.githubusercontent.com/grena/tyr/main/tyr.sh && chmod +x tyr.sh

# Make it available as a global command line
sudo mv tyr.sh /usr/local/bin/tyr
```

Now, when you want to know how to run a test, just type:
```bash
tyr full/path/to/your/TestFile.php  # make sure it's the path relative to the root of the project 
```

## How does it work?

![](https://i.imgur.com/wzU4lou.jpg)

## How to add instructions to run a test?
This tool is based on some `.yml` config files in the [`config/instructions`](https://github.com/grena/tyr/tree/main/config/instructions) folder, they are really simple, take a look at them.

1) Fork this repo or make the edit through GitHub web interface.
2) Either **create or edit a `.yml` file** in the [`config/instructions`](https://github.com/grena/tyr/tree/main/config/instructions) folder:
```yaml 
software: "pim-community-dev" # could be "pim-enterprise-dev", it's the name of the project in the composer.json file
version: "master"             # could a specific version, such as "6.0", "5.0", etc.

# Instructions live in this data array
data:
  -
    comment: "A unit test with PHPSpec" # Optional comment to help you organise the instructions
    
    # Any file starting with these folders will respond to the command.
    # Given folders are relative to the root of the project.
    folders:
      - "tests/back/Acceptance/spec/"
      - "tests/back/Channel/Specification/"
      - "src/Akeneo/Channel/back/tests/Specification/"
      
    # The commands to run the test.
    # You can use the {{FILEPATH}} variable, it will be replaced by the path of the file the user gave.
    commands:
      - "APP_ENV=test docker-compose run -u www-data --rm php php vendor/bin/phpspec run {{FILEPATH}}"
```
3) **Merge** your new instructions into the `main` branch.
4) **Deploy TYR on Heroku**!

The new instructions will be available for everyone, you don't need to re-install the CLI tool obviously.

## Why Tyr?
> Týr sacrifices his hand to the monstrous wolf Fenrir, who bites it off when he realizes the gods have bound him.
