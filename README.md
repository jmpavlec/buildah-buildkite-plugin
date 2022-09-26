# buildah-buildkite-plugin
[![GitHub Release](https://img.shields.io/github/release/jmpavlec/buildah-buildkite-plugin.svg)](https://github.com/jmpavlec/buildah-buildkite-plugin/releases)

Buildkite plugin to wrap around [buildah](https://buildah.io/) for building, pushing, and tagging docker images

## Using the plugin

```yaml
steps:
  - plugins:
      - jmpavlec/buildah#v0.0.1:
          docker_image_name: cloud-ui
          dockerfile_path: cloud-ui
          vault_secret_path: secret/ci/elastic-cloud/docker-registry
          docker_registry_path: docker.elastic.co/cloud-ci/cloud-ui
          tag: 1.0.0
    # Specifying the agent isn't strictly necessary, but you will need an agent image with buildah installed
    agents:
      image: docker.elastic.co/ci-agent-images/drivah:0.16.0
      ephemeralStorage: 10G
      memory: 4G
```

This will result in an image being built and pushed this location:


## Developing the plugin

Buildkite guide for writing plugins: https://buildkite.com/docs/plugins/writing

### Validating plugin.yml
Uses a docker-compose file that runs the [buildkite-plugin-linter](https://github.com/buildkite-plugins/buildkite-plugin-linter)

```shell
docker-compose run --rm lint
```

### Testing your code
Uses a docker-compose file that runs the [buildkite-plugin-tester](https://github.com/buildkite-plugins/buildkite-plugin-tester)

```shell
docker-compose run --rm tests
```


### Testing on a branch
You can test changes to this plugin from a branch using the following yaml in your buildkite pipeline.yml.
`BUILDKITE_PLUGINS_ALWAYS_CLONE_FRESH` is important as it will clone fresh from the repo to get any new commits
you may have added.

```yaml
steps:
  - plugins:
    - jmpavlec/buildah#dev-branch:
        docker_image_name: cloud-ui
        dockerfile_path: cloud-ui
        vault_secret_path: secret/ci/elastic-cloud/docker-registry
        docker_registry_path: docker.elastic.co/cloud-ci/cloud-ui
    env:
      BUILDKITE_PLUGINS_ALWAYS_CLONE_FRESH: "true"
    # Specifying the agent isn't strictly necessary, but you will need an agent image with buildah installed
    agents:
      image: docker.elastic.co/ci-agent-images/drivah:0.16.0
      ephemeralStorage: 10G
      memory: 4G
```
## Releasing the plugin
TODO Github Releases with a tag...