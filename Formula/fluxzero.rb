class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.15/flux-macos-arm64"
      sha256 "65c7f46b44fcf6e1a4d09a166ca919e200be52d4e7b3a3216e1cf62261ccffcd"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.15/flux-macos-amd64"
      sha256 "4f3f9f0d830bbe693427f5bbe9ea061f0ec2874a588b758b8da63d125325505a"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.15/flux-linux-amd64"
      sha256 "bee70f41a8a9930e1bd02866b06c7c6c7956f2ae1de74c4f26483df0bd834b5f"
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
