class Jolta < Formula
  desc "Hands-off Java version manager - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  version "0.5.2"
  license "MIT"

  head do
    url "https://github.com/OneAppPlatform/jolta.git", branch: "main"

    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-apple-darwin.tar.gz"
      sha256 "12bf16c8dbcf4b035445c2306b4dcc023afabe5bfa50c2da17e1a1d88b99d339"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-apple-darwin.tar.gz"
      sha256 "b608aad9a562896bfc75b5d08061b1ce0b3d9463836c3520e7cb4ca067c76e3f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6280d0bfa3c8765f307ad0bcb078e48ce546eaa78565ecc22a1e6b42e23fe83d"
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
