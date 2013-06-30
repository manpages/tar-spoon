pkgname=tarspoon-git
_pkgname=tarspoon
epoch=1
pkgver=git
pkgrel=1
pkgdesc='Activity logger to recover stolen or lost laptop'
url='https://github.com/manpages/tar-spoon'
arch=('i686' 'x86_64')
license=('MIT')
depends=('logkeys' 'openssl' 'openssh' 'gnupg')
makedepends=('ncurses' 'git')
source=('https://github.com/manpages/tar-spoon/archive/master.tar.gz')
sha1sums=('SKIP')
backup=('etc/ts.conf')

provides=("${_pkgname}")
conflicts=("${_pkgname}")

prepare() {
  mv "${srcdir}/${_pkgname}-master" "${srcdir}/${_pkgname}"
}

build() {
	cd "${srcdir}/${_pkgname}"
	make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11
}

package() {
	cd "${srcdir}/${_pkgname}"
  cp ts.conf /etc/
  echo <<EOH
    1. Edit /etc/ts.conf
    2. Run tarspoon-setup
    3. Enable tarspoon.service
    4. ???
    5. PROFIT
  EOH
}
