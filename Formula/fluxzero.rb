class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.12/flux-macos-arm64"
      sha256 "30d085bb4f0739fd655d14a32c6f3113a58883450c0146339a1ca822ad9c0e06"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.12/flux-macos-amd64"
      sha256 "e43f4e5e07a5ec5f6b38ad08c25dd8bdd1ae2c7cb926186f0019987037a2a632"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.12/flux-linux-amd64"
      sha256 "e8cb7b42e8c08a70a5428361a4bd8606b32421b4c9a4373ab226da9c0b3ba4af"
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
