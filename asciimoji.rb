class Asciimoji < Formula
  desc "Program to search asciimoji saved in a local, editable file"
  homepage "https://gitlab.com/jjocram/asciimoji"
  url "https://gitlab.com/jjocram/asciimoji/-/archive/1.1.0/asciimoji-1.1.0.tar.gz"
  sha256 "616255fb7f8519010e7b71a51f13218b2cb6516542b7461ed3a82d096a408968"
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
