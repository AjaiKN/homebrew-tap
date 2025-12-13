class ZapSh < Formula
  desc "Bash CLI for putting files in the trash"
  homepage "https://github.com/AjaiKN/zap.sh"
  url "https://github.com/AjaiKN/zap.sh/archive/refs/tags/v0.0.10.tar.gz"
  sha256 "952d780423dba4e74a318b1ebca3240b70d6c64e2a340d82141a0c107820cda3"
  license "GPL-3.0-or-later"

  def install
    bin.install Dir["bin/*"]
    man.install Dir["man/*"]
    zsh_completion.install "_zap"
  end

  test do
    # brew test --verbose --keep-tmp zap.sh
    shell_output "touch #{testpath}/a_file.txt"
    assert_path_exists testpath/"a_file.txt"
    puts shell_output "#{bin}/zap --dry-run -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    assert_path_exists testpath/"a_file.txt"
    puts shell_output "#{bin}/zap -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    refute_path_exists testpath/"a_file.txt"
  end
end
