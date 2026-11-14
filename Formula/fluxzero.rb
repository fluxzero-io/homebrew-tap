class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.18/flux-macos-arm64"
      sha256 "fc57ba87fcd0ea4fff100d8db183b6e19c1b99c3f901cb8fba2ae03667ba35ba"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.18/flux-macos-amd64"
      sha256 "f26779abf094c4ea4ed36b824f55b2a817d8db6da25d63d483a15aa75cad4340"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.18/flux-linux-amd64"
      sha256 "6b681d5bd2e5bf934a626f6900d9d0c4c80c47c51035f2b69ab799e0e1bdc581"
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
