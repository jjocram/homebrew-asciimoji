class Asciimoji < Formula
  desc "Program to search asciimoji saved in a local, editable file"
  homepage "https://gitlab.com/jjocram/asciimoji"
  url "https://gitlab.com/jjocram/asciimoji/-/archive/v1.3.0/asciimoji-v1.3.0.tar.gz"
  sha256 "ec99a768e394e5c32f1f7ab02ffa473d2930d57f4e530b9ee2476f666acbbdd0"
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
