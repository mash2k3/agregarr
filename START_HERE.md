# 🚀 START HERE - Quick Setup Guide

## ✅ What's Already Done

Your repository is **fully configured** for automated Docker builds with GitHub Container Registry!

- ✅ GitHub Actions workflows created and updated
- ✅ All files use correct registry: `ghcr.io/mash2k3/agregarr`
- ✅ Docker Hub completely removed (no credentials needed!)
- ✅ Comprehensive documentation created
- ✅ Multi-platform builds configured (amd64, arm64)

## 🎯 What You Need to Do

### Step 1: Verify GitHub Settings (2 minutes)

1. **Go to your repository on GitHub**
   
2. **Check Workflow Permissions**:
   - Click: `Settings` → `Actions` → `General`
   - Scroll to "Workflow permissions"
   - Select: ✅ **"Read and write permissions"**
   - Enable: ✅ **"Allow GitHub Actions to create and approve pull requests"**
   - Click: **Save**

3. **Verify Packages Enabled**:
   - Click: `Settings` → (scroll down)
   - Under "Features", ensure ✅ **"Packages"** is checked

### Step 2: Test It! (5 minutes)

**Option A: Test with develop branch**
```bash
# Make a small change
echo "# Test" >> test.txt
git add test.txt
git commit -m "test: verify GitHub Actions workflow"
git push origin develop
```

**Then**:
1. Go to: **Actions** tab on GitHub
2. Watch the workflow run
3. After success, go to: **Packages** tab
4. You should see: `agregarr` with `develop` tag

**Option B: Test pulling existing image (if already built)**
```bash
docker pull ghcr.io/mash2k3/agregarr:develop
```

### Step 3: Make Package Public (Optional, 1 minute)

If you want users to pull without authentication:

1. Go to: **Packages** tab
2. Click on: **agregarr**
3. Click: **Package settings** (gear icon)
4. Scroll to "Danger Zone"
5. Click: **Change visibility**
6. Select: **Public**
7. Confirm

## 🎉 That's It!

You're done! Your automated Docker builds are now active.

## 📋 Quick Reference

**Your Docker image**: `ghcr.io/mash2k3/agregarr:latest`

**Pull and run**:
```bash
docker pull ghcr.io/mash2k3/agregarr:latest
docker run -p 7171:7171 -v $(pwd)/config:/app/config ghcr.io/mash2k3/agregarr:latest
```

**Docker Compose**:
```yaml
services:
  agregarr:
    image: ghcr.io/mash2k3/agregarr:latest
    ports:
      - 7171:7171
    volumes:
      - ./config:/app/config
```

## 📚 Learn More

- **Quick Commands**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- **Full Docker Guide**: [DOCKER.md](DOCKER.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **All Documentation**: [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)

## 💡 How It Works

```
You push code → GitHub Actions runs → Builds Docker image → Publishes to GHCR
```

**Branches**:
- `develop` → `ghcr.io/mash2k3/agregarr:develop`
- `latest` → `ghcr.io/mash2k3/agregarr:latest` (+ version tags)

## 🔑 No Secrets Required!

GitHub automatically provides `GITHUB_TOKEN` - you don't need to configure anything!

## ❓ Having Issues?

**Workflow fails?**
- Check Settings → Actions → General → Workflow permissions
- Should be "Read and write"

**Can't see package?**
- Check after first successful workflow run
- Go to Packages tab to verify

**Can't pull image?**
- Make package public (see Step 3 above)
- Or authenticate: `echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin`

## 🎯 Your Next Steps

1. ✅ Verify GitHub settings (Step 1)
2. ✅ Test the workflow (Step 2)
3. ✅ Make package public (Step 3)
4. 🎉 Start using your automated builds!

---

**Questions?** Check [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md) or open an issue!
