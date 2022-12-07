## How to write mkdocs documentation

See [this tutorial](https://www.mkdocs.org/user-guide/writing-your-docs/)


## Deploy With Read the Docs: https://biblia.readthedocs.io

#### Necessary files

- File `.readthedocs.yaml` according to [this](https://docs.readthedocs.io/en/stable/config-file/v2.html)
- File `requirements` according to [this](https://github.com/mkdocs/mkdocs/issues/2799)

The docommestation is updated automatically withe every commit

## Deploy with Github Pages: https://javiabellan.github.io/biblia

#### Necessary files

This extra lines in mkdocs.yml file
```yaml
remote_branch: gh-deploy
theme: readthedocs
```

#### Comandos principales de MkDocs

- `mkdocs gh-deploy --clean` - Desplegar/Actualizar la documentación MkDocs en la rama `gh-deploy`.

#### Otros comandos

- `mkdocs new [dir-name]` - Create a new project.
- `mkdocs serve` - Start the live-reloading docs server.
- `mkdocs build` - Build the documentation site.
- `mkdocs help` - Print this help message.
