# AuthApp.ls File Merging Solution

This repository now includes comprehensive tools and documentation for merging files, specifically designed for the AuthApp.ls .NET 8 web application.

## Quick Start

### 1. Preview Configuration Merge
```bash
./scripts/merge-files.sh preview
```

### 2. Merge Configuration Files
```bash
./scripts/merge-files.sh config
```

### 3. Use PowerShell Script for Advanced Merging
```powershell
./scripts/merge-config.ps1 -BaseFile AuthApp.ls/appsettings.json -OverrideFile AuthApp.ls/appsettings.Development.json -ShowPreview
```

## What's Included

### 📁 Files Added

1. **`.gitignore`** - Prevents build artifacts from being committed
2. **`FILE_MERGE_GUIDE.md`** - Comprehensive merging documentation
3. **`scripts/merge-files.sh`** - Bash script for file merging operations
4. **`scripts/merge-config.ps1`** - PowerShell script for advanced JSON merging
5. **`README-MERGE.md`** - This file

### 🔧 Configuration Merge

The configuration files have been properly merged:

**Before:**
- `appsettings.json` had `AllowedHosts: "*"`
- `appsettings.Development.json` was missing this setting

**After:**
- Both files now have consistent configuration
- Development configuration inherits all base settings
- Environment-specific overrides are preserved

### 🚀 Usage Examples

#### Basic Configuration Merge
```bash
# Navigate to project root
cd /path/to/fluffy-octo

# Preview what will be merged
./scripts/merge-files.sh preview

# Perform the merge
./scripts/merge-files.sh config
```

#### Advanced JSON Merging with PowerShell
```powershell
# Show preview without saving
./scripts/merge-config.ps1 -BaseFile "AuthApp.ls/appsettings.json" -OverrideFile "AuthApp.ls/appsettings.Development.json" -ShowPreview

# Save to output file
./scripts/merge-config.ps1 -BaseFile "AuthApp.ls/appsettings.json" -OverrideFile "AuthApp.ls/appsettings.Development.json" -OutputFile "merged-config.json"
```

#### Git-based File Merging
```bash
# For merge conflicts
git status
git mergetool

# Three-way merge
git merge-file current.json base.json incoming.json
```

## Verification

### Build Test
```bash
dotnet build
# ✅ Build succeeded. 0 Warning(s) 0 Error(s)
```

### Configuration Test
The merged configuration properly combines:
- Base logging settings
- Development environment settings  
- Host configuration
- Environment-specific overrides

### Runtime Test
```bash
dotnet run --environment Development
# ✅ Application starts successfully with merged configuration
```

## Tools and Dependencies

### Required
- ✅ .NET 8 SDK
- ✅ Git

### Recommended  
- ✅ jq (JSON processor) - Already installed
- ✅ PowerShell (for advanced scripting)
- 📦 Visual Studio Code (with merge conflict extensions)
- 📦 Beyond Compare or similar merge tools

## File Structure

```
fluffy-octo/
├── .gitignore                     # Build artifact exclusions
├── FILE_MERGE_GUIDE.md           # Comprehensive merge documentation
├── README-MERGE.md               # This quick start guide
├── scripts/
│   ├── merge-files.sh            # Bash merge utility
│   └── merge-config.ps1          # PowerShell JSON merger
└── AuthApp.ls/
    ├── appsettings.json          # ✅ Base configuration (updated)
    ├── appsettings.Development.json # ✅ Dev configuration (updated)
    └── ...                       # Other project files
```

## Next Steps

1. **Read the Full Guide**: See `FILE_MERGE_GUIDE.md` for detailed merging strategies
2. **Test Your Changes**: Run `dotnet build && dotnet test` after any merges
3. **Use Version Control**: Always commit working state before major merges
4. **Customize Scripts**: Modify the provided scripts for your specific needs

## Support

For detailed information about:
- 📖 **Complex merge scenarios** → See `FILE_MERGE_GUIDE.md`
- 🔧 **Script customization** → Check script comments and parameters
- 🐛 **Troubleshooting** → Review the troubleshooting section in the main guide
- 🏗️ **Build issues** → Ensure `.gitignore` is properly configured

## Benefits Achieved

✅ **Proper Configuration Management** - Consistent settings across environments  
✅ **Automated Merge Tools** - Scripts for common merge operations  
✅ **Clean Repository** - Build artifacts excluded from version control  
✅ **Comprehensive Documentation** - Detailed guides and examples  
✅ **Cross-Platform Support** - Both Bash and PowerShell solutions  
✅ **Verification Tools** - Built-in testing and validation