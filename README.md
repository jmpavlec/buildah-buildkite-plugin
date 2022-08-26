# buildah-buildkite-plugin
[![GitHub Release](https://img.shields.io/github/release/jmpavlec/buildah-buildkite-plugin.svg)](https://github.com/jmpavlec/buildah-buildkite-plugin/releases)

Buildkite plugin to wrap around buildah for building, pushing, and tagging docker images

## Using the plugin

```yaml
steps:
  - plugins:
      - jmpavlec/buildah#v0.0.1:
          docker_image_name: cloud-ui
          dockerfile_path: cloud-ui
          pre_build_steps:
            - "echo Do whatever presteps you need before the build"
```

## Developing the plugin

Buildkite guide for writing plugins: https://buildkite.com/docs/plugins/writing

### Validating plugin.yml
Uses a docker-compose file that runs the [buildkite-plugin-linted](https://github.com/buildkite-plugins/buildkite-plugin-linter)

```shell
docker-compose run --rm lint
```


### Testing on a branch
You can test changes to this plugin from a branch using the following yaml in your buildkite pipeline.yml.
`BUILDKITE_PLUGINS_ALWAYS_CLONE_FRESH` is important as it will clone fresh from the repo to get any new commits
you may have added.

```yaml
steps:
  - env:
      BUILDKITE_PLUGINS_ALWAYS_CLONE_FRESH: "true"
    plugins:
    - jmpavlec/buildah##dev-branch:
        docker_image_name: cloud-ui
        dockerfile_path: cloud-ui
```
## Releasing the plugin
TODO Github Releases with a tag...