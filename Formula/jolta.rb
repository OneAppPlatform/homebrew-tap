class Jolta < Formula
  desc "Hands-off Java version manager - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  url "https://github.com/OneAppPlatform/jolta/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "28fdc8b1a4e266e4a24a82eef411e718d1c57d669e2db7b38ed71b325c598d71"
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
