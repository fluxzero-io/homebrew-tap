class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.2/flux-macos-arm64"
      sha256 "45928de0bee915983ef00a69df47ffe55cf81da25e96b5fced7dfa17f75aea8f"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.2/flux-macos-amd64"
      sha256 "d46e5f95f789dce248272acafa756209218f0d7a6d1e969546224e287f613e36"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.2/flux-linux-amd64"
      sha256 "00aff08a15c4dcb80928d77456a0893d594cd8538096660722a465f5f1fc867a"
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
