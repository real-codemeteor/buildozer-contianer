# Buildozer Containerized

This is a containerized version of [Buildozer](https://buildozer.readthedocs.io/en/latest). It has a handy initialization script that will build the image when it is not already available on your system. It also creates an alias allowing you to run buildozer as if installed as a native application.

## Prerequisites

- Docker CLI
- git
- Linux

## Installation

Clone the git repository to the desired location.

```bash
git clone https://github.com/real-codemeteor/buildozer-contianer.git ~/buildozer
```

Now create an alias to the ```buildozer.sh``` script.

```bash
alias buildozer='~/buildozer/buildozer.sh'
```

## Usage

After installation, you can simply run buildozer as how you normaly would.
The first time the container image will be pulled, after this it should behave like the native buildozer program.

On more info on how to use buildozer, refer to the [documentation](https://buildozer.readthedocs.io/en/latest).
