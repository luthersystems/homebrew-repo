class Mars < Formula
  desc "Luther Systems infrastructure management tool"
  homepage "https://github.com/luthersystems/mars"
  url "https://raw.githubusercontent.com/luthersystems/mars/v0.84.1/mars_macos.sh"
  sha256 "36a20625a07f3e9d5d5dd2f47409e7d46b97722091df6aef105834f12bc4a601"
  head "https://raw.githubusercontent.com/luthersystems/mars/main/mars_macos.sh"
  depends_on :macos

  def install
    bin.install "mars_macos.sh" => "mars"
  end

  def caveats
    <<~EOS
      Mars requires docker to be installed.  If it is not, you can
      install with `brew install homebrew/cask/docker`
    EOS
  end

  test do
    (testpath/".terraform-version").write("1.7.5")
    (testpath/".mars-version").write("v#{version}")
    assert_equal "Unable to locate docker.  Please install docker first.",
      shell_output("#{bin}/mars default init 2>&1", 1).strip
  end
end
