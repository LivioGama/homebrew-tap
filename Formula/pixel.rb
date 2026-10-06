class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.1/pixel-v0.7.1-aarch64-apple-darwin.tar.gz"
  sha256 "36d2005900d9592b04dce7c8483e3506736e20c227d37700049b4a671aa143c2"
  license "MIT"

  # Linux only: the static musl binary laid out as a keg, poured without
  # the C compiler a build from source would require. macOS installs from
  # its archive below.
  bottle do
    root_url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "32e8f7dffd554f5fd1e0d5631740111b7a36a6c56f1054aeb5670baa4c70581c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6bc6822a877747159a0a7d6a4737b5dd4f1519bf6de03ea3de607811fa32d823"
  end

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.1/pixel-v0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "36d2005900d9592b04dce7c8483e3506736e20c227d37700049b4a671aa143c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.1/pixel-v0.7.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "98491fbf36c0bb3890acef496b6b56baf0725df0c800b71b920502dbfe23ce7c"
    end
    on_intel do
      url "https://github.com/Pixel-CLI/pixel/releases/download/v0.7.1/pixel-v0.7.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a00b9f0d96e8ce8e6155f6999bf60072c64b5404355b79b2a69ec1f5ec63c7a7"
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
