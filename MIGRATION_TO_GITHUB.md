# Migration from DockerHub to GitHub Container Registry

This document explains the migration from DockerHub-only builds to dual publishing with GitHub Container Registry (GHCR) as the primary registry.

## What Changed?

### Before
- Docker images were built and published only to DockerHub
- Manual or limited CI/CD automation
- Users pulled from: `mash2k3/agregarr:latest`

### After
- Docker images are automatically built via GitHub Actions
- Published to **both** GitHub Container Registry (GHCR) and DockerHub
- GHCR is the recommended/primary source
- Users can pull from either:
  - **GHCR (Primary):** `ghcr.io/mash2k3/agregarr:latest`
  - **DockerHub (Mirror):** `mash2k3/agregarr:latest`

## Benefits

✅ **Better CI/CD Integration**
- Fully automated builds on push/PR
- Consistent build environment
- Multi-platform support (amd64, arm64)

✅ **Free and Unlimited**
- GHCR is free for public repositories
- No rate limits for authenticated pulls
- No storage limits

✅ **Version Control Integration**
- Images tied to repository
- Easy to track which commit → which image
- Automatic tagging with semantic versioning

✅ **Improved Security**
- Uses GitHub tokens (automatic)
- Fine-grained access control
- No separate service credentials needed

✅ **Redundancy**
- Images published to both registries
- If one registry has issues, use the other
- Users can choose preferred registry

## For End Users

### Recommended: Switch to GHCR

Update your `docker-compose.yml`:

**Old:**
```yaml
services:
  agregarr:
    image: mash2k3/agregarr:latest
```

**New:**
```yaml
services:
  agregarr:
    image: ghcr.io/mash2k3/agregarr:latest
```

Then pull and restart:
```bash
docker-compose pull
docker-compose up -d
```

### Alternative: Continue Using DockerHub

DockerHub images are still published and maintained. No changes required if you prefer to continue using DockerHub.

### Pulling Images Directly

**From GHCR:**
```bash
docker pull ghcr.io/mash2k3/agregarr:latest
docker pull ghcr.io/mash2k3/agregarr:develop
docker pull ghcr.io/mash2k3/agregarr:v1.2.3
```

**From DockerHub:**
```bash
docker pull mash2k3/agregarr:latest
docker pull mash2k3/agregarr:develop
docker pull mash2k3/agregarr:v1.2.3
```

## For Contributors

### What You Need to Know

1. **Pull Requests**
   - Automatically tested (lint, typecheck, build)
   - No images are published for PRs

2. **Push to `develop`**
   - Builds and publishes `develop` tag
   - Available at:
     - `ghcr.io/mash2k3/agregarr:develop`
     - `mash2k3/agregarr:develop`

3. **Push to `latest`**
   - Triggers semantic-release
   - Creates GitHub release
   - Builds and publishes versioned images
   - Tags: `latest`, `v1.2.3`, `v1.2`, `v1`

4. **Commit Messages Matter**
   - Use conventional commits format
   - `feat:` → Minor version bump
   - `fix:` → Patch version bump
   - `BREAKING CHANGE:` → Major version bump

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## For Maintainers

### Initial Setup Required

Follow the [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md):

1. **Add GitHub Secrets:**
   - `DOCKER_USERNAME` - Your Docker Hub username
   - `DOCKER_TOKEN` - Docker Hub access token

2. **Configure Permissions:**
   - Enable "Read and write permissions" for workflows
   - Enable "Allow GitHub Actions to create and approve pull requests"

3. **Test Workflows:**
   - Push to `develop` → Verify images published
   - Merge to `latest` → Verify release created
   - Check both GHCR and DockerHub

### Ongoing Maintenance

- **Automatic:** Everything runs via GitHub Actions
- **No manual steps** needed for builds
- **Monitor:** Check Actions tab for workflow status
- **Update:** Rotate Docker Hub tokens periodically

## Image Tags Explained

| Tag | When Created | Purpose |
|-----|-------------|---------|
| `develop` | Push to `develop` branch | Latest development build |
| `latest` | Push to `latest` branch | Latest stable release |
| `v1.2.3` | Semantic release | Specific version |
| `v1.2` | Semantic release | Minor version line |
| `v1` | Semantic release | Major version line |

## Architecture Support

All images are built for:
- **linux/amd64** - Standard x86_64 systems
- **linux/arm64** - ARM systems (Raspberry Pi 4, Apple Silicon, etc.)

Docker automatically pulls the correct architecture for your system.

## Migration Timeline

### Phase 1: Dual Publishing (Current)
- ✅ Images published to both GHCR and DockerHub
- ✅ GHCR recommended in documentation
- ✅ Both registries fully supported

### Phase 2: GHCR Primary (Future)
- DockerHub becomes secondary/backup
- Most users migrated to GHCR
- Documentation emphasizes GHCR

### Phase 3: GHCR Only (Optional)
- Consider DockerHub deprecation
- Only if community has fully migrated
- Requires community consultation

## Troubleshooting

### Can't Pull from GHCR

**Problem:** `Error: unauthorized`

**Solution:** Public images don't require auth. If you still see this:
```bash
# Clear Docker credentials
docker logout ghcr.io

# Try pull again
docker pull ghcr.io/mash2k3/agregarr:latest
```

### Image Architecture Mismatch

**Problem:** `exec format error`

**Solution:** This happens when pulling wrong architecture:
```bash
# Pull specific platform
docker pull --platform linux/amd64 ghcr.io/mash2k3/agregarr:latest
# or
docker pull --platform linux/arm64 ghcr.io/mash2k3/agregarr:latest
```

### Docker Hub Still Preferred?

**Answer:** That's fine! Images will continue to be published to Docker Hub. You can keep using:
```yaml
image: mash2k3/agregarr:latest
```

### Which Registry is Faster?

**Answer:** Depends on your location:
- GHCR tends to be faster for users close to GitHub's CDN
- DockerHub has global CDN coverage
- Both are generally fast

## FAQ

### Q: Why migrate to GHCR?

**A:** Better integration with GitHub, free unlimited storage, no rate limits, automatic CI/CD, tied to source control.

### Q: Is DockerHub being discontinued?

**A:** No, images continue to be published to DockerHub as a mirror.

### Q: Do I need to update my setup?

**A:** Recommended but not required. Both registries work.

### Q: Will old images on DockerHub be removed?

**A:** No, all existing images remain available.

### Q: What if GHCR is down?

**A:** Use DockerHub as a backup registry.

### Q: Can I still contribute without GHCR knowledge?

**A:** Yes! The CI/CD handles everything automatically.

### Q: How do I know which registry my image came from?

**A:** Check the image name:
```bash
docker images
# ghcr.io/mash2k3/agregarr:latest → From GHCR
# mash2k3/agregarr:latest → From DockerHub
```

## Documentation

For more details, see:
- [DOCKER.md](DOCKER.md) - Comprehensive Docker guide
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [.github/WORKFLOWS.md](.github/WORKFLOWS.md) - Workflow reference
- [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md) - Setup guide
- [SETUP_SUMMARY.md](SETUP_SUMMARY.md) - Technical overview

## Support

Need help?
- 📖 Read the documentation files listed above
- 🐛 Open an issue for bugs or problems
- 💬 Use discussions for questions
- 📧 Contact maintainers for setup help

## Summary

| Aspect | Old Setup | New Setup |
|--------|-----------|-----------|
| **Primary Registry** | DockerHub | GitHub Container Registry |
| **Secondary Registry** | None | DockerHub (mirror) |
| **Build System** | Manual/External | GitHub Actions |
| **Platforms** | Limited | amd64 + arm64 |
| **Versioning** | Manual | Automated (semantic) |
| **CI/CD** | Limited | Full automation |
| **Cost** | DockerHub limits | Free unlimited |

---

**The migration is complete!** Both registries are active and fully supported. Users can choose their preferred registry, with GHCR being recommended for optimal integration and performance.
