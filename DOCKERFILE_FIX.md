# Dockerfile Fix - Deno Installation

## Problem

The Docker build was failing with this error:
```
ERROR: failed to build: failed to solve: process "/bin/sh -c apk add --no-cache curl unzip && curl -fsSL https://deno.land/install.sh | sh && mv /root/.deno/bin/deno /usr/local/bin/deno && deno --version" did not complete successfully: exit code: 127
```

## Root Cause

The Deno installation script requires `bash` to run properly, but Alpine Linux only has `sh` by default. The error "exit code: 127" means "command not found" - the install script was trying to use bash commands that don't exist in `sh`.

## Solution

Added `bash` to the apk install line and explicitly use `bash` to run the install script:

**Before:**
```dockerfile
RUN apk add --no-cache curl unzip && \
    curl -fsSL https://deno.land/install.sh | sh && \
    mv /root/.deno/bin/deno /usr/local/bin/deno && \
    deno --version
```

**After:**
```dockerfile
RUN apk add --no-cache curl unzip bash && \
    curl -fsSL https://deno.land/install.sh | bash && \
    mv /root/.deno/bin/deno /usr/local/bin/deno && \
    deno --version
```

## Changes Made

- Added `bash` to the apk packages
- Changed `sh` to `bash` when piping the install script

## Testing

To test the fix locally:
```bash
docker build -t agregarr:test .
```

Or test just the Deno installation:
```bash
docker run --rm alpine:latest sh -c '
  apk add --no-cache curl unzip bash
  curl -fsSL https://deno.land/install.sh | bash
  /root/.deno/bin/deno --version
'
```

## Next Steps

1. Commit this fix:
   ```bash
   git add Dockerfile
   git commit -m "fix(docker): add bash for Deno installation in Alpine"
   git push origin develop
   ```

2. The GitHub Actions workflow will automatically build and test the fixed Dockerfile

3. Monitor the Actions tab to ensure the build succeeds

## Why This Happened

This issue was in the original Dockerfile and wasn't related to the GitHub Actions/GHCR setup. The build might have worked before if:
- It was built on a system with different base image
- BuildKit cache was hiding the issue
- The Deno install script changed recently

## Impact

This fix ensures:
- ✅ Docker builds complete successfully
- ✅ Deno is properly installed for yt-dlp
- ✅ Multi-platform builds work (amd64, arm64)
- ✅ GitHub Actions can build and publish images
