From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
Date: Mon, 5 Oct 2015 17:27:06 +0200
Message-ID: <20151005152706.GC17612@ulmo>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32929 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbJEP1J (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 11:27:09 -0400
Content-Disposition: inline
In-Reply-To: <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pwm@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2015 at 11:23:46AM +0200, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>=20
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
>=20
> Get and use the slow clock as it is necessary for the timer counters.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org
>  drivers/clocksource/tcb_clksrc.c | 10 +++++++++-
>  drivers/misc/atmel_tclib.c       |  4 ++++
>  drivers/pwm/pwm-atmel-tcb.c      | 26 +++++++++++++++++++-------
>  include/linux/atmel_tc.h         |  1 +
>  4 files changed, 33 insertions(+), 8 deletions(-)

This doesn't seem to apply anymore. Does it need to be rebased? Or do I
need some other patch as a dependency?

Thierry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEpbJAAoJEN0jrNd/PrOh/bwP/3MWwIjeg6ZbujtJhV1MFys/
41u6c63Ymj9fawkvKp34Q/ebaTWYWM8hjpyfg1KnGrbGZeeqeTzBtDWdpIwrbDnp
aPi/3nwrgiWgdT/Q9K2NHYy15dQ+cxc7vXRc3PjOte2WkyL4+o6K/7e/g6YP/iPH
d3LEM2uUoflRjXhuWKtBFDYitMssoKXz0zs90Dz5dz5dtOrQKffLSxqEOCOuATaM
LAl/ceGr2smc6BOsS6h1gN2u6S7pi0SubPpoV5J1eUruI67ikslJ6gOLYxIOuV2G
uOJXVLLVROuxAsnZfr3d4VvILfz0Mnw5DkRF8B0piwBU52iYs8TqNcfbEjFfN7Bt
mXwRx9U3Uq8/tc8J7haDKJ5RGJLEOvuCGG3LZODQgeuW/3Igo7/vyr4nkwqu9kmj
pMXxPykjkTj3fqeV2pdXpyoiXH4KtFhuHcWN2+8WryYcakNcx1ipLPDi14GYV4vq
JSCgB5WLMZifsMhBOJQDowNb2B6Az4AquS3M6Z2t84DmKNtrydOlQ4WBvrKG/HcN
D5LimD8CzfxBzvBHj0qnp+Tr0yj7lV68ZsyF8Gd7ykYi6HltYxgHcLHJUr/wFPwK
D+rxYgiVvWg+7wC7Q/ydSMViBSf82wRui99Ntrqrv9zacvwfdZgfSoa2zJza9E4j
9lCg5aW1ypd2HMA255/6
=BNS4
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
