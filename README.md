# Taller Images

Repository to contain the build process for public docker images built by the Taller team. Each directory has the same name as an image.

## Commands

These are shortcut commands available with `make` inside each image directory:

- `run`: Run a container for testing purpose.
- `build`: Builds the image.
- `push`: Builds and pushes the image.

These are common arguments available:

Argument | Default             | Description
---------|--------------|-------------------
TAG      | stable              | Image tag to build
USER     | taller              | The Docker user name
REPO     | $(notdir $(CURDIR)) | The repository name


## Customizing

Here are some tips to customizing the images for each project's needs.

### Timezone

To set timezone configuration, use the environment variable TZ. [Read more](https://github.com/docker/docker/issues/12084#issuecomment-160177087).
