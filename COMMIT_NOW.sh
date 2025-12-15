#!/bin/bash

echo "================================================"
echo "🚀 Committing GitHub Container Registry Setup"
echo "================================================"
echo ""

# Check git status
echo "📊 Checking what will be committed..."
git status --short
echo ""

# Show summary
echo "📝 Summary of changes:"
echo "  ✅ GitHub Actions workflows (GHCR only)"
echo "  ✅ Dockerfile fix (Deno installation)"
echo "  ✅ Documentation files"
echo "  ✅ Updated package.json and README"
echo ""

# Ask for confirmation
read -p "🤔 Ready to commit all changes? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "📦 Staging all changes..."
    git add .
    
    echo ""
    echo "✍️  Creating commit..."
    git commit -m "feat(ci): migrate to GitHub Container Registry

- Configure GitHub Actions for automated Docker builds
- Publish to ghcr.io/mash2k3/agregarr (GHCR only)
- Remove Docker Hub dependencies
- Fix Deno installation in Dockerfile (add bash for Alpine)
- Add comprehensive documentation
- Support multi-platform builds (amd64, arm64)
- Enable semantic versioning

BREAKING CHANGE: Docker images now published to GHCR only"
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Commit created successfully!"
        echo ""
        echo "🌐 Ready to push to GitHub?"
        read -p "   Push to 'develop' branch now? (y/n): " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo ""
            echo "🚀 Pushing to develop branch..."
            git push origin develop
            
            if [ $? -eq 0 ]; then
                echo ""
                echo "================================================"
                echo "✅ SUCCESS! Changes pushed to GitHub"
                echo "================================================"
                echo ""
                echo "📍 Next steps:"
                echo "  1. Go to: https://github.com/mash2k3/agregarr/actions"
                echo "  2. Watch the 'Agregarr Develop' workflow run"
                echo "  3. Wait for build to complete (~5-10 minutes)"
                echo "  4. Check: https://github.com/mash2k3?tab=packages"
                echo "  5. Verify image: ghcr.io/mash2k3/agregarr:develop"
                echo ""
                echo "🧪 Test the image:"
                echo "  docker pull ghcr.io/mash2k3/agregarr:develop"
                echo ""
            else
                echo ""
                echo "❌ Push failed. Check the error above."
                echo ""
            fi
        else
            echo ""
            echo "⏸️  Commit created but not pushed."
            echo "   Push manually when ready: git push origin develop"
            echo ""
        fi
    else
        echo ""
        echo "❌ Commit failed. Check the error above."
        echo ""
    fi
else
    echo ""
    echo "⏸️  Commit cancelled. No changes made."
    echo ""
fi
