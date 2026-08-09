class Jolta < Formula
  desc "Hands-off Java version manager - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  version "0.8.4"
  license "MIT"

  head do
    url "https://github.com/OneAppPlatform/jolta.git", branch: "main"

    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-apple-darwin.tar.gz"
      sha256 "32f171c0022d75260460977ebc2504516364b2590e118536d2afeba64a27b82b"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-apple-darwin.tar.gz"
      sha256 "28c7185c0cdd644428d1be2519602c39aa6d41e51f765b63f82962a2ccd1f10f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7d697a7e2137d7952a20168986b193182a1589e28943d363e050885eb76adbaf"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d1b04ce9be0ea809f890364aa04374f1c15df385fcda43201a96bcddf77dda6"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "jolta"
    end
  end

  def caveats
    <<~EOS
      To finish setup (shims in ~/.jolta, PATH, and the JAVA_HOME hook), run:
        jolta setup
      Then open a new shell and verify with `jolta doctor`.
    EOS
  end

  test do
    assert_match "jolta #{version}", shell_output("#{bin}/jolta version")
    assert_match "Usage", shell_output("#{bin}/jolta help")
  end
end
