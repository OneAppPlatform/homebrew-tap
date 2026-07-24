class Jolta < Formula
  desc "Hands-off Java version manager - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  url "https://github.com/OneAppPlatform/jolta/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "2c4f4a65aab81f4d2b36ce6dc4ec1523f1ff0b91ccca6700af1dfc848f42ca01"
  license "MIT"
  head "https://github.com/OneAppPlatform/jolta.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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
