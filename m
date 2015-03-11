From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: git tree
Date: Wed, 11 Mar 2015 11:51:48 +0100
Message-ID: <20150311105147.GA22149@ulmo.nvidia.com>
References: <C6287702A945AC47BE5DB5DFD4B5C6DD01844B9A@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46972 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbbCKKvz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2015 06:51:55 -0400
Received: by pabli10 with SMTP id li10so10419455pab.13
        for <linux-pwm@vger.kernel.org>; Wed, 11 Mar 2015 03:51:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C6287702A945AC47BE5DB5DFD4B5C6DD01844B9A@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Zha, Qipeng" <qipeng.zha@intel.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2015 at 07:53:16AM +0000, Zha, Qipeng wrote:
> Hi=20
>=20
> I got pwm subsystem git tree info as below from v3.19-rc6 MAINTAINER
> And I clone it, found the version is v3.12 Is the tree current
> maintain tree ? or there is a new one, thanks.
>=20
> git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pw=
m.git

You're probably looking at the master branch, but I don't update that.
Use the for-next branch, which is what gets merged into linux-next.

Thierry

> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org [mailto:linux-pwm-owner@vger.kernel=
=2Eorg] On Behalf Of Shawn Guo
> Sent: Monday, March 02, 2015 8:32 PM
> To: Gaetan Hug
> Cc: thierry.reding@gmail.com; linux-pwm@vger.kernel.org; linux-kernel@vge=
r.kernel.org; fabio.estevam@freescale.com
> Subject: Re: [PATCH] pwm: mxs: fix period divider computation
>=20
> On Wed, Feb 18, 2015 at 02:06:34PM +0100, Gaetan Hug wrote:
> > The driver computes which clock divider it sould be using from the=20
> > requested period. This computation assumes that the link between the=20
> > register value and the actual divider value is raising 2 to the power=
=20
> > of the registry value.
> >=20
> >     div =3D 1 << regvalue
> >=20
> > This is true only for the first 5 values out of 8. Next values are 64,
> > 256 and, 1024 - instead of 32, 64, 128.
>=20
> Just checked i.MX28 Reference Manual, and yes, this is the case.
>=20
> > This affects only the users requesting a period > 0.04369s.
> >=20
> > Replace the computation with a look-up table.
>=20
> Your SoB is missing here.  Otherwise,
>=20
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>=20
> > ---
> >  drivers/pwm/pwm-mxs.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c index
> > f75ecb0..c65e183 100644
> > --- a/drivers/pwm/pwm-mxs.c
> > +++ b/drivers/pwm/pwm-mxs.c
> > @@ -35,6 +35,8 @@
> >  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
> >  #define  PERIOD_CDIV_MAX	8
> > =20
> > +static unsigned const int cdiv[PERIOD_CDIV_MAX] =3D {1, 2, 4, 8, 16,=
=20
> > +64, 256, 1024};
> > +
> >  struct mxs_pwm_chip {
> >  	struct pwm_chip chip;
> >  	struct clk *clk;
> > @@ -54,13 +56,13 @@ static int mxs_pwm_config(struct pwm_chip *chip,=20
> > struct pwm_device *pwm,
> > =20
> >  	rate =3D clk_get_rate(mxs->clk);
> >  	while (1) {
> > -		c =3D rate / (1 << div);
> > +		c =3D rate / cdiv[div];
> >  		c =3D c * period_ns;
> >  		do_div(c, 1000000000);
> >  		if (c < PERIOD_PERIOD_MAX)
> >  			break;
> >  		div++;
> > -		if (div > PERIOD_CDIV_MAX)
> > +		if (div >=3D PERIOD_CDIV_MAX)
> >  			return -EINVAL;
> >  	}
> > =20
> > --
> > 1.7.10.4
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in t=
he body of a message to majordomo@vger.kernel.org More majordomo info at  h=
ttp://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in t=
he body of a message to majordomo@vger.kernel.org More majordomo info at  h=
ttp://vger.kernel.org/majordomo-info.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAB5DAAoJEN0jrNd/PrOhq7EP/3AbSZ+ym53DDqj/tMkKAwwy
byuD/ugJG6AvCkM4XwthcHNCPTn8WB5KAFWB4UucPQR7DitWX6hX/xjtcKpaGDyn
65okjlgxnzMTfAkjBnlg5cWLbOWFkGv//sfxZQ4gF4AX21hUU3XBcS3xRMB6DKC1
BqM2U8jG2x0tVPo/fbX11c8/1Doq7ItHr+8O68wZI3zeHDFwI3o8HYv4Sp7j9jGS
hQDNPRqdLEZ8gPeYTxhQewm0e7QjoVdNv9+Lzw1jllJZVjpE/4dl2+ABhF+mdh5H
byacF/GXbvtGV9kvPrIPcxHPtRo/XsfKtclBi0xntjeVC/ObUQWr7/OBmq1qyH21
LdYxTPfvrVzCXRR1FcypYlL5TAh2oiZD4/od6QEN8ko/1TPPxXM1l+jXEReDhQrU
dkWwyzoX6j/WBC0WnYeOO7Eus3L4wIKpuX1qjy1sRYx+1alan0w36Hqqp2DXthru
3k2+U1lFoaAn9UBlKkyBO6/HaUjqOPuPkYlC2vqYLWdVkXqvblL8lMQNV2gvcURT
GZ8tJbJ48acmW0EFvNtndfsyNC1q/f0sLOnYkWoEu1vPcNFjSMTDrpJX6ndZQaE+
SnJJHGyXXeP8pMNzGPJqth+o9CNE7iyq0khvPE59R9XR4NczBgYceyGDJQ09jOKf
b6xpsWQvlXyGYXcYIgEB
=wLLb
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
