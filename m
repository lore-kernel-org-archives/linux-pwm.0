Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
Date: Tue, 29 Oct 2013 18:29:59 +0100
Message-ID: <1422562.0L87CDt5Gd@avalon>
In-Reply-To: <20131029172331.GA20251@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1577821.Q7gttkPE2J@avalon> <20131029172331.GA20251@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4942102.gaO6gKkPZo"; micalg="pgp-sha1"; protocol="application/pgp-signature"
List-ID: <linux-pwm.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>


--nextPart4942102.gaO6gKkPZo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mark,

On Tuesday 29 October 2013 10:23:31 Mark Brown wrote:
> On Tue, Oct 29, 2013 at 06:05:53PM +0100, Laurent Pinchart wrote:
> > The first one is that I can't compile-test all those drivers on all
> > architectures. The spi-sh-msiof driver, for instance, uses
> > io(read|write)(16|
>
> Which architectures are these and is there not a symbol we can depend on
> for them?

arch/cris for instance. We can use readl/writel instead (maybe it would be 
time to rationalize and document the I/O accessors across all architectures, 
but that's another topic).

My point is that there might be other issues that I won't be able to easily 
catch. This would break compilation for everybody for no reason, as the 
drivers are useless on non-SuperH, non-ARM platforms. That's why I believe 
COMPILE_TEST would be a better option as a first step.

> > 32) which are not available on all architectures. There might be other
> > similar problems that I can't catch, and I don't want to introduce build
> > breakages in the kernel.
> 
> This is easy enough to handle if we do run into issues, it seems better to
> get things available than try to step through architecture by architecture.
> 
> > The second reason is that, as the IP cores have never been used on
> > anything but SuperH and ARM, I don't like the idea of clobbering the
> > config process with drivers that are useless on the target architecture.
> > Now that we have a COMPILE_TEST Kconfig option, my preference would thus
> > go to SUPERH || ARM || COMPILE_TEST over no dependency at all.
> 
> That's not what you did, though - you're not adding COMPILE_TEST.

No, but I can add it :-) If this gets agreed upon, I'll respin the series with 
|| COMPILE_TEST.

-- 
Regards,

Laurent Pinchart

--nextPart4942102.gaO6gKkPZo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSb/CXAAoJEIkPb2GL7hl1dSgH/3RYsAUPWMftP+1QweJRm6hs
bIhJ6rTB4F54mGzaaAb1Annf8nvl8dlDFCbOg2xMyPxaA3GUzvQWveHt82uZ8fnM
fM2uJfvhVSublzE7ApEvMxBEcVyCtdne+0tg6aiqGQkxtAK2gmDt/92qnRbGP+c4
m3EDrAzSnbhwSA1468pjmuLAxyPIjLFHS0aE/0Z8Z72wrlj2LWkRE3QbMKJNsmic
f04dPUTnDIYpUQVSz9F9t73ytHDUEwee5kVY9OOhZ8RAZjKdNsMToKsI4pTvYsMU
NcihFBJXmFjYqo0Nod9uqsmpF/fGDdq50FWWCZWZfltuGDcLCTbFA9dvd25xCYU=
=NDtx
-----END PGP SIGNATURE-----

--nextPart4942102.gaO6gKkPZo--
