# Maintainer: Michael John <amstelchen at gmail dot com>

pkgname=noewarn
_pkgname=NOEwarn
pkgver=0.1.2b
pkgrel=1
pkgdesc="A program to show fire brigade deployments in Lower Austria."
arch=('any')
url="http://github.com/amstelchen/NOEwarn"
license=('GPL')
packager=('Michael John')
depends=('bash' 'gettext' 'libxml2')
optdepends=('')
makedepends=()
source=("${pkgname}_${pkgver}.tar.gz"::"https://github.com/amstelchen/NOEwarn/archive/refs/tags/${pkgver}.tar.gz")
sha256sums=('533ee86b182b5098ac7b8a4f93d077085e88cbe353cf04ac38ce9ed6e7a4256c')

package() {
  install -Dm755 "${srcdir}/${_pkgname}-${pkgver}"/noewarn.sh \
      "${pkgdir}"/usr/bin/noewarn
  #install -d "$pkgdir/usr/share/locale/de/LC_MESSAGES/"
  install -Dm644 "${srcdir}/${_pkgname}-${pkgver}"/po/de.mo \
      "${pkgdir}"/usr/share/locale/de/LC_MESSAGES/"${pkgname}.mo"
  #install -d "$pkgdir/usr/share/locale/uk/LC_MESSAGES/"
  install -Dm644 "${srcdir}/${_pkgname}-${pkgver}"/po/uk.mo \
      "${pkgdir}"/usr/share/locale/uk/LC_MESSAGES/"${pkgname}.mo"
  #install -d "$pkgdir/usr/share/locale/uk/LC_MESSAGES/"
  install -Dm644 "${srcdir}/${_pkgname}-${pkgver}"/po/fr.mo \
      "${pkgdir}"/usr/share/locale/fr/LC_MESSAGES/"${pkgname}.mo"
}
