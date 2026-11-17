class Jolta < Formula
  desc "Automatic per-project JDK switching - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  version "0.9.0"
  license "MIT"

  head do
    url "https://github.com/OneAppPlatform/jolta.git", branch: "main"

    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-apple-darwin.tar.gz"
      sha256 "2f1bf967cdc98f37c4f46a37a290bfa08b0cd4080d44665859749593d0864a1e"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-apple-darwin.tar.gz"
      sha256 "84ea05f7880f115ef6d9567fb9255bbae453fa8d5e9aa9a489cd61aeffeea44e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eb78725d90b5348951b03d82eea9d6a770381271ca6feab681e8a3f00eaaf4ea"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dea7484a13e9937bce9d419416683c42a08b3ea9f8c6f471306312362bdae474"
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
