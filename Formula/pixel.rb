class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.10.0/pixel-v0.10.0-aarch64-apple-darwin.tar.gz"
  sha256 "e5fc2e598458520f35f3f9000ca92b61f2610e886139a1d62fdaa685d8eb28b6"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.10.0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "271ce0b03f546e5326522df883cb11032547214271f9031c864d39863b7f2899"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "39c7433fd151a57f3cc619e2761ed8d21167a6ce24edd9ba1cc2c55c39b71c34"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.10.0/pixel-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "e5fc2e598458520f35f3f9000ca92b61f2610e886139a1d62fdaa685d8eb28b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.10.0/pixel-v0.10.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b04a9167aaa5e86f702a486b1f5f77b8885d0bbda7e578552190f131ba0ea59d"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.10.0/pixel-v0.10.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2e7e4e3e9c45d679c342615c0986ba889e7cc3a1bfc00a933ba38841afa16764"
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
