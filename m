Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
Date: Tue, 29 Oct 2013 18:05:53 +0100
Message-ID: <1577821.Q7gttkPE2J@avalon>
In-Reply-To: <20131029160449.GD16686@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131029060427.GF11580@verge.net.au> <20131029160449.GD16686@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3771148.DUBN0oL5aB"; micalg="pgp-sha1"; protocol="application/pgp-signature"
List-ID: <linux-pwm.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>


--nextPart3771148.DUBN0oL5aB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mark,

On Tuesday 29 October 2013 09:04:49 Mark Brown wrote:
> On Tue, Oct 29, 2013 at 03:04:27PM +0900, Simon Horman wrote:
> > I think this is a step in a good direction.
> > However, I think it would be even better if the architecture dependency
> > was removed completely.
> 
> Yes, please.

I've kept it for two reasons.

The first one is that I can't compile-test all those drivers on all 
architectures. The spi-sh-msiof driver, for instance, uses io(read|write)(16|
32) which are not available on all architectures. There might be other similar 
problems that I can't catch, and I don't want to introduce build breakages in 
the kernel.

The second reason is that, as the IP cores have never been used on anything 
but SuperH and ARM, I don't like the idea of clobbering the config process 
with drivers that are useless on the target architecture. Now that we have a 
COMPILE_TEST Kconfig option, my preference would thus go to SUPERH || ARM || 
COMPILE_TEST over no dependency at all.

-- 
Regards,

Laurent Pinchart

--nextPart3771148.DUBN0oL5aB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSb+r2AAoJEIkPb2GL7hl19w8H+gJj3zKx1Th48UvyGZV3QsU0
AEq9ko2/u+rnJtA2vWyrc6Kfjp07Sa6vVOrY/5s9Mzg69jHQ96KzMTmwbv4/ExoW
6Io3iKE6MdHBnnZ0xPRtNlaE6StlOt4Lv9+rQheJsomFgaRCmvKEaJLOB32bRkgb
AfqFT8gu1OaKF72FhxwJ0Atl2kIJIMLZuaI0bMjRCaK2oDvV2NhufAUGRjuuMFFw
/zQ0wxDIZTUQcu6OXEfa8CA5b5EvcW8v46a+BF+C7nVC4TF4wqgxlhJxxgXcd3mO
pK7clYQn+8d2zpaS7CAMbXXip6r+AO83S8NjR/tDA5er/dyNJ+cskIb5kxNes34=
=9Krm
-----END PGP SIGNATURE-----

--nextPart3771148.DUBN0oL5aB--
