# Docker Image Build and Deployment

This document explains how Docker images are built and deployed for Agregarr using GitHub Actions and GitHub Container Registry (GHCR).

## Image Repository

Agregarr Docker images are automatically built and published to:

- **GitHub Container Registry (GHCR)**: `ghcr.io/mash2k3/agregarr`

## Automated Builds

### GitHub Actions Workflow

Docker images are automatically built and pushed via GitHub Actions on:

- **Push to branches**: `latest`, `develop`
- **Tagged releases**: `v*` (e.g., `v1.0.0`)
- **Pull requests**: Builds but doesn't push (for testing)
- **Manual trigger**: Via `workflow_dispatch`

### Supported Platforms

Images are built for multiple architectures:
- `linux/amd64` (x86_64)
- `linux/arm64` (ARM 64-bit, e.g., Raspberry Pi 4, Apple Silicon)

### Image Tags

The workflow automatically creates the following tags:

- `latest` - Latest stable release from the `latest` branch
- `develop` - Latest development build from the `develop` branch
- `v1.2.3` - Semantic version tags
- `v1.2` - Major.minor tags
- `v1` - Major version tags

## Using Docker Images

### Using GitHub Container Registry

```yaml
services:
  agregarr:
    image: ghcr.io/mash2k3/agregarr:latest
    container_name: agregarr
    volumes:
      - /path/to/config:/app/config
    ports:
      - 7171:7171
    restart: unless-stopped
```

### Pulling Specific Versions

```bash
# Pull from GHCR
docker pull ghcr.io/mash2k3/agregarr:latest
docker pull ghcr.io/mash2k3/agregarr:develop
docker pull ghcr.io/mash2k3/agregarr:v1.2.3
```

## Manual Building

### Build Locally

To build the Docker image locally:

```bash
# Build for your current platform
docker build -t agregarr:local .

# Build for specific platform
docker build --platform linux/amd64 -t agregarr:local .
docker build --platform linux/arm64 -t agregarr:local .

# Build with commit tag
docker build --build-arg COMMIT_TAG=$(git rev-parse --short HEAD) -t agregarr:local .
```

### Build Multi-Platform Images

To build for multiple platforms (requires Docker Buildx):

```bash
# Create a new builder instance
docker buildx create --name agregarr-builder --use

# Build and push multi-platform image
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg COMMIT_TAG=$(git rev-parse --short HEAD) \
  -t ghcr.io/mash2k3/agregarr:custom \
  --push \
  .
```

## GitHub Container Registry Setup

### For Repository Maintainers

The GitHub Actions workflow uses the `GITHUB_TOKEN` secret which is automatically provided by GitHub. No additional setup is required.

The workflow has the following permissions:
- `contents: read` - Read repository contents
- `packages: write` - Push to GitHub Container Registry

### For Users

To pull public images from GHCR, no authentication is required:

```bash
docker pull ghcr.io/mash2k3/agregarr:latest
```

To pull private images, authenticate with a GitHub Personal Access Token:

```bash
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
docker pull ghcr.io/mash2k3/agregarr:latest
```

## Image Details

### Build Arguments

- `COMMIT_TAG` - Git commit SHA (short format) embedded in the image
- `TARGETPLATFORM` - Target platform (e.g., `linux/amd64`, `linux/arm64`)

### Exposed Ports

- `7171` - Main application HTTP port

### Volumes

- `/app/config` - Configuration and database storage (required)
- `/data/movies` - Placeholder movies folder (optional, for Coming Soon feature)
- `/data/tv` - Placeholder TV folder (optional, for Coming Soon feature)

## Troubleshooting

### Image Won't Build

1. Check that all dependencies are available
2. Ensure you have enough disk space
3. Check Docker/Buildx version compatibility

### Can't Pull from GHCR

1. Check if the repository is public
2. Verify the image name and tag
3. Check network connectivity
4. Try authenticating with a GitHub token

### Multi-Platform Build Issues

1. Ensure Docker Buildx is installed and enabled
2. Check available builders: `docker buildx ls`
3. Create a new builder if needed: `docker buildx create --use`

## GitHub Actions Secrets

The workflow uses the following secret:

- `GITHUB_TOKEN` - Automatically provided by GitHub (no setup needed)

## Additional Resources

- [GitHub Container Registry Documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker Buildx Documentation](https://docs.docker.com/buildx/working-with-buildx/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
