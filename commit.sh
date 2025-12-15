#!/bin/bash
echo "🚀 Committing Dockerfile fix..."
echo ""

# Stage the Dockerfile fix
git add Dockerfile

# Stage the documentation files
git add DOCKERFILE_FIX.md READY_TO_COMMIT.md COMMIT_NOW.sh test-deno-install.sh

# Create commit
git commit -m "fix(docker): add bash for Deno installation in Alpine

The Deno installation script requires bash to run properly.
Alpine Linux only has sh by default, causing exit code 127 errors.

- Add bash to apk install packages
- Use bash instead of sh for install script
- Add documentation about the fix"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Commit created!"
    echo ""
    echo "📊 Ready to push?"
    git log -1 --oneline
    echo ""
    read -p "Push to develop branch? (y/n): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin develop
        echo ""
        echo "✅ Pushed! Check GitHub Actions: https://github.com/mash2k3/agregarr/actions"
        echo ""
    fi
fi
