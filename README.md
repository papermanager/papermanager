<div align="center">
  <h1>
    Paper Manager
  </h1>
  <p align="center">
    <strong>Academic publication manager for Joomla! - Component & plugin.</strong>
  </p>

[Download (Joomla 4.x)](https://github.com/papermanager/papermanager/releases) | [Download (Joomla 3.x)](https://github.com/papermanager/papermanager/releases/tag/v0.0.1-joomla3.x)

For installation and usage instructions please refer to the [documentation](https://papermanager.github.io).

  <img src="https://img.shields.io/github/v/release/papermanager/papermanager" alt="GitHub release (latest by date)" />
  <img src="https://img.shields.io/badge/Joomla!-4.x-yellow" alt="Joomla4x" />
  <img src="https://img.shields.io/badge/Joomla!-3.x-yellow" alt="Joomla3x" />
  <img src="https://img.shields.io/badge/php-%3E%3D8.0-787CB5" alt="PHP80" />
  <a href="./LICENSE">
    <img src="https://img.shields.io/github/license/papermanager/papermanager" alt="License" />
  </a>
</div>

## About Paper Manager

Paper Manager is a Joomla extension allowing the management of scientific publications. The extension is useful for websites related to research laboratories and organizations. Lists of scientific papers are commonly present in such websites. A single paper can be included in more than one of these lists. For example it can be shown on a page dedicated to the conference publications of the lab and also on the profile pages of the authors. Paper Manager allows a specific paper entry to be displayed on multiple pages without copying html code on all the relative articles. The extension consists of a component and a content plugin. The component is used for CRUD operations on papers, paper categories and authors while the plugin displays lists of papers inside content (ex. articles), using special code snippets.

Paper Manager is developed for **Joomla 4.x** and any future updates will be checked for compatibility only with **4.x**.
If you need to install Paper Manager on **Joomla 3.x**, use [version 0.0.1-joomla3.x](https://github.com/papermanager/papermanager/releases/tag/v0.0.1-joomla3.x).

## Developer Notes

The following notes are for development purposes only. For installation and usage instructions please refer to the **[documentation](https://papermanager.github.io/).**

### Prerequisites / Development Dependencies

- `Docker` & `Docker Compose` for the development environment.
- `Bash`, `Make` & `PHP` for running the development scripts.
- [WSL2](https://docs.microsoft.com/en-us/windows/wsl/) and [Git Bash](https://gitforwindows.org/) can both be used to run the development scripts on Windows.
- (Optionally) `PhpStorm` for step debugging.

### Build Setup

- `git clone git@github.com:papermanager/papermanager.git` to clone this repository.
- `cd papermanager` to go into the *papermanager* directory.
- `./scripts/dependencies.sh` to check if the dependencies are installed.
- `make up` to run the Docker containers.
- If running for the first time, wait until the files in `JOOMLA_INSTALLATION_DIR` (see `./scripts/environment.sh`) are generated.
- Navigate to `http://localhost:8080` and set Joomla up.
- `make build` to build the extension. A zip file will be generated in the `./dist` directory. Install it manually in the Joomla development environment.

### Step Debugging with PhpStorm

- Make sure all steps in the **Build Setup** section were followed.
- Install one of the Xdebug browser extensions: [https://xdebug.org/docs/step_debug#browser-extensions](https://xdebug.org/docs/step_debug#browser-extensions)
- `make map` to start the docker containers with the files in `./src` mapped to the joomla installation. This will automatically generate `docker-compose.map.yml`.
- Open the project in PhpStorm, go to `File -> Settings -> PHP -> Frameworks -> Joomla!` and set:
    - The absolute path to `docker/www` as the *Joomla installation path*. (e.g. `C:\MyProjects\papermanager\docker\www` on Windows or `/home/user/MyProjects/papermanager/docker/www` on Linux)
    - The absolute path to `docker/www/configuration.php` as the *Path to JConfig*. (e.g. `C:\MyProjects\papermanager\docker\www\configuration.php` on Windows or `/home/user/MyProjects/papermanager/docker/www/configuration.php` on Linux)
- Go to `File -> Settings -> PHP -> Servers`, click on the *Add/Insert* button (`+`) and make the following configuration:

![PhpStorm-Xdebug-Docker-Joomla Path Mappings](https://user-images.githubusercontent.com/987149/163574027-647ba6ec-6067-4bb6-9467-623491fac80e.png)

### Makefile Targets

```bash
# Start joomla docker environment without mapping ./src files
make up

# Start joomla docker environment & map ./src files to the joomla installation
# (generates docker-compose.map.yml)
# Run this after the extension is installed
make map

# Stop joomla docker environment
make down

# Copy ./src files in the joomla installation
make copy

# Build the package. The resulting zip file will be placed in the ./dist directory
make build

# Remove the ./dist directory
make clean

# Add/update copyright headers + XML metadata in ./src (edit ./scripts/environment.sh before running)
make headers

# Watch the ./src directory and copy files in the joomla installation
make watch
```

[inotifywait](https://github.com/inotify-tools/inotify-tools/wiki) is required for the *watch* target.
On windows (Git Bash), the following port of *inotifywait* can be used: [https://github.com/thekid/inotify-win](https://github.com/thekid/inotify-win).

### File Structure

The `<languages>` tag is not used in the manifests to copy the language files in `/language` and `/administrator/language`. `<folder>language</folder>` is added instead, to copy the language folder directly into the component or plugin directory. More on the language files: [https://docs.joomla.org/Manifest_files#Language_Files](https://docs.joomla.org/Manifest_files#Language_Files)

**Before installation:**

```text
src
├── com_papermanager
│   ├── admin
│   │   ├── assets
│   │   ├── controllers
│   │   ├── helpers
│   │   ├── language (!)
│   │   ├── models
│   │   ├── sql
│   │   ├── tables
│   │   ├── views
│   │   ├── access.xml
│   │   ├── config.xml
│   │   ├── controller.php
│   │   ├── papermanager.php
│   │   └── index.html
│   ├── site
│   │   ├── papermanager.php
│   │   └── index.html
│   ├── papermanager.xml (component manifest)
│   └── media (! NOT USED)
│       ├── css
│       ├── images
│       └── js
├── plg_papermanager
│   ├── language (!)
│   ├── papermanager.php
│   ├── papermanager.xml (plugin manifest)
│   └── index.html
└── pkg_papermanager.xml (package manifest)
```

**After installation:**

```text
mytestjoomlawebsite
├── language (! NOT COPIED HERE)
├── administrator
│   ├── language (! NOT COPIED HERE)
│   ├── components
│   │   └── com_papermanager
│   │       ├── assets
│   │       ├── controllers
│   │       ├── helpers
│   │       ├── language
│   │       ├── models
│   │       ├── sql
│   │       ├── tables
│   │       ├── views
│   │       ├── access.xml
│   │       ├── config.xml
│   │       ├── controller.php
│   │       ├── papermanager.php
│   │       ├── index.html
│   │       └── papermanager.xml (component manifest)
│   └── manifests
│       └── packages
│           └── pkg_papermanager.xml (package manifest)
├── components
│   └── com_papermanager
│       ├── papermanager.php
│       └── index.html
├── plugins
│   └── content
│       └── papermanager
│           ├── language
│           ├── papermanager.php
│           ├── papermanager.xml (plugin manifest)
│           └── index.html
└── media (! NOT USED)
    └── com_papermanager
        ├── css
        ├── images
        └── js
```

## License

This project is licensed under the GPL-2.0 License - see the [LICENSE](LICENSE) file for details.
