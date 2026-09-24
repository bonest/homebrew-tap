class Winsuck < Formula
  desc "Stream selected Windows NTFS files into WSL ext4"
  homepage "https://github.com/bonest/winsuck"
  url "https://github.com/bonest/winsuck/releases/download/v0.1.0/winsuck_0.1.0_linux_amd64.tar.gz"
  sha256 "395ab2bc339b9329a23b9826a3047be4f729e3b692324c8e08633015784788cc"
  license "MIT"

  skip_clean "bin/winsuck.exe"

  on_linux do
    resource "windows-sender" do
      url "https://github.com/bonest/winsuck/releases/download/v0.1.0/winsuck_0.1.0_windows_amd64.zip"
      sha256 "e4a94a6b37d64402134274b8f6548b930529955370f87dbe2a21422ddd5afb1d"
    end
  end

  def install
    odie "winsuck supports WSL/Linux only" unless OS.linux?

    bin.install "winsuck"
    resource("windows-sender").stage do
      bin.install "winsuck.exe"
      chmod 0755, bin/"winsuck.exe"
    end
  end

  test do
    system "#{bin}/winsuck", "--version"
  end
end
