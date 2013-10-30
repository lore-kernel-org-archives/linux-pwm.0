Return-Path: <tomi.valkeinen@ti.com>
Message-ID: <5270E67C.1030307@ti.com>
Date: Wed, 30 Oct 2013 12:59:08 +0200
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1577821.Q7gttkPE2J@avalon> <20131029172331.GA20251@sirena.org.uk> <1422562.0L87CDt5Gd@avalon> <20131029175834.GD20251@sirena.org.uk> <20131030000501.GE21262@verge.net.au>
In-Reply-To: <20131030000501.GE21262@verge.net.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TkUw5P34TmOLV1SJPPLSgLmi19DGfXjmp"
List-ID: <linux-pwm.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>

--TkUw5P34TmOLV1SJPPLSgLmi19DGfXjmp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-10-30 02:05, Simon Horman wrote:
> On Tue, Oct 29, 2013 at 10:58:34AM -0700, Mark Brown wrote:
>> On Tue, Oct 29, 2013 at 06:29:59PM +0100, Laurent Pinchart wrote:
>>> On Tuesday 29 October 2013 10:23:31 Mark Brown wrote:
>>>> On Tue, Oct 29, 2013 at 06:05:53PM +0100, Laurent Pinchart wrote:
>>>>> The first one is that I can't compile-test all those drivers on all=

>>>>> architectures. The spi-sh-msiof driver, for instance, uses
>>>>> io(read|write)(16|
>>
>>>> Which architectures are these and is there not a symbol we can depen=
d on
>>>> for them?
>>
>>> arch/cris for instance. We can use readl/writel instead (maybe it wou=
ld be=20
>>> time to rationalize and document the I/O accessors across all archite=
ctures,=20
>>> but that's another topic).
>>
>> It'd certainly be sensible, or adding a config option to depend on if
>> you rely on these functions.
>>
>>> My point is that there might be other issues that I won't be able to =
easily=20
>>> catch. This would break compilation for everybody for no reason, as t=
he=20
>>> drivers are useless on non-SuperH, non-ARM platforms. That's why I be=
lieve=20
>>> COMPILE_TEST would be a better option as a first step.
>>
>> Yes, it would - please do that.  Note that it won't stop anyone runnin=
g
>> into build issues on other architectures though, it's just about
>> stopping Kconfig noise.
>=20
> FWIW, I am happy with using COMPILE_TEST for this series.

I'd also go for COMPILE_TEST. I once enabled omapdss and omapfb to be
compilable without any extra dependencies, and Linus wasn't fond of
getting asked if he wants to compile omapfb or not...

 Tomi



--TkUw5P34TmOLV1SJPPLSgLmi19DGfXjmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJScOZ8AAoJEPo9qoy8lh71P30P/jICwvvfCuFcXG7wV9Xlx+Yn
MQDykQ+nRBIKOprbo38dSIC/rHYc0w80r2cb9I3xnGprkYNa9gG4Ln0RgH+nD6Hp
AMmvAluNpOh5Xw9HWru7o7WnSVbMYeFM1D88/MCpJ0+HbunlpMOLbt+TZh7OHBlG
BigvgPZMeDdNtVe2/loS9pSZmmRVdXqUJEa3eIWjV4DJRQFJeLcvdAXICCSFabjJ
z7COW355T8sfHuF68cze7aUjQc+sRXF8DZlU0D/FuUqe2HuCqs2qZif/UD8OEGv6
MGgX56QseEfhUe/czV2OJCF5lkdDmK/d2kdQEwa8TH9Ha78q56i/wY4/9xrKZIBC
8I9LuGEJMyHfnKlDCiksVu4INjSuJxuEQ9XXBO7DwUFh3nIwXvCxIFKSKVcw0WFr
/wiLjEOr+ks3MopLx1Q3rObI5NuK8XA01nzbmPoLVftNQYHCujdpM4GbjO5TseyA
5PLPEaYINVZy38f4wA96haT9xzytbl2+0slcIx0HT7mGLeSXrK6SCDCQcXjFWb2G
u8g1LOskc75YG5SNef2pfgWlNYEwcNC+SzH8XFUpS/Ik/nIsuPH4jSNfUlw806i/
lOLwrnsy1CPLqe8W3O9pzxWoFVrqSpIWmfnDo5Kuhfi/khtNcGKEFnMWmI0ZCjQU
Ua3jflxpaMjf4QJygi9Y
=mBU0
-----END PGP SIGNATURE-----

--TkUw5P34TmOLV1SJPPLSgLmi19DGfXjmp--
