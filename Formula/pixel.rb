class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.2/pixel-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "97a01eaa53dd9c5b93ea9da928fae7eff79e3e15cc592e48e71221cbf4e3cf83"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.2/pixel-v0.2.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "69c648554526eaf13cbb485c11e9bfb2c0f35431e130b48d986a8489179d83a2"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.2/pixel-v0.2.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3745e3c72810997f6a7e7cd2ca9cb86286cf0c3828757f044cc14b19b19ea98a"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
