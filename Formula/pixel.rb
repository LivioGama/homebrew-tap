class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.8.0/pixel-v0.8.0-aarch64-apple-darwin.tar.gz"
  sha256 "f2940d6984bceceb826c282c13b4a2822f8dec8b17b8b9e62c94c112c6acb947"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7154a26b5f84072bfca7ae2bef3994f90ca0139508f04a83cc2182ec249481a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e47286e08bd42f92d854f008405106cf9d0f262ebd4174fce500e87c419e7771"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.8.0/pixel-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "f2940d6984bceceb826c282c13b4a2822f8dec8b17b8b9e62c94c112c6acb947"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.8.0/pixel-v0.8.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8bbcc5b9c12c16bda3abde2bd8e1f39f9580c58c72a98a247eb5293a0443d520"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.8.0/pixel-v0.8.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9b94ad66a702daed521ac6f1ca40862ffb060b39d2e686c7f4e330b9f786e9cb"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  # An upgrade replaces the binary only; the agent wiring it
  # deployed lives in the user's home and is refreshed by
  # running pixel setup.
  def caveats
    <<~EOS
      Homebrew upgrades replace the binary only. The agent prompt, shell
      wrapper and per-agent config keys are written by "pixel setup"
      into your home, not by Homebrew, so they keep the old release's
      text until refreshed:

        pixel setup
        pixel doctor .

      "pixel doctor" reports missing or stale wiring.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
