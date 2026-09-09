class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.4/flux-macos-arm64"
      sha256 "6e142d8567cbadeddb5b25aad551df29d3b3b5344da344a01ef895495af06eba"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.4/flux-macos-amd64"
      sha256 "b004cf4d3ebb1558f54c4b916a454ceeafd10ec840b1bb68f42ee304498c8902"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.4/flux-linux-amd64"
      sha256 "e905b66f3d54bd7bcf2fd0264f38cbe508bd425f9910cc3d2315581d19f1b359"
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
