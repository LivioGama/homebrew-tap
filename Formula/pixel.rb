class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.0/pixel-v0.7.0-aarch64-apple-darwin.tar.gz"
  sha256 "8d5728c2999fe6252bee05171c134556b99c9462af88bfc0413d008e1b7e107c"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8c24d3e63cff37eae7910d732cb21d17ecbc713850a17153c3324820a95d68fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "79387504079d136e52e68ed3fe7b07c8b71500c137452efba241634297016238"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.0/pixel-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "8d5728c2999fe6252bee05171c134556b99c9462af88bfc0413d008e1b7e107c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.0/pixel-v0.7.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a2b949e88ac652497fb3bf891b3c8dbe152ff95777e8900bde7298666cc17e9f"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.0/pixel-v0.7.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0251b4fb7ed09944d3ebcd9788b9d262327899d04c1b6f534641ec0710493acb"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  # An upgrade replaces the binary only; the agent wiring it
  # deployed lives in the user's home and is refreshed by
  # running pixel install.
  def caveats
    <<~EOS
      Homebrew upgrades replace the binary only. The agent prompt, shell
      wrapper and per-agent config keys are written by "pixel install"
      into your home, not by Homebrew, so they keep the old release's
      text until refreshed:

        pixel install
        pixel doctor .

      "pixel doctor" reports missing or stale wiring.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
