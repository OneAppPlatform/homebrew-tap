class Jolta < Formula
  desc "Automatic per-project JDK switching - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  version "0.8.7"
  license "MIT"

  head do
    url "https://github.com/OneAppPlatform/jolta.git", branch: "main"

    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-apple-darwin.tar.gz"
      sha256 "c49043ff6a7af4d3ea6c3018874bcf00b1544650ded81b331cb65448a512f796"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-apple-darwin.tar.gz"
      sha256 "53ac05a50f81a52d32b7e518c6def470b39da59ddd10fb8879eb7a5b483fd508"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-aarch64-unknown-linux-musl.tar.gz"
      sha256 "450ce4a2515db079a09d32e7cc7627380acad3d1e0ccd9aa6c8ef79c931b0eed"
    end
    on_intel do
      url "https://github.com/OneAppPlatform/jolta/releases/download/v#{version}/jolta-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d6db1a0cacddb8978fb053009f839c270fe537c50fdde4d9a3f8a538caeaae5f"
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
