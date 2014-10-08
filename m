From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Date: Wed, 8 Oct 2014 11:55:37 +0200
Message-ID: <20141008095537.GJ5042@pengutronix.de>
References: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
 <20141007083548.GD24254@ulmo>
 <20141007090718.GC5042@pengutronix.de>
 <CAEC9eQNhFE9=0ycbOyf6BzKTyvdGh9EGSCJqDiF7oTtvDWgTTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43571 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbaJHJzs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Oct 2014 05:55:48 -0400
Content-Disposition: inline
In-Reply-To: <CAEC9eQNhFE9=0ycbOyf6BzKTyvdGh9EGSCJqDiF7oTtvDWgTTw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ajay kumar <ajaynumb@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, linux-pwm@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@pengutronix.de


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 02:47:53PM +0530, Ajay kumar wrote:
> On Tue, Oct 7, 2014 at 2:37 PM, Markus Pargmann <mpa@pengutronix.de> wrot=
e:
> > Hi,
> >
> > On Tue, Oct 07, 2014 at 10:35:49AM +0200, Thierry Reding wrote:
> >> On Mon, Oct 06, 2014 at 09:22:44PM +0200, Markus Pargmann wrote:
> >> > The backlight will be enabled by the panel again if it is used. So we
> >> > can save the default brightness and disable the pwm backlight when
> >> > probing.
> >> >
> >> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >> > ---
> >> >  drivers/video/backlight/pwm_bl.c | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backli=
ght/pwm_bl.c
> >> > index 336b83be7e2d..b4f433a6f106 100644
> >> > --- a/drivers/video/backlight/pwm_bl.c
> >> > +++ b/drivers/video/backlight/pwm_bl.c
> >> > @@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
> >> >             data->dft_brightness =3D data->max_brightness;
> >> >     }
> >> >
> >> > -   bl->props.brightness =3D data->dft_brightness;
> >> > +   bl->props.brightness =3D 0;
> >> >     backlight_update_status(bl);
> >> >
> >> > +   bl->props.brightness =3D data->dft_brightness;
> >> > +
> >> >     platform_set_drvdata(pdev, bl);
> >> >     return 0;
> >> >
> >>
> >> It would be nice if it was that easy. But we can't do this, because it
> >> will regress for users of this driver that don't use a panel or DRM. If
> >> the PWM backlight driver is used for example in conjunction with a pla=
in
> >> fbdev driver it isn't necessarily hooked up with anything and won't be
> >> enabled automatically. That's really bad if fbdev is the only output y=
ou
> >> have since you'd have to blindly type the commands to enable the
> >> backlight. Furthermore disabling backlight isn't always what you want =
to
> >> do. For example if the bootloader already turned it on and you hand ov=
er
> >> from bootloader to kernel in a seamless way, then you absolutely want =
to
> >> keep backlight on all the time.
> >>
> >> See also[0] for a different proposal to solve the same problem. Back at
> >> the time that received only a very few replies, but it would be nice if
> >> Lee and Bryan could look at it again and see if we can come up with so=
me
> >> way to deal with this situation.
> >
> > Yes your proposal looks a lot better to handle the different use cases.
> > The DT-binding is not a hardware description but I don't see any better
> > way of passing that information. So it would be good to get your
> > solution mainline.
> +1
> And, I have already tested Thierry's proposal on Exynos5800 peach_pi.

I also tested Thierry's patch on i.MX6s now and it works fine.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUNQoZAAoJEEpcgKtcEGQQ8ogP/3QTZ3/uW9F9K0EEgdGBAXVy
1p2yEpJiSARFXEs11GAj3W64iwE59q5SxOs0qKT18XKb180gbpzWlDv103/+ujsC
NFU83QLJgYd2rUcxhTZIZqsirmuC7+HCT9IKnRf6VVOAT7Gsx7CV32LU+fV6mr/0
k5pYvJKF8ZZGW0wEhE1fOYPjl7y24WB9SIoVy1aJnuioI5xnL2N0zCx9lzFl6nu6
z1j/k9WYWUINmIJVrxmtvRCEP1ZLRa+POZOkH2t5UhaOc6iqWG0RmcjBBfGZ+eNq
x4uL7U6mN982hWUZAfkuv5PQshPT6fOuSF7AJbnMMplIJmm02kQGq8eMkcfXZhok
zJbPSGanJkLwyOTILv3wtm62OjqZndE9MteqJIeTVir1tFi/IEVi+Hn/IWCJsLP5
kLkCLAFuraKYunNxK8Z2TnRlq3g3HT+UtZEDF/tzqlZCpu2IVZPv/iYOjGDSF1cE
HALmLnt4YJnK+LhIVDmMXZ70MGrtSr4pNW5x84MI1Ois6fnIpMhEAV2GuFmvKzB7
tMtfS5Vw6q+KHifoSoOrnIz5KUaJPnvCiYYlJtY8QiRiuid+TpkJuTWZtnEBVRX3
74WJlUnydF9WItk3SG82FR3Fumbt5gq3NOUd1nRhvnmdx70TZ+zRmuiMkRQzEuQy
7jaiZAVZDfQZgm2iCV+z
=R7Zb
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--
