class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.12.0/pixel-v0.12.0-aarch64-apple-darwin.tar.gz"
  sha256 "369e564efc6e803d3eb63ac3ff57370260a31c8a26c91e6164c5178fb61eda9b"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.12.0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f923aaac5627970cf39c431ac55ff45a16a179e8aa766ea3f0a2870dfd95435f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6397d9b4b938fdb12963f520507558ac2a66f742d8519e29a0a9e916be470ba5"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.12.0/pixel-v0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "369e564efc6e803d3eb63ac3ff57370260a31c8a26c91e6164c5178fb61eda9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.12.0/pixel-v0.12.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c4e697370cadbe1537055a5c10515bc5e41430a37c13af05e838714472367988"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.12.0/pixel-v0.12.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "234f65b54504147e43b8073ba14ccd5a57bba1ec7d297b184b25d2c069b0e979"
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
