# Install Python via pyenv
if ! which -s pyenv; then
    echo "pyenv not found, cannot setup Python"
else
    echo "pyenv already installed, running 'pyenv install 3.12'"
    pyenv install 3.12
    pyenv global 3.12
fi

# Install Poetry for python
if ! which -s poetry; then
    echo "Poetry not found, attempting install."
    curl -sSL https://install.python-poetry.org | POETRY_HOME="$HOME/.poetry/" python3 -
else
    # Make sure we’re using the latest Homebrew.
    echo "Poetry already installed, running 'poetry self update'"
    poetry self update
    poetry config virtualenvs.prefer-active-python true
fi
