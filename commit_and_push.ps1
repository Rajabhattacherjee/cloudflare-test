param (
    [string]$commitMessage
)

# If no commit message is provided, prompt the user
if (-not $commitMessage) {
    $commitMessage = Read-Host "Enter commit message"
}

# Navigate to the Git repository (update if needed)
$repoPath = (Get-Location)  # Assumes script is run from the repo root
Set-Location $repoPath

# Check if there are staged changes to commit
$gitDiff = git diff --cached --quiet

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ No staged changes to commit. Exiting."
    exit
}

# Commit the staged changes with the provided message
git commit -m "$commitMessage"
Write-Host "✅ Changes committed: $commitMessage"

# Push changes to remote repository
git push origin main  # Change 'main' if using a different branch
Write-Host "🚀 Changes pushed to remote repository."

