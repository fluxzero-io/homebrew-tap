class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.0/flux-macos-arm64"
      sha256 "b8d05d0869b189e98b6f95dd31596ec613077045af89486e5975d73dd9f01644"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.0/flux-macos-amd64"
      sha256 "026d4ecb5a27502ddef9f7d7eeb8a166eaf267b577f196bd5ac46ebde67fc170"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.0/flux-linux-amd64"
      sha256 "260859a22bc45a02baa31d35954685e5af5dec594d71291794824cb97efe7772"
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
