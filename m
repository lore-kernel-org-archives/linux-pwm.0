From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 08/20] pwm: Add PWM Capture support
Date: Fri, 10 Jun 2016 18:39:56 +0200
Message-ID: <20160610163956.GA8696@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-9-lee.jones@linaro.org>
 <20160610135302.GK27142@ulmo.ba.sec>
 <20160610143854.GE1537@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160610143854.GE1537@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 03:38:54PM +0100, Lee Jones wrote:
> On Fri, 10 Jun 2016, Thierry Reding wrote:
>=20
> > On Wed, Jun 08, 2016 at 10:21:23AM +0100, Lee Jones wrote:
> > > Supply a PWM Capture call-back Op in order to pass back
> > > information obtained by running analysis on PWM a signal.
> > > This would normally (at least during testing) be called from
> > > the Sysfs routines with a view to printing out PWM Capture
> > > data which has been encoded into a string.
> > >=20
> > > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > ---
> > >  drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
> > >  include/linux/pwm.h | 25 +++++++++++++++++++++++++
> > >  2 files changed, 52 insertions(+)
>=20
> So do you want me to re-spin?
>=20
> Before you said you'd make adjustments on patches 8 through 10, so I'm
> a little confused.

Yeah, I only realized that it might be quicker to make these adjustments
myself when I had finished looking at patch 10. I've pushed the adjusted
patches to a for-4.8/pwm-capture branch, so if you're going to re-spin
the remainder of the patches, perhaps that could be your base?

	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/=
log/?h=3Dfor-4.8/pwm-capture

If you don't have any objections I can put those into linux-next early
next week.

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWu1cAAoJEN0jrNd/PrOhGzQQAIx9jzFtknhduCh4gDHkFp0f
WsLfSQnTu4h3nVbH4l0U5VTpytCadFNhWTxGibiT3jGuiTP1vCxnflhYKRVMLdwV
KAKE3N2GCFI2B6xVvzep5K6UYATfmGYhaXMbEj/SUCuwUx68YLygThjRmvedpT2a
pbJybTtrUIiTep4YQWosGDrriX+GpytBXKty5JWc3w8rAMRVt2RPQJMyCLJT4czK
smMl8KLETmC8r0vbQR2llhSYBfTKXWqtBt7vroQRVMu1tgZVUOr1f1+RRy2uFbfO
ZrcpzKgidid42y7W0uxsQWyWtZK4SuhWiSmSAHrO9RGe3E1iSZ0K+qQEhe11MKuK
MuCl/Hji8fm2ZWr4h4x2qkIjPHpnLBNiSq+s1vql8vybaEti5r4Amtn+GFNi8pfS
rzILvaD1sK6x/sP11zX8IwX2FxlkHNUq0tccqKAcAO/1BvylBPuQu0j7+rZkJw/s
kPYpa5iewrGrrzne2GFCZkKsbBNkM4svQN7HLqeKBARy2AH47/YhiDRx/DU6dwN8
e1NdNrS0we9ryEqj5vbKGaddR55dcpTdAUMLZc37fXrzadoe4Wb+hwpDjJzqp071
eH+xY47JzKjYeA2eqNcRdlFLh0N/ZszaxC6tgVwPoiWuU3L0iU+M70oYtBEB/cP0
VCP6s/sW/fGmLeCkBkXS
=hkl4
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
