pkgname=tar-spoon-git
_pkgname=tar-spoon
epoch=1
pkgver=git
pkgrel=1
pkgdesc='Activity logger to recover stolen or lost laptop'
url='https://github.com/manpages/tar-spoon'
arch=('i686' 'x86_64')
license=('MIT')
depends=('logkeys-git' 'openssl' 'openssh' 'gnupg')
makedepends=('ncurses' 'git' 'sudo')
source=('https://github.com/manpages/tar-spoon/archive/master.tar.gz')
sha1sums=('SKIP')
backup=('etc/ts.conf')

provides=("${_pkgname}")
conflicts=("${_pkgname}")

prepare() {
  tar -xzvf master.tar.gz
  mv "${srcdir}/${_pkgname}-master" "${srcdir}/${_pkgname}"
}

build() {
	cd "${srcdir}/${_pkgname}"
}

package() {
	cd "${srcdir}/${_pkgname}"
  sudo cp ts.conf /etc/
  echo "
    1. Edit /etc/ts.conf
    2. Run tarspoon-setup
    3. Enable tarspoon.service
    4. ???
    5. PROFIT"
}
