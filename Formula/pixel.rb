class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.11.0/pixel-v0.11.0-aarch64-apple-darwin.tar.gz"
  sha256 "7d8da0014dd64925e02ef2cf47cebae2738ff4fba29c62011184bf0fa9e6e23a"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.11.0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1015fb33d817cabedbd3ca8475cf369d78277c233a06eb5c29753601ef44b1f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cd93163459fe2c56d982f495b9b3dac465b9c7169b9074778a1684729c532fcc"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.11.0/pixel-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "7d8da0014dd64925e02ef2cf47cebae2738ff4fba29c62011184bf0fa9e6e23a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.11.0/pixel-v0.11.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8f8520191ee19cf80f8ab8d7a0dce498ae536cadd028d5a435052a5ba8c26588"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.11.0/pixel-v0.11.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "91e8eccd15455bc8121e4d24f2c7315cc3c26104e5a877b9609bb4f112d592a8"
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
