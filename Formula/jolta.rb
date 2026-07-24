class Jolta < Formula
  desc "Hands-off Java version manager - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  url "https://github.com/OneAppPlatform/jolta/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "f4c0e1c517184674244958d09a99e9f84cdcf3192cd4a76dccfc7f05835e9833"
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
