# Paper Manager

![GitHub release (latest by date)](https://img.shields.io/github/v/release/papermanager/papermanager ':no-zoom')
![Joomla3x](https://img.shields.io/badge/Joomla!-3.x-yellow ':no-zoom')
![Joomla3x](https://img.shields.io/badge/Joomla!-4.x-yellow ':no-zoom')
![PHP81](https://img.shields.io/badge/php-%3E%3D8.1-787CB5 ':no-zoom')
![License](https://img.shields.io/github/license/papermanager/papermanager ':no-zoom')

> Academic publication manager for Joomla! - Component & plugin.

View complete [Documentation](https://papermanager.github.io/).

Paper Manager is a Joomla extension allowing the management of scientific publications. The extension is useful for websites related to research laboratories and organizations. Lists of scientific papers are commonly present in such websites. A single paper can be included in more than one of these lists. For example it can be shown on a page dedicated to the conference publications of the lab and also on the profile pages of the authors. Paper Manager allows a specific paper entry to be displayed on multiple pages without copying html code on all the relative articles. The extension consists of a component and a content plugin. The component is used for CRUD operations on papers, paper categories and authors while the plugin displays lists of papers inside content (ex. articles), using special code snippets.


## Developer Notes

```bash
# Build the package. The resulting zip file will be placed in the ./build directory
make build

# Copy files in the dev environment
make dev

# Watch the 'src' directory and copy files in the dev environment
make watch
```

### File Structure

The `languages` tag is not used in the manifests to copy the language files in `/language` and `/administrator/language`. `<folder>language</folder>` is added instead, to copy the language folder directly into the component or plugin directory. More on the language files: [https://docs.joomla.org/Manifest_files#Language_Files](https://docs.joomla.org/Manifest_files#Language_Files)

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
