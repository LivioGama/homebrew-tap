class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.5.0/pixel-v0.5.0-aarch64-apple-darwin.tar.gz"
  sha256 "eba3f303ed1252909d7837144b46fcd48d05f743e44dd991c99d11b7e41a83c7"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.0/pixel-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "eba3f303ed1252909d7837144b46fcd48d05f743e44dd991c99d11b7e41a83c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.0/pixel-v0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5ce854b25f100aca5ed0924d53a6f7c5e35abc33b90c143978c150c28c792495"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.0/pixel-v0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f4837101dfe476a350a4584696c0e44084bdf92c3d202e0aeb25cf205584bf84"
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
