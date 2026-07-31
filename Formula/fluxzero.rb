class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.13.0/flux-macos-arm64"
      sha256 "9f8eb4851a7425826618884b6b44fd18bab0210a2cce62c0b6bf9d4685ff5ae3"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.13.0/flux-macos-amd64"
      sha256 "0109626d963a763dfa8f1de542e0cba8891683c4ad08ee36fb6decda4a9d5434"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.13.0/flux-linux-amd64"
      sha256 "8b2b6bc004f55a2be0aad86b7f26cba97efa812e492b13244105e56728876d5c"
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
