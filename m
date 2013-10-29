Return-Path: <broonie@sirena.org.uk>
Date: Tue, 29 Oct 2013 10:23:31 -0700
From: Mark Brown <broonie@kernel.org>
Message-ID: <20131029172331.GA20251@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029060427.GF11580@verge.net.au>
 <20131029160449.GD16686@sirena.org.uk>
 <1577821.Q7gttkPE2J@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <1577821.Q7gttkPE2J@avalon>
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 06:05:53PM +0100, Laurent Pinchart wrote:

> The first one is that I can't compile-test all those drivers on all=20
> architectures. The spi-sh-msiof driver, for instance, uses io(read|write)=
(16|

Which architectures are these and is there not a symbol we can depend on
for them?

> 32) which are not available on all architectures. There might be other si=
milar=20
> problems that I can't catch, and I don't want to introduce build breakage=
s in=20
> the kernel.

This is easy enough to handle if we do run into issues, it seems better
to get things available than try to step through architecture by
architecture.

> The second reason is that, as the IP cores have never been used on anythi=
ng=20
> but SuperH and ARM, I don't like the idea of clobbering the config proces=
s=20
> with drivers that are useless on the target architecture. Now that we hav=
e a=20
> COMPILE_TEST Kconfig option, my preference would thus go to SUPERH || ARM=
 ||=20
> COMPILE_TEST over no dependency at all.

That's not what you did, though - you're not adding COMPILE_TEST.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb+8QAAoJELSic+t+oim9cO4P/0CNsXH4RTd+b7gkEaGIE5FB
749OqmwnlVvQPjycW5R0GiBevc7Iw9QehjcuZlE4aviXL6IWaPDr3tAOsTEuf+RZ
mVZ8NLpDCdPHzLG9/2LPPZ3JcsOAbayMDkjlLZL3Ozf0eimalO7f5Lkuj5qPHcop
FP8gmnlApKD9xCWamFEm+XJy7NGEMdzhuUUdJcDiAQ64sMfc40YBpdkbBH8GR/jp
OG07H8nOdyGWfL516EBO4yK5bHrP7oIJIBFL8KXrf5aQVx4gRoqouX7OjVvBl7uY
qZlCpOZY8aow93HdJlC/skjiKCAR33kXFmVShNF6FgDpzCkWHwQ38oU2kH0KqL+L
YbpZeZbZ6ZW2s6je9cwlq+KZG2ngYdVYPozN+a+jyLlLMDGXKjOaHU4Ctrf25jr8
0WU70ZaDfARfn4kJ3pRs0CTmRmAZXezVlPQZkKp57IqAlogCgzDNkIvL17DbCy1C
HkloKaMlvlUgOBJolYNvpas7V/cRz2BB132UXoIvSI94EkXCkQJ3vVvrLmXncbG3
TNCyyLGe5uzBeC2z5CnIoGRTmX8rMjDVsmK81f0YCCoaLMWXUc/CG6V1pRurcmdN
bNC9b0miP+ZLoxe6enERCPcqK8YM1m/d2pMv9EzDRw6kG6Htu8T1DjxQOpHWeOTG
aWRAEtmK2IU5cZjenCxT
=r5xl
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
