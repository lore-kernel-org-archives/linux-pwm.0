From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller support
Date: Tue, 23 Sep 2014 10:42:29 +0200
Message-ID: <20140923084228.GN30514@ulmo>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
 <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140922211811.11279ff0@bbrezillon>
 <20140923063232.GG30514@ulmo>
 <20140923092436.12b1f2c4@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XBg9NAhDNArbJUtw"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:52384 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaIWImc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Sep 2014 04:42:32 -0400
Content-Disposition: inline
In-Reply-To: <20140923092436.12b1f2c4@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--XBg9NAhDNArbJUtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2014 at 09:24:36AM +0200, Boris BREZILLON wrote:
> Hi Thierry,
>=20
> On Tue, 23 Sep 2014 08:32:33 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Mon, Sep 22, 2014 at 09:18:11PM +0200, Boris BREZILLON wrote:
> > > On Mon,  8 Sep 2014 10:43:36 +0200 Boris BREZILLON <boris.brezillon@f=
ree-electrons.com> wrote:
> > [...]
> > > > diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/=
atmel-hlcdc/Kconfig
> > > > new file mode 100644
> > > > index 0000000..6d0d785
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> > > > @@ -0,0 +1,13 @@
> > > > +config DRM_ATMEL_HLCDC
> > > > +	tristate "DRM Support for ATMEL HLCDC Display Controller"
> > > > +	depends on DRM && OF && MFD_ATMEL_HLCDC && COMMON_CLK
> > >=20
> > > I forgot to remove MFD_ATMEL_HLCDC dependency which is now selected...
> > >=20
> > >=20
> > > > +	select DRM_GEM_CMA_HELPER
> > > > +	select DRM_KMS_HELPER
> > > > +	select DRM_KMS_FB_HELPER
> > > > +	select DRM_KMS_CMA_HELPER
> > > > +	select DRM_PANEL
> > > > +	select MFD_ATMEL_HLCDC
> > >=20
> > > here.
> >=20
> > Maybe this was discussed earlier, but can you remind me why this was
> > done? The changelog says it was to "simplify", but there's been some
> > recent discussion that select should never be used for symbols that
> > are user-visible because that can lead to issues.
> >=20
> > What were the problems having this as "depends on"?
>=20
> I had several people complaining about the complexity introduced by
> this dependency scheme: if one wants to select the HLCDC KMS driver, he
> has to select the HLCDC MFD driver first, which is kind of tricky.

That's not at all tricky in my opinion. The MFD provides an LCDC as one
of the devices, so requiring it to be selected before you can enable any
of the subdrivers is very natural. It's also how the majority of MFD
devices work.

> The MFD_ATMEL_HLCDC symbol is now hidden (see patch 1) which should
> solve part of the issue.

I think that's wrong but I don't care enough to object.

> Now that I have your attention :-), could you review this series [1] ?
> The HLCDC KMS depends on those changes (which you and Laurent
> suggested).

My attention span tends to be very short these days. No promises. =3D)

Thierry

--XBg9NAhDNArbJUtw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUITJ0AAoJEN0jrNd/PrOhwxYP/jWDuFyAyTj20WNHLXkR9cVH
vMWYlikyNplwOkI26hf2sRzZsrx5cUO1tFhBrDwo2CigMTWCmvyO63xSuGbrvuib
X5H8syCp/QuHTwVXehTSCnAQlknc+VzH9zq6I3wbhot+Tc58nHh8UPJRD8E3Dpir
SyVUXO/FPvpKujATuaxxcuUmP8yJDLjj/jwrm7dP+roVuw+mVVUoXiBAFmAbiI9T
OJGLn22Us9p9wFhCuocjJagOoV/8Bvv6Qzg45Oo5KCCaSZxQuL0VVDsveic/4pQ9
HWoz2hf9+RmKyuJooMkfaphGfc5IwTtXPlytvP8b7ayqrE59n2AryhFjgXYSDM3Q
NWTAfg1kSEy9wEEX+9n/0JY91XtEStRyc6cnxQpwXkqBJYCxE5hOpEhtwKn9+Rp7
b7ctVvuFPbcSXfGjO/pS/k7R0ucMxU9bgFksvLeLoNbxlhRk6TA/EHXhzjkExtSj
rhnEgiZGPkmQTPSu+MzNiQKVLW7o6jOhqzxHXKpXo/z0iJbS+PODIjLvB2Lrlk7C
xTWSoZBTHW0DpPxzg7ZCEy98S/zagowtLrLrT1oQdghTeWOa97FBcPJLrYeKbhsY
L7AObYlTfqIFY8hSmXmF9hJUBnDm6LXLiBnKfyvkdxqQmPZF8De+qQU8wlp9K7Tu
aAtI9d4EXZmlg3pbV/eP
=VU3Y
-----END PGP SIGNATURE-----

--XBg9NAhDNArbJUtw--
