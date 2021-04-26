class Asciimoji < Formula
  desc "Program to search asciimoji saved in a local, editable file"
  homepage "https://gitlab.com/jjocram/asciimoji"
  url "https://gitlab.com/jjocram/asciimoji/-/archive/v1.2.0/asciimoji-v1.2.0.tar.gz"
  sha256 "3f69ebecc4497760c6c120e9041a95512e5476a69efedf36192534b50b9e87db"
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
