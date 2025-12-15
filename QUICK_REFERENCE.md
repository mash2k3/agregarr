# Quick Reference Guide

## 🚀 For End Users

### Install Agregarr (Docker Compose)

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

```bash
docker-compose up -d
```

Access: **http://localhost:7171**

### Pull Latest Image

```bash
# From GitHub Container Registry
docker pull ghcr.io/mash2k3/agregarr:latest
```

---

## 👨‍💻 For Contributors

### Setup Development Environment

```bash
git clone https://github.com/mash2k3/agregarr.git
cd agregarr
yarn install
yarn dev
```

Access: **http://localhost:7171**

### Run Tests and Checks

```bash
yarn lint          # Run linter
yarn typecheck     # Type check
yarn format        # Format code
yarn build         # Build application
```

### Commit Convention

```bash
feat(scope): add new feature        # → Minor version bump
fix(scope): fix bug                 # → Patch version bump
docs(scope): update documentation   # → No version bump
BREAKING CHANGE: ...                # → Major version bump
```

### Create Pull Request

1. Fork repo and create branch from `develop`
2. Make changes
3. Run tests: `yarn lint && yarn typecheck && yarn build`
4. Commit using conventional commits
5. Push and create PR to `develop`

---

## ⚙️ For Maintainers

### Required GitHub Secrets

```
Repository Settings → Secrets and variables → Actions

GITHUB_TOKEN     = (automatically provided)
```

### Workflow Triggers

| Branch | Action | Result |
|--------|--------|--------|
| `develop` | Push | Build & publish `develop` tag |
| `latest` | Push | Create release & publish versioned tags |
| Any | PR | Run tests (no publish) |

### Create Release

1. Merge changes to `develop`
2. Test thoroughly
3. Merge `develop` to `latest`
4. Semantic-release runs automatically
5. Images published to GHCR

### Published Image Tags

```
ghcr.io/mash2k3/agregarr:latest
ghcr.io/mash2k3/agregarr:develop
ghcr.io/mash2k3/agregarr:v1.2.3
ghcr.io/mash2k3/agregarr:v1.2
ghcr.io/mash2k3/agregarr:v1
```

---

## 🐳 Docker Quick Commands

### Pull and Run

```bash
# Latest release
docker run -d -p 7171:7171 -v $(pwd)/config:/app/config ghcr.io/mash2k3/agregarr:latest

# Development build
docker run -d -p 7171:7171 -v $(pwd)/config:/app/config ghcr.io/mash2k3/agregarr:develop

# Specific version
docker run -d -p 7171:7171 -v $(pwd)/config:/app/config ghcr.io/mash2k3/agregarr:v1.2.3
```

### Build Locally

```bash
# Build for current platform
docker build -t agregarr:local .

# Build for specific platform
docker build --platform linux/amd64 -t agregarr:local .
docker build --platform linux/arm64 -t agregarr:local .

# Build multi-platform
docker buildx build --platform linux/amd64,linux/arm64 -t agregarr:local .
```

### Inspect Image

```bash
# View image details
docker inspect ghcr.io/mash2k3/agregarr:latest

# Check supported platforms
docker manifest inspect ghcr.io/mash2k3/agregarr:latest

# View image layers
docker history ghcr.io/mash2k3/agregarr:latest
```

---

## 🔧 Common Issues & Solutions

### Can't Pull from GHCR

```bash
# Public images don't need auth, but if you have issues:
docker logout ghcr.io
docker pull ghcr.io/mash2k3/agregarr:latest
```

### Workflow Failed: Authentication

1. Verify workflow has `packages: write` permission
2. Check repository settings allow GitHub Actions
3. Re-run workflow

### Multi-Platform Build Failed

```bash
# Create buildx builder
docker buildx create --name agregarr-builder --use

# Verify
docker buildx ls

# Try build again
```

### Semantic Release Not Creating Version

- Check commit messages use conventional format
- Ensure at least one `feat:` or `fix:` since last release
- View workflow logs for details

---

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Main user documentation |
| [DOCKER.md](DOCKER.md) | Complete Docker guide |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |
| [.github/WORKFLOWS.md](.github/WORKFLOWS.md) | GitHub Actions reference |
| [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md) | Maintainer setup guide |
| [SETUP_SUMMARY.md](SETUP_SUMMARY.md) | Technical overview |
| [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md) | Documentation index |

---

## 🔗 Links

- **Repository:** https://github.com/mash2k3/agregarr
- **GHCR Package:** https://github.com/mash2k3/agregarr/pkgs/container/agregarr
- **Issues:** https://github.com/mash2k3/agregarr/issues
- **Discussions:** https://github.com/mash2k3/agregarr/discussions

---

## 📞 Support

- 📖 **Documentation:** Start with [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)
- 🐛 **Bugs:** Open an issue with "bug" label
- 💡 **Features:** Open an issue with "enhancement" label
- ❓ **Questions:** Use GitHub Discussions

---

**For more details, see [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)**
