From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Date: Tue, 7 Oct 2014 11:07:18 +0200
Message-ID: <20141007090718.GC5042@pengutronix.de>
References: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
 <20141007083548.GD24254@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51224 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbaJGJHc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:07:32 -0400
Content-Disposition: inline
In-Reply-To: <20141007083548.GD24254@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 07, 2014 at 10:35:49AM +0200, Thierry Reding wrote:
> On Mon, Oct 06, 2014 at 09:22:44PM +0200, Markus Pargmann wrote:
> > The backlight will be enabled by the panel again if it is used. So we
> > can save the default brightness and disable the pwm backlight when
> > probing.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
> > index 336b83be7e2d..b4f433a6f106 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
> >  		data->dft_brightness =3D data->max_brightness;
> >  	}
> > =20
> > -	bl->props.brightness =3D data->dft_brightness;
> > +	bl->props.brightness =3D 0;
> >  	backlight_update_status(bl);
> > =20
> > +	bl->props.brightness =3D data->dft_brightness;
> > +
> >  	platform_set_drvdata(pdev, bl);
> >  	return 0;
> > =20
>=20
> It would be nice if it was that easy. But we can't do this, because it
> will regress for users of this driver that don't use a panel or DRM. If
> the PWM backlight driver is used for example in conjunction with a plain
> fbdev driver it isn't necessarily hooked up with anything and won't be
> enabled automatically. That's really bad if fbdev is the only output you
> have since you'd have to blindly type the commands to enable the
> backlight. Furthermore disabling backlight isn't always what you want to
> do. For example if the bootloader already turned it on and you hand over
> from bootloader to kernel in a seamless way, then you absolutely want to
> keep backlight on all the time.
>=20
> See also[0] for a different proposal to solve the same problem. Back at
> the time that received only a very few replies, but it would be nice if
> Lee and Bryan could look at it again and see if we can come up with some
> way to deal with this situation.

Yes your proposal looks a lot better to handle the different use cases.
The DT-binding is not a hardware description but I don't see any better
way of passing that information. So it would be good to get your
solution mainline.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUM61GAAoJEEpcgKtcEGQQsZYP/0dzt4YcC1HPXUm3lzWO5LrA
kqjOVFcNTFzk/SSiDWQq0NPCj3Ete82S9UgYPv1mBpLJ1lCmh3N8EmajLAe+8N9e
iDLCA1XR7/OIpQpnKKIbMfVxwUxqLnd9sAQW6lBuU0lN8zeX5air7FzaOYPhzKw1
jsu/i0bpNURLU7zyBiRiHcenMl9rDbXqc84QmKxw3g7NSe5GMenXR9dM3gCnPF5O
ESz/OMnZIs7Cl1iw0CvZGPm2mEHFlAparQzl1VLCursQeOSsCCPNshCdQN1XELZ1
jhhmkan2IrvmqDFUcRS/dUYf7INJZY2QW5mmLkeKDYXzDLA6XTztoIyWGd0fmTgg
kwu+BsN81ww/0q78sbMN5aBmWXMbV0HcLMbNQVhqnKACoRsEN2Uk4glnk0xhSe0u
DH5EnCbJ0Y8lEKVaiDqBq8yTQw+ha0AZV9jyoDyU/Co0RsSwmv6HCpBsSIuSlKnh
TqvoP41OEmGKDZB/NfuqdoELMEAfG3az14EhLELUDyDdZCD7vxW+ETg01IIxx1Vw
5ewar84952bhae2JNEUhQ2xIXaDiyE2UEr97SSPCsU2Xkj9tOCQGxp7wOA/dUd2P
p9P4BgMawKQUnhZ44uvgUXCmfgywnmMTECzGbZGwEENJvJIduobAW9ON/gB3RLfU
GdeSUkpKzxJqdwAqehWN
=/rIG
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
