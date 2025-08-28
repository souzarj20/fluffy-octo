# File Merging Guide for AuthApp.ls

This guide provides comprehensive instructions for merging files in the AuthApp.ls project.

## Overview

The AuthApp.ls project is a .NET 8 ASP.NET Core web application with a layered architecture. This guide covers various types of file merging scenarios you might encounter.

## Types of File Merging

### 1. Configuration File Merging

#### appsettings.json Files
The project uses multiple appsettings files for different environments:
- `appsettings.json` - Base configuration
- `appsettings.Development.json` - Development-specific overrides

**Merged Configuration Result:**
```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information", 
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```

### 2. Source Code File Merging

#### Current Project Structure
```
AuthApp.ls/
├── App.Model/Entity/Layer.cs
├── App.Services/LayerService/Service.cs
├── App.EndPoints/LayerController/Controller.cs
└── App.Migrations/Migrations.cs
```

#### Best Practices for Code Merging
1. **Namespace Consistency**: Ensure all merged classes maintain proper namespace hierarchy
2. **Dependency Injection**: Register services properly in Program.cs
3. **Layered Architecture**: Maintain separation of concerns

### 3. Git Merge Operations

#### When Merge Conflicts Occur
```bash
# Check for conflicts
git status

# View conflicted files
git diff --check

# Resolve conflicts manually or using merge tools
git mergetool

# Mark as resolved and commit
git add .
git commit -m "Resolve merge conflicts"
```

## Merge Scenarios

### Scenario 1: Merging Configuration Files

When you have different environment configurations:

```bash
# Compare configurations
diff appsettings.json appsettings.Development.json

# Manually merge ensuring environment-specific settings are preserved
```

### Scenario 2: Merging Class Files

When combining functionality from multiple classes:

1. **Identify Common Interfaces**: Extract shared functionality
2. **Merge Methods**: Combine non-conflicting methods
3. **Resolve Conflicts**: Choose appropriate implementation for conflicting methods
4. **Update References**: Update all references to merged classes

### Scenario 3: Merging Branch Changes

```bash
# Switch to target branch
git checkout main

# Merge feature branch
git merge feature-branch

# If conflicts occur, resolve them
# Then commit the merge
git commit -m "Merge feature-branch into main"
```

## Automated Merge Tools

### Using Git for File Merging
```bash
# Three-way merge
git merge-file current-file base-file other-file

# Using external merge tool
git config merge.tool vimdiff
git mergetool
```

### Using PowerShell for Config Merging
```powershell
# Example PowerShell script for JSON merging
$base = Get-Content appsettings.json | ConvertFrom-Json
$dev = Get-Content appsettings.Development.json | ConvertFrom-Json

# Merge logic here
# Output merged configuration
```

## Verification Steps

After any merge operation:

1. **Build the Project**
   ```bash
   dotnet build
   ```

2. **Run Tests** (if available)
   ```bash
   dotnet test
   ```

3. **Verify Configuration**
   ```bash
   dotnet run --environment Development
   ```

## Common Merge Patterns

### Pattern 1: Additive Merge
- Combine non-conflicting additions
- Preserve all unique functionality

### Pattern 2: Override Merge  
- Use environment-specific overrides
- Maintain base configuration

### Pattern 3: Strategic Merge
- Choose best implementation
- Document decision rationale

## Troubleshooting

### Build Errors After Merge
1. Check for duplicate using statements
2. Verify namespace consistency
3. Ensure all dependencies are properly referenced

### Runtime Errors
1. Verify dependency injection registration
2. Check configuration binding
3. Validate environment-specific settings

## Best Practices

1. **Always backup** files before merging
2. **Test thoroughly** after merging
3. **Document changes** in commit messages
4. **Use meaningful branch names** for tracking
5. **Review diffs** before committing merged changes

## Tools and Resources

- **Git**: Primary version control and merging tool
- **Visual Studio**: Built-in merge conflict resolution
- **VS Code**: Extensions for merge conflict resolution
- **Beyond Compare**: Third-party merge tool
- **KDiff3**: Free merge tool