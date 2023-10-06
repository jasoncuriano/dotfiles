# Install Node
if ! which -s n; then
    echo "n node version manager not found, attempting install."
else
    # Make sure we’re using the latest Homebrew.
    echo "n node version manager already installed, running 'n latest'"
    n latest
fi