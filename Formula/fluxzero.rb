class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.2/flux-macos-arm64"
      sha256 "6b3899f78b9a21bbee62cce496f9c8734ec3dc52b40c233a4b198530dc24c668"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.2/flux-macos-amd64"
      sha256 "525e994c9f8631089e529adc7cae4d749b575169afa1abe6ab8008070ac2e48a"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.2/flux-linux-amd64"
      sha256 "89eff0f00dfd6df8bffd1440e334e6dcfb21643dbe52df9a0a505283c1fc8a6b"
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
