# Maintainer: Michael John <amstelchen at gmail dot com>

pkgname=noewarn
_pkgname=noewarn
pkgver=0.1.0
pkgrel=1
pkgdesc="A program to show fire brigade deployments in Lower Austria."
arch=('any')
url="http://github.com/amstelchen/NOEwarn"
license=('GPL')
packager=('Michael John')
depends=('bash' 'gettext')
optdepends=('')
makedepends=()
source=("${pkgname}_${pkgver}.tar.gz"::"https://github.com/amstelchen/NOEwarn/archive/refs/tags/${pkgver}.tar.gz")
sha256sums=('833432a0284fe874e082d4cb2f0639d106b8c527b1a408c2caec2f22b3cb9558')

build() {
    
}

package() {
  install -Dm755 "${srcdir}/${_pkgname}-${pkgver}"/noewarn.sh \
      "${pkgdir}"/usr/bin/noewarn
  install -Dm755 "${srcdir}/${_pkgname}-${pkgver}"/po/de.mo \
      "${pkgdir}"/usr/share/locale/de/LC_MESSAGES/
  install -Dm755 "${srcdir}/${_pkgname}-${pkgver}"/po/uk.mo \
      "${pkgdir}"/usr/share/locale/uk/LC_MESSAGES/
}
