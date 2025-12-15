# Documentation Index

This repository includes comprehensive documentation for building, deploying, and contributing to Agregarr. Use this index to find the information you need.

## Quick Links

| For... | Read This |
|--------|-----------|
| 🚀 **First-time users** | [README.md](README.md) |
| 🐳 **Docker deployment** | [DOCKER.md](DOCKER.md) |
| 🔄 **Migrating from DockerHub** | [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md) |
| 👨‍💻 **Contributors** | [CONTRIBUTING.md](CONTRIBUTING.md) |
| ⚙️ **Repository maintainers** | [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md) |
| 🔧 **GitHub Actions** | [.github/WORKFLOWS.md](.github/WORKFLOWS.md) |
| 📋 **Setup overview** | [SETUP_SUMMARY.md](SETUP_SUMMARY.md) |

## Documentation Files

### User Documentation

#### [README.md](README.md)
**Primary documentation for end users**
- What is Agregarr?
- Features overview
- Installation instructions
- Docker Compose examples
- Quick start guide

#### [DOCKER.md](DOCKER.md)
**Complete Docker guide**
- Image repositories (GHCR and Docker Hub)
- Automated builds explanation
- Supported platforms
- Using Docker images
- Manual building instructions
- Troubleshooting Docker issues

#### [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md)
**Migration guide for existing users**
- What changed from DockerHub to GHCR
- Benefits of the migration
- How to switch registries
- FAQ and troubleshooting
- Timeline and phases

### Developer Documentation

#### [CONTRIBUTING.md](CONTRIBUTING.md)
**Guidelines for contributors**
- Development setup
- Code quality standards
- CI/CD workflow explanation
- Branching strategy
- Commit conventions
- Pull request process
- Release process
- Testing Docker images

#### [.github/WORKFLOWS.md](.github/WORKFLOWS.md)
**GitHub Actions workflows reference**
- Overview of all workflows
- Detailed workflow descriptions
- Running manual workflows
- Workflow status badges
- Common tasks
- Troubleshooting workflows

### Maintainer Documentation

#### [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md)
**Step-by-step setup guide for maintainers**
- Prerequisites checklist
- Configuring GitHub secrets
- Verifying workflow permissions
- Testing all workflows
- Package visibility configuration
- Pull and test images
- Multi-platform verification
- Ongoing maintenance tasks

#### [SETUP_SUMMARY.md](SETUP_SUMMARY.md)
**Technical overview of the setup**
- Changes made to repository
- Automated build workflow
- Image publishing process
- Required GitHub secrets
- Verification steps
- Usage examples
- Troubleshooting guide
- Next steps

## File Structure

```
agregarr/
├── README.md                          # Main user documentation
├── DOCKER.md                          # Docker usage guide
├── CONTRIBUTING.md                    # Contributor guidelines
├── MIGRATION_TO_GITHUB.md            # Migration guide
├── SETUP_SUMMARY.md                  # Technical setup overview
├── GITHUB_SETUP_CHECKLIST.md         # Maintainer checklist
├── DOCUMENTATION_INDEX.md            # This file
│
├── .github/
│   ├── workflows/
│   │   ├── develop.yml               # Development workflow
│   │   ├── latest.yml                # Release workflow
│   │   └── docker-build.yml          # Manual build workflow
│   └── WORKFLOWS.md                  # Workflows reference
│
├── Dockerfile                         # Production Docker image
├── Dockerfile.local                   # Development Docker image
├── docker-compose.yml                 # Local dev compose file
└── .dockerignore                      # Docker build exclusions
```

## Common Tasks

### For End Users

**I want to install Agregarr**
→ Read [README.md](README.md) - Installation section

**I want to use Docker**
→ Read [DOCKER.md](DOCKER.md) - Using Docker Images section

**I'm currently using DockerHub**
→ Read [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md)

**I need help troubleshooting Docker**
→ Read [DOCKER.md](DOCKER.md) - Troubleshooting section

### For Contributors

**I want to contribute code**
→ Read [CONTRIBUTING.md](CONTRIBUTING.md) - Development Setup section

**I want to understand the CI/CD**
→ Read [.github/WORKFLOWS.md](.github/WORKFLOWS.md)

**I want to test Docker builds locally**
→ Read [CONTRIBUTING.md](CONTRIBUTING.md) - Docker Development section

**I need to understand commit conventions**
→ Read [CONTRIBUTING.md](CONTRIBUTING.md) - Commit Convention section

### For Maintainers

**I need to set up the repository**
→ Read [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md)

**I want to understand what was changed**
→ Read [SETUP_SUMMARY.md](SETUP_SUMMARY.md)

**I need to troubleshoot workflows**
→ Read [.github/WORKFLOWS.md](.github/WORKFLOWS.md) - Troubleshooting section

**I want to configure secrets**
→ Read [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md) - Step 1

## Search by Topic

### Docker

- **Building images:** [DOCKER.md](DOCKER.md)
- **Using images:** [README.md](README.md), [DOCKER.md](DOCKER.md)
- **Troubleshooting:** [DOCKER.md](DOCKER.md), [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md)
- **Multi-platform:** [DOCKER.md](DOCKER.md), [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md)

### GitHub Actions

- **Workflow reference:** [.github/WORKFLOWS.md](.github/WORKFLOWS.md)
- **Setup:** [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md)
- **Contributing:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **Troubleshooting:** [.github/WORKFLOWS.md](.github/WORKFLOWS.md), [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md)

### GitHub Container Registry (GHCR)

- **What is GHCR:** [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md)
- **Using GHCR:** [DOCKER.md](DOCKER.md), [README.md](README.md)
- **Setup:** [GITHUB_SETUP_CHECKLIST.md](GITHUB_SETUP_CHECKLIST.md)
- **Migration:** [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md)

### Contributing

- **Getting started:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **Commit format:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **Pull requests:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **Testing:** [CONTRIBUTING.md](CONTRIBUTING.md)

### Releases

- **Release process:** [CONTRIBUTING.md](CONTRIBUTING.md), [.github/WORKFLOWS.md](.github/WORKFLOWS.md)
- **Versioning:** [CONTRIBUTING.md](CONTRIBUTING.md), [MIGRATION_TO_GITHUB.md](MIGRATION_TO_GITHUB.md)
- **Creating releases:** [.github/WORKFLOWS.md](.github/WORKFLOWS.md)

## Getting Help

### Documentation Issues

If you find errors or unclear documentation:
1. Open an issue with the "documentation" label
2. Include:
   - Which file(s) are unclear
   - What you were trying to do
   - Suggestions for improvement

### Technical Issues

For technical problems:
1. Check the relevant troubleshooting section
2. Search existing issues
3. Open a new issue with:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Relevant logs or screenshots

### Questions

For questions:
1. Check if it's answered in the documentation
2. Use GitHub Discussions
3. Tag appropriately (docker, github-actions, etc.)

## Contributing to Documentation

Documentation improvements are welcome! When contributing:

1. **Keep it clear** - Write for users at all skill levels
2. **Keep it accurate** - Test any commands or examples
3. **Keep it organized** - Follow the existing structure
4. **Update this index** - If you add new documentation files

See [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process.

## Documentation Standards

Our documentation follows these principles:

- ✅ **Accurate** - All information is tested and verified
- ✅ **Complete** - Covers all major use cases
- ✅ **Accessible** - Written for various skill levels
- ✅ **Organized** - Easy to find what you need
- ✅ **Maintained** - Updated with code changes
- ✅ **Searchable** - Keywords and cross-references

## Last Updated

This documentation structure was established in December 2024 as part of the GitHub Container Registry migration.

For the latest updates, check the [CHANGELOG.md](CHANGELOG.md).

---

**Need something not covered here?** Open an issue or discussion!
