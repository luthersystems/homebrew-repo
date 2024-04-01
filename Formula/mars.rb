class Mars < Formula
  desc "Luther Systems infrastructure management tool"
  homepage "https://github.com/luthersystems/mars"
  url "https://raw.githubusercontent.com/luthersystems/mars/v0.83.1/mars_macos.sh"
  sha256 "2c33bf0a644ed443c6e767a624b931c948d123da4e0bacf17d2cb09f0e6c84ae"
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
