# Contributing to Agregarr

Thank you for your interest in contributing to Agregarr! This document provides guidelines and information for contributors.

## Development Setup

### Prerequisites

- Node.js 20.x or higher
- Yarn package manager
- Docker (for building images)
- Git

### Local Development

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mash2k3/agregarr.git
   cd agregarr
   ```

2. **Install dependencies:**
   ```bash
   yarn install
   ```

3. **Run in development mode:**
   ```bash
   yarn dev
   ```

4. **Access the application:**
   Open `http://localhost:7171` in your browser

### Code Quality

Before submitting changes, ensure your code passes all checks:

```bash
# Run linter
yarn lint

# Run type checking
yarn typecheck

# Run formatter
yarn format

# Check formatting
yarn format:check
```

## Docker Development

### Using Docker Compose

For local development with Docker:

```bash
docker-compose up
```

This uses `Dockerfile.local` which is optimized for development with hot-reloading.

### Building Docker Images Locally

```bash
# Build for your platform
docker build -t agregarr:dev .

# Build for specific platform
docker build --platform linux/amd64 -t agregarr:dev .
```

## CI/CD and Docker Image Publishing

### Automated Workflows

Agregarr uses GitHub Actions for automated testing, building, and publishing:

#### 1. **Pull Request Workflow** (`develop.yml`)
- Triggers on: Pull requests to any branch
- Actions:
  - Lints code
  - Type checks
  - Checks formatting
  - Builds the application

#### 2. **Develop Branch Workflow** (`develop.yml`)
- Triggers on: Push to `develop` branch
- Actions:
  - Builds multi-platform Docker images
  - Pushes to: `ghcr.io/mash2k3/agregarr:develop`

#### 3. **Release Workflow** (`latest.yml`)
- Triggers on: Push to `latest` branch
- Actions:
  - Runs semantic-release
  - Creates GitHub releases
  - Builds and tags Docker images with version numbers
  - Pushes to GHCR:
    - `ghcr.io/mash2k3/agregarr:latest`
    - `ghcr.io/mash2k3/agregarr:v1.2.3`

#### 4. **Manual Build Workflow** (`docker-build.yml`)
- Triggers on: Manual dispatch via GitHub UI
- Actions:
  - Builds Docker image with custom tag
  - Optionally pushes to registry

### Required Secrets

For the workflows to function, the following GitHub secret is used:

- `GITHUB_TOKEN` - Automatically provided by GitHub

### Image Registry

Images are published to:

**GitHub Container Registry**
- URL: `ghcr.io/mash2k3/agregarr`
- Authentication: GitHub token
- Public access: No login required for pulling

## Branching Strategy

- `latest` - Stable release branch
- `develop` - Development branch
- `feature/*` - Feature branches
- `fix/*` - Bug fix branches

## Commit Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build process or auxiliary tool changes

### Examples:
```
feat(collections): add support for Letterboxd lists

fix(docker): correct environment variable handling

docs(readme): update installation instructions
```

## Pull Request Process

1. **Fork the repository** and create your branch from `develop`

2. **Make your changes** following the code style guidelines

3. **Test your changes** thoroughly:
   ```bash
   yarn lint
   yarn typecheck
   yarn build
   ```

4. **Commit your changes** using conventional commit messages

5. **Push to your fork** and create a pull request to the `develop` branch

6. **Ensure CI passes** - All checks must pass before merge

7. **Request review** from maintainers

8. **Address feedback** and make necessary changes

## Release Process

Releases are automated using [semantic-release](https://github.com/semantic-release/semantic-release):

1. Changes are merged to `develop` branch
2. After testing, `develop` is merged to `latest`
3. semantic-release analyzes commits
4. Version is determined based on commit types
5. Changelog is generated
6. GitHub release is created
7. Docker images are built and tagged
8. Images are pushed to GitHub Container Registry

### Version Determination

- `fix:` commits → PATCH release (1.0.0 → 1.0.1)
- `feat:` commits → MINOR release (1.0.0 → 1.1.0)
- `BREAKING CHANGE:` → MAJOR release (1.0.0 → 2.0.0)

## Testing Docker Images

### Test Development Image

```bash
# Pull develop image
docker pull ghcr.io/mash2k3/agregarr:develop

# Run it
docker run -p 7171:7171 \
  -v $(pwd)/config:/app/config \
  ghcr.io/mash2k3/agregarr:develop
```

### Test Release Image

```bash
# Pull latest release
docker pull ghcr.io/mash2k3/agregarr:latest

# Run it
docker run -p 7171:7171 \
  -v $(pwd)/config:/app/config \
  ghcr.io/mash2k3/agregarr:latest
```

## Documentation

When contributing, please update documentation:

- Update README.md for user-facing changes
- Update DOCKER.md for Docker-related changes
- Update this CONTRIBUTING.md for process changes
- Add/update code comments for complex logic

## Getting Help

- **Issues**: Report bugs or request features via [GitHub Issues](https://github.com/mash2k3/agregarr/issues)
- **Discussions**: Ask questions in [GitHub Discussions](https://github.com/mash2k3/agregarr/discussions)

## Code of Conduct

Please be respectful and constructive in all interactions. We aim to maintain a welcoming community for all contributors.

## License

By contributing to Agregarr, you agree that your contributions will be licensed under the GPL-3.0 License.
