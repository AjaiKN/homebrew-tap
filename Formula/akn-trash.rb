# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://docs.brew.sh/rubydoc/Formula
class AknTrash < Formula
  desc "A bash CLI for putting files in the trash"
  homepage "https://github.com/AjaiKN/trash"
  url "https://github.com/AjaiKN/trash/archive/refs/tags/v0.0.3.zip"
  sha256 "93e423e2c0fa4c9771dd6af2011980d21b5d0b2a4593f2c44b59a5d511c641d2"
  license "GPL-3.0"

  def install
    bin.install Dir["bin/*"]
    man.install Dir["man/*"]
    zsh_completion.install "_trash"
  end

  test do
    # brew test --verbose --keep-tmp akn-trash
    shell_output "touch #{testpath}/a_file.txt"
    assert_predicate testpath/"a_file.txt", :exist?
    puts shell_output "#{bin}/trash --dry-run -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    assert_predicate testpath/"a_file.txt", :exist?
    puts shell_output "#{bin}/trash -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    refute_predicate testpath/"a_file.txt", :exist?
  end
end
