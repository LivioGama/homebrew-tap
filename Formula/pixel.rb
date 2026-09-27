class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.6.0/pixel-v0.6.0-aarch64-apple-darwin.tar.gz"
  sha256 "acdc21bd27012e206801e046464b06ce51ef5861e368bed383fddedaa840e23e"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.6.0/pixel-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "acdc21bd27012e206801e046464b06ce51ef5861e368bed383fddedaa840e23e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.6.0/pixel-v0.6.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4bb3c8e8b5b5f0c2a4e613894130f9b1205bff75a0f0440f4c94a0fb97b2d878"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.6.0/pixel-v0.6.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "98f367dc431b5e2a6a655232d80afd745386a802041f5f21d4daa29a19269149"
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
