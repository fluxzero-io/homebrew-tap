class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.7.2"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.7.2/flux-macos-arm64"
      sha256 "494dae4551d5664d2a5787aaea02a801c16d3620549478b29a8d75aa1a668955"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.7.2/flux-macos-amd64"
      sha256 "09e79ed8f61ed8e0cdbe90a1178cda4c08b504b6bf8fd1b779905ad8471b8b2b"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.7.2/flux-linux-amd64"
      sha256 "0d14d9e9aa123523256632e66975eab677d97fd5037e7c67ea74a5392c989d78"
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
