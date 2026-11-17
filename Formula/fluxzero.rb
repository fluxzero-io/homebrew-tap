class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.24/flux-macos-arm64"
      sha256 "d27d2a51397674a1eb8e441588b112551ea68523e8709d33268f8afed2d1b5bf"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.24/flux-macos-amd64"
      sha256 "16b11aeca730cbbbd8c0c75ed43b7a8b6f273cceff50fc2ae8759b5987efcd5f"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.24/flux-linux-amd64"
      sha256 "28eab16149f5fbaa91f2f496130cdcbe627921213ce9359b84aada3bb974df35"
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
