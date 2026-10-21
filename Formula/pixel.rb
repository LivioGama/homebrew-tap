class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.9.0/pixel-v0.9.0-aarch64-apple-darwin.tar.gz"
  sha256 "27dc12e4a7cb5af286de2b6f6c6e7bac559a384073342f5fde63b304b9f07077"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "2d18eea96fd08c9dc42b8baf663a429026c5066b947e6a34e3263643687a71a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f98b6b7d1bd08493735032166a07c11ef1d8480bd991061b920b180722c84c10"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.9.0/pixel-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "27dc12e4a7cb5af286de2b6f6c6e7bac559a384073342f5fde63b304b9f07077"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.9.0/pixel-v0.9.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a114083d9a2acc612ed7beedac96b4a9dbf6e83e48fe9b2732d8669e379ac98f"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.9.0/pixel-v0.9.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "77ef3e937be6fb812f44a21401253423f2e005ea1fa4ff54f574a29891e6fc7c"
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
