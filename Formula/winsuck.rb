class Winsuck < Formula
  desc "Stream selected Windows NTFS files into WSL ext4"
  homepage "https://github.com/bonest/winsuck"
  url "https://github.com/bonest/winsuck/releases/download/v0.2.0/winsuck_0.2.0_linux_amd64.tar.gz"
  sha256 "2148d752030f17b6c3a5cbbb57447827f1d488c5d2852c489b2a47fd4b2dc507"
  license "MIT"

  skip_clean "bin/winsuck.exe"

  on_linux do
    resource "windows-sender" do
      url "https://github.com/bonest/winsuck/releases/download/v0.2.0/winsuck_0.2.0_windows_amd64.zip"
      sha256 "96b4044630ec97bb776b913ab48e35befc4e8f6a82feacff5b8ae22411d0f1e4"
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
