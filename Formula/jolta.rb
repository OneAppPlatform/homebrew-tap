class Jolta < Formula
  desc "Hands-off Java version manager - like Volta, but for Java"
  homepage "https://oneappplatform.github.io/jolta/"
  url "https://github.com/OneAppPlatform/jolta/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "4daa3e314370954b7764a1e32c20c9da0bba5af3a892fd610c5185f81b739a25"
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
