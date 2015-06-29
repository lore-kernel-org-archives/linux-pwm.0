From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
Date: Mon, 29 Jun 2015 11:21:47 +0200
Message-ID: <20150629092145.GF5431@ulmo>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
 <20150612102046.GF19400@ulmo.nvidia.com>
 <1434622784.18278.39.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34987 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbbF2JW7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2015 05:22:59 -0400
Content-Disposition: inline
In-Reply-To: <1434622784.18278.39.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 06:19:44PM +0800, YH Huang wrote:
> On Fri, 2015-06-12 at 12:20 +0200, Thierry Reding wrote:
> > On Thu, May 21, 2015 at 09:29:24PM +0800, YH Huang wrote:
[...]
> > > +#define DISP_PWM_CON_1		0x14
> > > +#define PWM_PERIOD_MASK		0xfff
> > > +#define PWM_PERIOD_MAX		0x00000fff
> >=20
> > Same here. PWM_PERIOD_MAX isn't actually used anywhere, so perhaps just
> > drop it altogether. But see also below...
> >=20
> > > +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> > > +#define PWM_PERIOD_BIT_SHIFT	12
> >=20
> > I wasn't very clear about this in my earlier review, so let me try to
> > explain why I think this is confusing. You use this as a divisor, but
> > you encode it as a shift. It's also PWM_PERIOD_MAX + 1, so I think it
> > would make more sense to drop this, keep PWM_PERIOD_MAX as above and
> > then replace the
> >=20
> > 	>> PWM_PERIOD_BIT_SHIFT
> > =09
> > below by
> >=20
> > 	/ (PWM_PERIOD_MAX + 1)
> >=20
>=20
> Maybe I can change in this way:
> Remove this: #define PWM_PERIOD_MAX		0x00000fff
> Using ">> PWM_PERIOD_BIT_SHIFT" is faster than "/ (PWM_PERIOD_MAX + 1)"
> Is this right?

The compiler should be able to optimize the division to a shift, so both
will likely result in the same code. But I don't mind much either way as
long as we don't define two symbols for essentially the same value.

Thierry

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVkQ4pAAoJEN0jrNd/PrOhjSwP/RS1ryK0VhT9VEZShzxu0nS7
tOMIoRRVrNW82+eXR8ibapKtrpAzBJzaEiJBnBdV3Ht5KEA5EQ5Oc9SNbvgaRYcF
+3Zn2mB2HHGDMAf3QwVubPk2Yit5lcC4Z4IXXDBQgr5JOJLY5XuF5jdGpCakg/qD
rjf2+c76PC27VTE9MaSp0gewHjVIlB71tuTeU3aNbo5DLYJffvzCRzrOA/jTvwiA
jFwOrF1JvJ7WPjHI4sJUOteGuJBk+ZxOUx4zx+MrT4kQie95okbLidkSxYOhH/jb
9DhzbWf3nlJS2eJZCb5eEGh6OS9n1ZPdPEh/msm6PYqCgoozhrLsM0Y6JVpWJLqF
xv0L/HLhyW2BG2SHkqzkDGJTcGRjfWk2dZxTp/RirfVPG08Cgx8oeZdmX0yUr0hE
TTITHzHOZtg+c2rDlodCQ99yv7PXeIRaU4GORzUm0EgFd9VwuXOG3zmFX6VzxduF
J6Kua+jROEvNkZ2x7ULhyIcuAnUGKwi6L8b1dzZEXKA6XSBpHv9zWV6/dGPsX8jz
o0+3C3p5EEKOzH+ssh487+pFICDDZe8EuqJinTcWgnUyM6+SQ0pfj/yQnNACC6Fc
AR7bMyiF+EbWI6lpDEgiOCjG63jk3Jt1TTk07YASpTBPwlYlpAdpQWjn6ji+YWKb
HXYmoN2GQvgONLO1fAso
=PyV4
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
