class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.5/pixel-v0.2.5-aarch64-apple-darwin.tar.gz"
      sha256 "5e3d9c098fa4eb9cac762389a8caab41d2ab5b1fffe97f1344448aebf491e650"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.5/pixel-v0.2.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "538cbae13026ab041347aede38741d296efb5398ed8c98539cb98f70fe89f715"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.5/pixel-v0.2.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a9545f01faa400aa5532bab5d4e6ec3097e2d588a84e6c8583f9e3947f9634f3"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
