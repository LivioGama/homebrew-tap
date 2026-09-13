class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.4/pixel-v0.2.4-aarch64-apple-darwin.tar.gz"
      sha256 "2ba6e038c3855df2e30699c10b3ca80cf7eacc372f07e186420a283006390b39"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.4/pixel-v0.2.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2d3f0352aebf9f02678f8dbc7c1001fa46297505163e255882a8050d7a93f19e"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.4/pixel-v0.2.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "40e719751ad388131df9a5cb42ddb2b2fbaa2ffae5995c8a49904b75c80ef35c"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
