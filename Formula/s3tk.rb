class S3tk < Formula
  include Language::Python::Virtualenv

  desc "Security toolkit for Amazon S3"
  homepage "https://github.com/ankane/s3tk"
  url "https://github.com/ankane/s3tk/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "630fca8be4c7b25f5a049eb231ed071c5eb6ac0cfe29804f6abbcb76b515bbc6"
  license "MIT"

  depends_on "python@3.11"
  depends_on "six"

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/07/0e/0fdf99382eadd8481f09fc86c97b97c562a795b6494e75b84000320ee730/boto3-1.22.2.tar.gz"
    sha256 "fb9a66722a15b0a8edb4f29d63f013877c4c528eff1225bb31dab723c3e5a9ed"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/50/5c/d5f027cc397e4df0c618026f6a04330cdb163ee4d0664544f6975dfbdde3/botocore-1.25.2.tar.gz"
    sha256 "78363cd023c6123a65d90080e14a9fb625a9639d970ab03471c6fe95258ab8c0"
  end

  resource "clint" do
    url "https://files.pythonhosted.org/packages/3d/b4/41ecb1516f1ba728f39ee7062b9dac1352d39823f513bb6f9e8aeb86e26d/clint-0.5.1.tar.gz"
    sha256 "05224c32b1075563d0b16d0015faaf9da43aa214e4a2140e51f08789e7a4c5aa"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/42/e1/4cb2d3a2416bcd871ac93f12b5616f7755a6800bccae05e5a99d3673eb69/click-8.1.2.tar.gz"
    sha256 "479707fe14d9ec9a0757618b7a100a0ae4c4e236fac5b7f80ca68028141a1a72"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/06/7e/44686b986ef9ca6069db224651baaa8300b93af2a085a5b135997bf659b3/jmespath-1.0.0.tar.gz"
    sha256 "a490e280edd1f57d6de88636992d05b71e97d69a26a19f058ecf7d304474bf5e"
  end

  resource "joblib" do
    url "https://files.pythonhosted.org/packages/92/b9/9e3616e7e00c8165fb25175c53444533bdde05f3e974d45d9fcbbe451ee6/joblib-1.1.0.tar.gz"
    sha256 "4158fcecd13733f8be669be0683b96ebdbbd38d23559f54dca7205aea1bf1e35"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/7e/19/f82e4af435a19b28bdbfba63f338ea20a264f4df4beaf8f2ab9bfa34072b/s3transfer-0.5.2.tar.gz"
    sha256 "95c58c194ce657a5f4fb0b9e60a84968c808888aed628cd98ab8771fe1db98ed"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/1b/a5/4eab74853625505725cefdf168f48661b2cd04e7843ab836f3f63abf81da/urllib3-1.26.9.tar.gz"
    sha256 "aabaf16477806a5e1dd19aa41f8c2b7950dd3c746362d7e3223dbe6de6ac448e"
  end

  def install
    virtualenv_install_with_resources
  end

  def test
    system bin/"s3tk"
  end
end
