# GitHub Setup Checklist

Use this checklist to ensure everything is properly configured for automated Docker builds and publishing.

## Prerequisites

- [ ] You have admin access to the GitHub repository
- [ ] You have a Docker Hub account (if using Docker Hub)
- [ ] Repository is public or you have appropriate package permissions

## Step 1: Configure GitHub Secrets

### Required Secrets

Go to: **Repository Settings → Secrets and variables → Actions → New repository secret**

- [ ] **DOCKER_USERNAME** (required for Docker Hub)
  - Your Docker Hub username
  - Example: `myusername`

- [ ] **DOCKER_TOKEN** (required for Docker Hub)
  - Docker Hub access token (NOT your password)
  - Generate at: https://hub.docker.com/settings/security
  - Click "New Access Token"
  - Give it a description (e.g., "GitHub Actions")
  - Set permissions: "Read, Write, Delete"
  - Copy the token and add it to GitHub secrets

- [ ] **GITHUB_TOKEN**
  - ✅ Automatically provided by GitHub (no action needed)

## Step 2: Verify Workflow Permissions

Go to: **Repository Settings → Actions → General → Workflow permissions**

- [ ] Set to: "Read and write permissions"
- [ ] ✅ Check: "Allow GitHub Actions to create and approve pull requests"

## Step 3: Enable GitHub Packages

Go to: **Repository Settings → Features**

- [ ] ✅ Ensure "Packages" is enabled (should be enabled by default)

## Step 4: Test the Workflows

### Test 1: Development Build

1. [ ] Create a test branch from `develop`
   ```bash
   git checkout develop
   git pull
   git checkout -b test-workflows
   ```

2. [ ] Make a small change and commit
   ```bash
   echo "# Test" >> test.txt
   git add test.txt
   git commit -m "test: verify workflow configuration"
   ```

3. [ ] Push to develop
   ```bash
   git push origin develop
   ```

4. [ ] Check GitHub Actions:
   - [ ] Go to Actions tab
   - [ ] Verify "Agregarr Develop" workflow runs
   - [ ] Check for any errors

5. [ ] Verify images were pushed:
   - [ ] Check Docker Hub: https://hub.docker.com/r/mash2k3/agregarr/tags
   - [ ] Check GHCR: Go to repository → Packages tab
   - [ ] Look for `develop` tag in both places

### Test 2: Pull Request Build

1. [ ] Create a pull request to `develop`

2. [ ] Check that tests run:
   - [ ] Lint check passes
   - [ ] Type check passes
   - [ ] Format check passes
   - [ ] Build succeeds

3. [ ] Verify NO images are pushed (PRs only test)

### Test 3: Release Build

1. [ ] Merge a commit to `latest` branch:
   ```bash
   git checkout latest
   git pull
   git merge develop
   git push origin latest
   ```

2. [ ] Check GitHub Actions:
   - [ ] Verify "Agregarr Release" workflow runs
   - [ ] Check semantic-release output

3. [ ] Verify release was created:
   - [ ] Go to repository → Releases
   - [ ] Check for new release with version tag
   - [ ] Verify CHANGELOG.md was updated

4. [ ] Verify versioned images were pushed:
   - [ ] Docker Hub: `mash2k3/agregarr:latest`, `mash2k3/agregarr:v1.x.x`
   - [ ] GHCR: `ghcr.io/mash2k3/agregarr:latest`, `ghcr.io/mash2k3/agregarr:v1.x.x`

### Test 4: Manual Build (Optional)

1. [ ] Go to Actions → Manual Docker Build → Run workflow

2. [ ] Fill in inputs:
   - Branch: `develop`
   - Docker image tag: `test`
   - Push to registries: `false`

3. [ ] Click "Run workflow"

4. [ ] Verify build completes successfully

## Step 5: Configure Package Visibility (GHCR)

1. [ ] Go to repository → Packages tab

2. [ ] Click on the `agregarr` package

3. [ ] Go to Package settings

4. [ ] Set visibility:
   - [ ] For public projects: Change to "Public"
   - [ ] For private projects: Keep as "Private" or set to "Internal"

5. [ ] Link package to repository (if not already linked)

## Step 6: Update Documentation

- [ ] Verify README.md points to GHCR
- [ ] Update any deployment guides
- [ ] Update docker-compose examples
- [ ] Notify users about the change (if applicable)

## Step 7: Pull and Test Images

### Test GHCR Image

```bash
# Pull the image
docker pull ghcr.io/mash2k3/agregarr:develop

# Run it
docker run --rm -p 7171:7171 \
  -v $(pwd)/test-config:/app/config \
  ghcr.io/mash2k3/agregarr:develop
```

- [ ] Image pulls successfully
- [ ] Container starts without errors
- [ ] Application is accessible at http://localhost:7171

### Test Docker Hub Image

```bash
# Pull the image
docker pull mash2k3/agregarr:develop

# Run it
docker run --rm -p 7171:7171 \
  -v $(pwd)/test-config:/app/config \
  mash2k3/agregarr:develop
```

- [ ] Image pulls successfully
- [ ] Container starts without errors
- [ ] Application is accessible at http://localhost:7171

## Step 8: Verify Multi-Platform Support

```bash
# Check supported platforms
docker manifest inspect ghcr.io/mash2k3/agregarr:develop
```

- [ ] Contains `linux/amd64` manifest
- [ ] Contains `linux/arm64` manifest

## Step 9: Monitor and Maintain

### Regular Checks

- [ ] Set up notification for failed workflows
  - Go to: Watching → Custom → Workflows
  - Enable notifications for workflow failures

- [ ] Periodically check:
  - [ ] Workflow success rate
  - [ ] Image sizes (should remain reasonable)
  - [ ] Build times (should be consistent)

### Update Docker Hub Token

- [ ] Docker Hub tokens should be rotated periodically
- [ ] When rotating:
  1. Generate new token on Docker Hub
  2. Update `DOCKER_TOKEN` in GitHub secrets
  3. Delete old token from Docker Hub

## Troubleshooting

### Workflow Fails: Authentication Error

**Problem:** `Error: Username and password required`

**Solution:**
1. Verify `DOCKER_USERNAME` is set correctly
2. Verify `DOCKER_TOKEN` is a valid access token (not password)
3. Try regenerating the Docker Hub token

### Workflow Fails: Permission Denied (GHCR)

**Problem:** `Error: permission denied`

**Solution:**
1. Check workflow permissions are set to "Read and write"
2. Verify `GITHUB_TOKEN` has packages write permission
3. Check if organization requires admin approval

### Images Not Visible in GHCR

**Problem:** Can't find package in repository

**Solution:**
1. Go to repository → Packages tab
2. If package is there but hidden, change visibility
3. Link package to repository if needed

### Semantic Release Not Creating Versions

**Problem:** Push to `latest` doesn't create release

**Solution:**
1. Check commit messages follow conventional commits
2. Ensure at least one `feat:` or `fix:` commit since last release
3. Check semantic-release logs for details

## Optional: Set Up Status Badges

Add to your README.md:

```markdown
[![Develop Build](https://github.com/mash2k3/agregarr/actions/workflows/develop.yml/badge.svg)](https://github.com/mash2k3/agregarr/actions/workflows/develop.yml)
[![Latest Build](https://github.com/mash2k3/agregarr/actions/workflows/latest.yml/badge.svg)](https://github.com/mash2k3/agregarr/actions/workflows/latest.yml)
```

- [ ] Add status badges to README
- [ ] Verify badges display correctly

## Documentation Reference

- [ ] Read [DOCKER.md](DOCKER.md) - Docker usage guide
- [ ] Read [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [ ] Read [.github/WORKFLOWS.md](.github/WORKFLOWS.md) - Workflow reference
- [ ] Read [SETUP_SUMMARY.md](SETUP_SUMMARY.md) - Setup overview

## Final Verification

- [ ] All workflows are working
- [ ] Images are being pushed to both registries
- [ ] Documentation is updated
- [ ] Users can pull and run images
- [ ] Semantic versioning is working
- [ ] Multi-platform builds are successful

## Success Criteria

✅ **Setup is complete when:**

1. Push to `develop` → `develop` tag images published
2. Push to `latest` → versioned release created with proper tags
3. Both GHCR and Docker Hub images are accessible
4. Multi-platform images work on amd64 and arm64
5. All documentation is accurate and up-to-date

## Getting Help

If you encounter issues:
1. Check workflow logs in Actions tab
2. Review the troubleshooting section above
3. Consult the documentation files
4. Open a GitHub issue with:
   - Checklist items completed
   - Error messages
   - Workflow run links
   - Steps to reproduce

---

**Date Completed:** _______________

**Completed By:** _______________

**Notes:**
