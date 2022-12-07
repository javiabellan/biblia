## How to write mkdocs documentation

See [this tutorial](https://www.mkdocs.org/user-guide/writing-your-docs/)





## Deploy on Read the Docs: https://biblia.readthedocs.io

#### Necessary files

- File `.readthedocs.yaml` according to [this](https://docs.readthedocs.io/en/stable/config-file/v2.html)
- File `requirements` according to [this](https://github.com/mkdocs/mkdocs/issues/2799)

The documentation is deployed **automatically** on every commit.




## Deploy on Github Pages: https://javiabellan.github.io/biblia

#### Necessary files

Add this extra line in `mkdocs.yml` file
```yaml
remote_branch: gh-deploy
```

#### Test deploy on localhost

- `mkdocs new [dir-name]` - Create a new project.
- `mkdocs serve` - Start the live-reloading docs server.
- `mkdocs build` - Build the documentation site.

#### Manual deploy on Github pages

- `mkdocs gh-deploy --clean` - Desplegar/Actualizar la documentación MkDocs en la rama `gh-deploy`.

#### Automatic deploy on Github pages with github Actions

See the Githug action file `.github/workflows/deploy-gh-pages.yml`

[Source](https://medium.com/medialesson/documentation-in-github-pages-with-mkdocs-readthedocs-theme-920b283215d1)
