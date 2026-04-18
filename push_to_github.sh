#!/bin/bash
# HateFusion GitHub Upload Helper Script
# This script will push your local repository to GitHub

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║        HateFusion - GitHub Upload Helper                     ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📋 This script will push your HateFusion repository to GitHub"
echo ""
echo "⚠️  IMPORTANT: You must have:"
echo "   1. Created repository at https://github.com/new"
echo "   2. Configured GitHub authentication (PAT or SSH)"
echo ""
read -p "Have you completed these steps? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Please complete the setup first!"
    echo "   → Go to https://github.com/new to create repository"
    echo "   → Get PAT from https://github.com/settings/tokens"
    exit 1
fi

echo ""
echo "Starting push to GitHub..."
echo ""

cd "D:\hatefusion_project\HateFusion" || exit 1

# Check remote is configured
if ! git remote get-url origin &>/dev/null; then
    echo "❌ Remote not configured"
    exit 1
fi

echo "✅ Repository: $(git remote get-url origin)"
echo "✅ Branch: $(git branch --show-current)"
echo "✅ Commits: $(git rev-list --all --count)"
echo ""

# Try to push
echo "Pushing to GitHub..."
if git push -u origin main; then
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                    ✅ SUCCESS! ✅                              ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🎉 Your repository is now live!"
    echo ""
    echo "📍 View at: https://github.com/kirubaharan181/HateEmofusion"
    echo ""
    echo "📝 Next steps:"
    echo "   1. Add repository topics (go to Settings)"
    echo "   2. Enable GitHub Pages (optional)"
    echo "   3. Invite collaborators (if needed)"
    echo ""
else
    echo ""
    echo "❌ Push failed!"
    echo ""
    echo "Troubleshooting:"
    echo "   • Check if repository exists on GitHub"
    echo "   • Verify your authentication token/SSH key"
    echo "   • Try: git status"
    exit 1
fi
