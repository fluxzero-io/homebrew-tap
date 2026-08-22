class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.16.0/flux-macos-arm64"
      sha256 "579e56e2d75ca6780eb39cbafc1a3a0b87e6e6af9bf10229d8f4062ecf43e58d"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.16.0/flux-macos-amd64"
      sha256 "78dbb42d03fa3ba9118b5a79c6d9eecdf9d9a4d1ff451bdcf7d1346f2b7fa77f"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.16.0/flux-linux-amd64"
      sha256 "142c411928230f8af1ec27e4f973546fe4b0e41499386cdfa71b85bd2b7aec37"
    end
  end

  def install
    binary = if OS.mac?
      Hardware::CPU.arm? ? "flux-macos-arm64" : "flux-macos-amd64"
    else
      "flux-linux-amd64"
    end

    bin.install binary => "fz"
    bin.install_symlink "fz" => "fluxzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fz version")
    assert_equal "fz", File.basename(File.readlink(bin/"fluxzero"))
  end
end
