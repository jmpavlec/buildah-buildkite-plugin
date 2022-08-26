#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment the following line to debug stub failures
 export CD_STUB_DEBUG=/dev/tty
 export BUILDAH_STUB_DEBUG=/dev/tty
 export BUILDKITE_COMMIT=aaabbbccceee

@test "should fail when required properties are not included" {
  export BUILDKITE_PLUGIN_BUILDAH_DOCKERFILE_PATH=""
  export BUILDKITE_PLUGIN_BUILDAH_DOCKER_IMAGE_NAME=""
  export BUILDKITE_PLUGIN_BUILDAH_DOCKER_REGISTRY_VAULT_PATH=""

  run "$PWD/hooks/command"

  assert_failure
  assert_output --partial "'docker_image_name' property is required"
  assert_output --partial "'dockerfile_path' property is required"
  assert_output --partial "'docker_registry_vault_path' property is required"
}

#WIP test, stubs not working
@test "should attempt to build image with required properties" {
  export BUILDKITE_PLUGIN_BUILDAH_DOCKERFILE_PATH="tests/fakedir"
  export BUILDKITE_PLUGIN_BUILDAH_DOCKER_IMAGE_NAME="myAppName"
  export BUILDKITE_PLUGIN_BUILDAH_DOCKER_REGISTRY_VAULT_PATH="vault-path"
  #export BUILDKITE_PLUGIN_BUILDAH_BUILD_ONLY="true"
  export VAULT_TOKEN=abc123

  stub vault \
    "read -field password vault-path : echo TESTING"
  stub git \
   "rev-parse --show-toplevel : echo 'myRepoName'"
  stub cd "tests/fakedir"

  stub buildah \
    "--version" \
    "bud -t myAppName:aaabbbc ." \
    "login -u cloudci --password-stdin docker.elastic.co"

  run bash -c "$PWD/hooks/command"

  assert_success
  assert_output --partial "Reading plugin parameters"
  assert_output --partial "Building Container in directory"
  assert_output --partial "--- Tagging container image myAppName:aaabbbc"
  assert_output --partial "+++ Pushing image to docker.elastic.co/myRepoName/myAppName:aaabbbc"

  #unstub cd
  #unstub buildah
}
