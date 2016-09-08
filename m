From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: meson: handle unknown ID values
Date: Thu, 8 Sep 2016 11:23:54 +0200
Message-ID: <20160908092354.GB24112@ulmo.ba.sec>
References: <20160906125106.1511562-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33493 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932646AbcIHJX6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Sep 2016 05:23:58 -0400
Content-Disposition: inline
In-Reply-To: <20160906125106.1511562-1-arnd@arndb.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2016 at 02:50:47PM +0200, Arnd Bergmann wrote:
> When building with -Wmaybe-uninitialized, we get a couple of harmless
> warnings about three functions in this new driver that don't look
> safe to the compiler:
>=20
> drivers/pwm/pwm-meson.c: In function 'meson_pwm_get_state':
> drivers/pwm/pwm-meson.c:355:26: error: 'mask' may be used uninitialized i=
n this function [-Werror=3Dmaybe-uninitialized]
> drivers/pwm/pwm-meson.c: In function 'meson_pwm_disable':
> drivers/pwm/pwm-meson.c:263:13: error: 'enable' may be used uninitialized=
 in this function [-Werror=3Dmaybe-uninitialized]
> drivers/pwm/pwm-meson.c: In function 'meson_pwm_apply':
> drivers/pwm/pwm-meson.c:231:13: error: 'clk_shift' may be used uninitiali=
zed in this function [-Werror=3Dmaybe-uninitialized]
> drivers/pwm/pwm-meson.c:231:36: error: 'enable' may be used uninitialized=
 in this function [-Werror=3Dmaybe-uninitialized]
> drivers/pwm/pwm-meson.c:231:24: error: 'clk_enable' may be used uninitial=
ized in this function [-Werror=3Dmaybe-uninitialized]
>=20
> Specifically, if we have a device with an id other than 0 or 1,
> this would result in undefined behavior. This is currently not
> possible, but the compiler cannot be expected to know this.
>=20
> This patch adds a 'default' clause to let the compiler know
> what to do instead, which shuts up the warning and makes the
> code slightly more resiliant in case it gets extended to other
> identifiers.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-meson.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, though I left out the dummy assignment of state->enabled =3D 0
because that's dead code anyway.

Thanks,
Thierry

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX0S4oAAoJEN0jrNd/PrOh+98QALUsqGxiMrovYblZeqjZk4zC
7UoFqBNRksNcPX+qqsxBLeRtRUoXSkbVePtbnMUc/jo7AGavE9QP8gr917PR6QrY
de/5nRqm46pFiCQDLIa3pSapz+updY2YkBMFAXZfDWo9lZfbpHgSyJo1C/3RwkQo
Bodo2PR/x2y22E1nq6m1ppQas9LVIXbcRkYLvHvKcjhqaF6tXn+H9laKtmpWzuTp
E11S8ZJ8z1vU1It9LKwyugLQfXBWqQt/aIG62B9Rpe9Tn3eRUdb4kjnJngx99lKq
fizRNv1yNzg8w5O+xhScFDD+QOMxyawWc/rCCDO5WoSSNSEF8E469WymAUxMGOK7
JHulQyYcagN+j+wxI3CkfUGJFPGs03vS0gbiotTQ18OB02DCgvJtJqcJe7iToBWu
P0ned8fzlUQ6IzJZIB/Niy7taGaKL6tL7M1ypaDZFDbpv5hF78ooFs6E90SU2H9W
1GTyDDP5tf7mUGw8xNn/RHqFE6cMkms8ifyX/l+/dMr4+BBItrXNdgYHn2+2LsaO
0dAIBqTVFnTzGeuT6E2zYcqbhkSZKh0Qis5dMvfG30SlPaehAhOUiLTRVR7RdEOS
FCmoBRwXlh1KYlhjsHblMKIlCFEb96qvDsWKWtN6mZdDF4/20c7PCNnyhbSZTDyo
bUiRq7Im7x1RlZNNTDtB
=pbZP
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
