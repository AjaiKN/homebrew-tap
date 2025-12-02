class AknTrash < Formula
  desc "Bash CLI for putting files in the trash"
  homepage "https://github.com/AjaiKN/trash"
  url "https://github.com/AjaiKN/trash/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "7e5c0a5819bd63fb85f8a680deb2a3d62c04d73ff0fddfd1abeb2e732945dc4c"
  license "GPL-3.0-or-later"

  def install
    bin.install Dir["bin/*"]
    man.install Dir["man/*"]
    zsh_completion.install "_trash"
  end

  test do
    # brew test --verbose --keep-tmp akn-trash
    shell_output "touch #{testpath}/a_file.txt"
    assert_path_exists testpath/"a_file.txt"
    puts shell_output "#{bin}/trash --dry-run -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    assert_path_exists testpath/"a_file.txt"
    puts shell_output "#{bin}/trash -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    refute_path_exists testpath/"a_file.txt"
  end
end
