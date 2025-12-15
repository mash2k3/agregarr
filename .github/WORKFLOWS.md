# GitHub Actions Workflows Reference

This document provides a quick reference for all GitHub Actions workflows in this repository.

## Workflows Overview

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| Agregarr Develop | `develop.yml` | Push to `develop`, PRs | Test, build, and publish development images |
| Agregarr Release | `latest.yml` | Push to `latest` | Create releases and publish versioned images |
| Manual Docker Build | `docker-build.yml` | Manual dispatch | Build custom Docker images on demand |

## Workflow Details

### 1. Agregarr Develop (`develop.yml`)

**Triggers:**
- Pull requests to any branch
- Pushes to `develop` branch

**Jobs:**

#### `test` (runs on PRs only)
- Checkout code
- Install dependencies
- Run linter
- Type check
- Check formatting
- Build application

#### `build_and_push` (runs on push to develop only)
- Checkout code
- Set up QEMU and Docker Buildx
- Log in to Docker Hub
- Log in to GitHub Container Registry
- Build multi-platform images (amd64, arm64)
- Push images with tag `develop` to:
  - `mash2k3/agregarr:develop`
  - `ghcr.io/mash2k3/agregarr:develop`

**Required Secrets:**
- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_TOKEN` - Docker Hub access token
- `GITHUB_TOKEN` - Auto-provided by GitHub

### 2. Agregarr Release (`latest.yml`)

**Triggers:**
- Pushes to `latest` branch

**Jobs:**

#### `semantic-release`
- Checkout code with full history
- Set up Node.js 20
- Set up QEMU and Docker Buildx
- Log in to Docker Hub
- Log in to GitHub Container Registry
- Install dependencies
- Run semantic-release which:
  - Analyzes commits
  - Determines version number
  - Generates changelog
  - Creates GitHub release
  - Builds and pushes multi-platform images with version tags
  - Updates package.json

**Published Images:**
- `mash2k3/agregarr:latest`
- `mash2k3/agregarr:v1.2.3` (version tags)
- `mash2k3/agregarr:v1.2` (minor version)
- `mash2k3/agregarr:v1` (major version)
- `ghcr.io/mash2k3/agregarr:latest`
- `ghcr.io/mash2k3/agregarr:v1.2.3`
- `ghcr.io/mash2k3/agregarr:v1.2`
- `ghcr.io/mash2k3/agregarr:v1`

**Required Secrets:**
- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_TOKEN` - Docker Hub access token
- `GITHUB_TOKEN` - Auto-provided by GitHub

**Permissions:**
- `contents: write` - Create releases
- `issues: write` - Comment on issues
- `pull-requests: write` - Comment on PRs
- `packages: write` - Push to GHCR

### 3. Manual Docker Build (`docker-build.yml`)

**Triggers:**
- Manual dispatch via GitHub Actions UI

**Inputs:**
- `tag` - Custom tag for the Docker image (required, default: 'manual')
- `push_to_registry` - Whether to push to registries (boolean, default: false)

**Jobs:**

#### `build-and-push`
- Checkout code
- Set up QEMU and Docker Buildx
- Log in to Docker Hub (if push enabled)
- Log in to GitHub Container Registry (if push enabled)
- Extract metadata and create tags
- Build multi-platform images (amd64, arm64)
- Optionally push images with custom tag to:
  - `mash2k3/agregarr:<custom-tag>`
  - `ghcr.io/mash2k3/agregarr:<custom-tag>`

**Required Secrets:**
- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_TOKEN` - Docker Hub access token
- `GITHUB_TOKEN` - Auto-provided by GitHub

**Permissions:**
- `contents: read` - Read repository
- `packages: write` - Push to GHCR

## Running Manual Workflows

### Trigger Manual Docker Build

1. Go to your repository on GitHub
2. Click on "Actions" tab
3. Select "Manual Docker Build" from the workflows list
4. Click "Run workflow" button
5. Fill in the inputs:
   - **Branch:** Select the branch to build from
   - **Docker image tag:** Enter your custom tag (e.g., 'test', 'experimental')
   - **Push to registries:** Check if you want to push to registries
6. Click "Run workflow"

## Workflow Status Badges

Add these to your README.md:

```markdown
![Develop Build](https://github.com/mash2k3/agregarr/actions/workflows/develop.yml/badge.svg)
![Latest Build](https://github.com/mash2k3/agregarr/actions/workflows/latest.yml/badge.svg)
```

## Common Tasks

### Test a Pull Request
1. Create a PR to any branch
2. The `develop.yml` workflow automatically runs tests
3. Check the "Checks" tab on your PR for results

### Publish Development Build
1. Push commits to `develop` branch
2. The `develop.yml` workflow automatically builds and pushes
3. Images available at:
   - `ghcr.io/mash2k3/agregarr:develop`
   - `mash2k3/agregarr:develop`

### Create a Release
1. Ensure all changes are in `develop` branch
2. Merge `develop` to `latest` branch
3. The `latest.yml` workflow automatically:
   - Determines version based on commit messages
   - Creates GitHub release
   - Builds and pushes versioned images

### Build Custom Test Image
1. Go to Actions → Manual Docker Build
2. Run workflow with:
   - Branch: Your feature branch
   - Tag: `test` or custom
   - Push: `false` (just build, don't push)
3. Check workflow logs for build status

## Troubleshooting

### Workflow Fails on Docker Login

**Issue:** "Error: Username and password required"

**Solution:**
1. Go to Settings → Secrets and variables → Actions
2. Verify `DOCKER_USERNAME` and `DOCKER_TOKEN` are set
3. Re-run the workflow

### Build Fails on Multi-Platform

**Issue:** "Multiple platforms feature is currently not supported"

**Solution:**
- This is automatically handled by `docker/setup-buildx-action`
- If it persists, check the GitHub Actions runner status

### Semantic Release Doesn't Create Version

**Issue:** No new version created after pushing to `latest`

**Solution:**
- Check commit messages follow conventional commits format
- At least one `feat:` or `fix:` commit required
- Use `git log` to verify commit format

### Images Not Appearing in GHCR

**Issue:** Images not visible in GitHub Container Registry

**Solution:**
1. Check workflow completed successfully
2. Go to repository Packages tab
3. If package is private, make it public:
   - Go to package settings
   - Change visibility to public

## Workflow File Locations

```
.github/
└── workflows/
    ├── develop.yml          # Development workflow
    ├── latest.yml           # Release workflow
    └── docker-build.yml     # Manual build workflow
```

## Related Documentation

- [CONTRIBUTING.md](../../CONTRIBUTING.md) - Contribution guidelines
- [DOCKER.md](../../DOCKER.md) - Docker usage and building
- [SETUP_SUMMARY.md](../../SETUP_SUMMARY.md) - Setup overview

## Support

For workflow issues:
1. Check workflow logs in the Actions tab
2. Review this documentation
3. Open an issue with:
   - Workflow name
   - Run ID
   - Error logs
   - Steps to reproduce
