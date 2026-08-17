class Jolta < Formula
  desc "Automatic per-project JDK switching - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  version "0.8.6"
  license "MIT"

  head do
    url "https://github.com/OneAppPlatform/jolta.git", branch: "main"

    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-apple-darwin.tar.gz"
      sha256 "1deed942d2b30d34d1a2638300f8a73d9bc95d4b55fe7f67d9254aa77a68d25b"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-apple-darwin.tar.gz"
      sha256 "3d55292b04240434df77f6480eb775c2c2815a6c96f43d3f322a4d55cb2faea4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bacc6180ecad3c947acb2c3a57779149a5018dbc4df9217504b2649a58e4fbe9"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d4aad0281e396dc6fe769eb36e57f05c5f4b7c47a50ff11288ee4c1b7e21b756"
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
