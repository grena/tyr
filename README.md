# TYR - How to run this test?

**TYR** helps any Akeneo PIM developer to know **how to launch a test file** with the correct commands.

## How to use?
Install the CLI tool on your machine:
```bash
wget https://raw.githubusercontent.com/grena/tyr/main/tyr.sh && chmod +x tyr.sh
sudo mv tyr.sh /usr/local/bin/tyr
```

Now, when you want to know how to run a test, just type:
```bash
tyr full/path/to/your/TestFile.php
```
**Important: make sure you give the path relative to the project (eg. not `DoctrineJobRepositoryIntegration.php` but `tests/back/Integration/integration/BatchBundle/Job/DoctrineJobRepositoryIntegration.php`)**

## How to add instructions to run a test?
This tool is based on some `.yml` config files in the https://github.com/grena/tyr/tree/main/config/instructions folder, they are really simple, take a look at them.

1) Fork this repo or make the edit through GitHub web interface.
2) Either create a new `.yml` file or edit an existing one in the `config/instructions/` folder.
3) Tell for which `folders` the command applies.
4) Gives the correct `commands` to run the test.


## Development
To develop the API of this tool, you need `docker` && `docker-compose`.
Fork this repo, then:
```bash
make setup
make up
```

## Why Tyr?
> Týr sacrifices his hand to the monstrous wolf Fenrir, who bites it off when he realizes the gods have bound him.
