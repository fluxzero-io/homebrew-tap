class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.8.2"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.2/flux-macos-arm64"
      sha256 "523f8af886ca7b9632e3a09f30d72484d6bbcdca6cf1bfca5a4dc7d8b33d9132"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.2/flux-macos-amd64"
      sha256 "a9befadb3e0726c1e7f4357a1a317394c735a8b98b10f028a7fc7733df41fdc6"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.2/flux-linux-amd64"
      sha256 "a63a6cd5a590b90174c3e7efad57dda2de70af6e93591775267ad38f72375064"
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
