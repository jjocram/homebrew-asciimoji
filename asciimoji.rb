class Asciimoji < Formula
  desc "Program to search asciimoji saved in a local, editable file"
  homepage "https://gitlab.com/jjocram/asciimoji"
  url "https://gitlab.com/jjocram/asciimoji/-/archive/v1.2.1/asciimoji-v1.2.1.tar.gz"
  sha256 "7b1baad040220335c958b4dac1a6465f131389096b1afc3f4d21e52290c21ed5"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = shell_output("#{bin}/asciimoji shrug")
    assert_match "¯\\_(ツ)_/¯", output
  end
end
