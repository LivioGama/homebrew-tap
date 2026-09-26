class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.5.2/pixel-v0.5.2-aarch64-apple-darwin.tar.gz"
  sha256 "966162ab2a3967e948d504c2465142d956993c292bca9d19d97309df572575dc"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.2/pixel-v0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "966162ab2a3967e948d504c2465142d956993c292bca9d19d97309df572575dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.2/pixel-v0.5.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "efebd0bbeef336059bd5de4be2b2eff814bd42e4978d289f78ea6511ec47e263"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.2/pixel-v0.5.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a721c4f012d3e4a60b12a789a222c0b4c84fe67504a05970d1e84a0128f5b068"
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
