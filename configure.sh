#!/usr/bin/env bash

declare -A osInfo=(
  [/etc/redhat-release]="yum"
  [/etc/arch-release]="pacman"
  [/etc/gentoo-release]="emerge"
  [/etc/SuSE-release]="zypp"
  [/etc/debian_version]="apt-get"
  [/etc/alpine-release]="apk"
)

# Programs to install
PROGRAMS=(
  uv
  stow
  nvim
  tmux
  git
  curl
  clangd
)

# Package name overrides
declare -A PACKAGE_NAMES=(
  [nvim]="neovim"
)

function install_packages() {
  local pm=""
  local packages=()

  # Detect package manager
  for f in "${!osInfo[@]}"; do
    if [[ -f "$f" ]]; then
      pm="${osInfo[$f]}"
      break
    fi
  done

  if [[ -z "$pm" ]]; then
    echo "Unsupported Linux distribution"
    return 1
  fi

  echo "Package manager: $pm"

  # Find missing programs
  for program in "${PROGRAMS[@]}"; do
    if ! command -v "$program" >/dev/null 2>&1; then
      packages+=("${PACKAGE_NAMES[$program]:-$program}")
    fi
  done

  # Nothing to install
  if [[ ${#packages[@]} -eq 0 ]]; then
    echo "All programs are already installed."
    return 0
  fi

  echo "Installing: ${packages[*]}"

  case "$pm" in
    apt-get)
      sudo apt-get update
      sudo apt-get install -y "${packages[@]}"
      ;;

    yum)
      sudo yum install -y "${packages[@]}"
      ;;

    pacman)
      sudo pacman -S --noconfirm "${packages[@]}"
      ;;

    zypp)
      sudo zypper install -y "${packages[@]}"
      ;;

    apk)
      sudo apk add "${packages[@]}"
      ;;

    *)
      echo "Unsupported package manager: $pm"
      return 1
      ;;
  esac
}

echo "Thank u for choosing https://github.com/nosurfer/dotfiles!"
echo

install_packages

echo
echo "Installed programs:"

for program in "${PROGRAMS[@]}"; do
  if command -v "$program" >/dev/null 2>&1; then
    echo "  ✓ $program"
  else
    echo "  ✗ $program"
  fi
done

echo

# Apply dotfiles
stow nvim tmux
# Install oh-my-zsh and uv
curl -LsSf https://astral.sh/uv/install.sh | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
