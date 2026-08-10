class Jolta < Formula
  desc "Automatic per-project JDK switching - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  version "0.8.5"
  license "MIT"

  head do
    url "https://github.com/OneAppPlatform/jolta.git", branch: "main"

    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-apple-darwin.tar.gz"
      sha256 "1470467c487cfa07074231aea932d1b17a183ff3dc17146859aef6a70ff45fd1"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-apple-darwin.tar.gz"
      sha256 "3545f5ceeaf88456132c1026b0a2737be6d89dfbc797cfb8039e9df38bdbfa89"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9cfd4b1b1d0a364d806e9e6fa58700ffca213e8ef49cd2e814c307641af23811"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3a7de6417016ad3b484e7dd2bf7cb1c6580675904aacaa3ad795e6df8ed396c4"
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
