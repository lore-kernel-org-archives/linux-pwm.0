Return-Path: <broonie@sirena.org.uk>
Date: Tue, 29 Oct 2013 10:58:34 -0700
From: Mark Brown <broonie@kernel.org>
Message-ID: <20131029175834.GD20251@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1577821.Q7gttkPE2J@avalon>
 <20131029172331.GA20251@sirena.org.uk>
 <1422562.0L87CDt5Gd@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <1422562.0L87CDt5Gd@avalon>
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 06:29:59PM +0100, Laurent Pinchart wrote:
> On Tuesday 29 October 2013 10:23:31 Mark Brown wrote:
> > On Tue, Oct 29, 2013 at 06:05:53PM +0100, Laurent Pinchart wrote:
> > > The first one is that I can't compile-test all those drivers on all
> > > architectures. The spi-sh-msiof driver, for instance, uses
> > > io(read|write)(16|

> > Which architectures are these and is there not a symbol we can depend on
> > for them?

> arch/cris for instance. We can use readl/writel instead (maybe it would b=
e=20
> time to rationalize and document the I/O accessors across all architectur=
es,=20
> but that's another topic).

It'd certainly be sensible, or adding a config option to depend on if
you rely on these functions.

> My point is that there might be other issues that I won't be able to easi=
ly=20
> catch. This would break compilation for everybody for no reason, as the=
=20
> drivers are useless on non-SuperH, non-ARM platforms. That's why I believ=
e=20
> COMPILE_TEST would be a better option as a first step.

Yes, it would - please do that.  Note that it won't stop anyone running
into build issues on other architectures though, it's just about
stopping Kconfig noise.

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb/dHAAoJELSic+t+oim9ddQP/i1RCiwSI2llH07cDu0C60zD
gD/NLQYokpqOLuYQkIqY/ODY7avbL/f0ZuAbQ6BhfmQWWaX9sDLM1YmJTbbYEcFr
rhCqyLRj7dWwM+R4j5HkiZ5rSNxKJS6D5kPHdkwS7BJyxlyzaIHlbxb49V4WKfwB
UH3YFNpz4QbkFg2vE8/trXMW2roqYxKTEal5OktM0EeMHPhjFYZQmXyOin5Fd3Re
yp4gCnSDZ+rHEZjPevraos5ZTf4IGB57EaFYk8whSuG/U1hzepXShgCPF76eJjmZ
VoyrL+ZXPn67V8Tiym/GHOROG9bSzUvoKTvXB7SF0t0WY2ypgFGrNOQFfDOBYqkL
9s3o+k3hPdmDenFZXUL4qpW/CX9Q0XsapsCKfK1wPXHRLgKWa/oUlLOfQZFIXNFU
yNXqvnrOlq6T8B5wqohi9ZvwqlDVWtsSc43mE8pfIkgd/Dr24QlhOHsmlee7nq+y
KeZKoZ4tIEsYuYSYZV8UG1SvBw2WSTH0tEvkHOr6kJpdUwNrQ7llEvw531KMqvsF
eJ+AfYZcPM7tNPRTDwvqNeJW1qgsVdCan7U2UcIUWjx26Bz49eb6VykEcQx9LnRJ
J+egZaXBWhep+9xCuk+fskdIKlawPmxy2ImBh9M8Fn7o/UnDdAmMuI3xE8k/njRp
5YMTmmm5fewQmrrmmAws
=dlcY
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
