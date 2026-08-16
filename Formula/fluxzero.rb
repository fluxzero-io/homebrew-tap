class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.1/flux-macos-arm64"
      sha256 "76fcc2f6daddbd9e3fc207208cb8f9ef95482f0eb51ad0e4703af6d5448ec429"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.1/flux-macos-amd64"
      sha256 "bc13847ba5efa5577f53b296062d63cc3d300a76c49448969bf9fe84a3bc5bef"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.1/flux-linux-amd64"
      sha256 "70763ccc4c4b947a8430d8929a68b42ca3886e766bc215fca4bc2b8dd6249a1f"
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
