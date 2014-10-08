From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Date: Wed, 8 Oct 2014 14:13:37 +0200
Message-ID: <20141008121334.GA7357@ulmo.nvidia.com>
References: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
 <20141007083548.GD24254@ulmo>
 <001601cfe2dc$6e964ca0$4bc2e5e0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:61508 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbaJHMNn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Oct 2014 08:13:43 -0400
Content-Disposition: inline
In-Reply-To: <001601cfe2dc$6e964ca0$4bc2e5e0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Markus Pargmann' <mpa@pengutronix.de>, 'Lee Jones' <lee.jones@linaro.org>, 'Bryan Wu' <cooloney@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 'Ajay kumar' <ajaynumb@gmail.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 06:44:19PM +0900, Jingoo Han wrote:
> On Tuesday, October 07, 2014 5:36 PM, Thierry Reding wrote:
> > On Mon, Oct 06, 2014 at 09:22:44PM +0200, Markus Pargmann wrote:
> > > The backlight will be enabled by the panel again if it is used. So we
> > > can save the default brightness and disable the pwm backlight when
> > > probing.
> > >
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> > > index 336b83be7e2d..b4f433a6f106 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_d=
evice *pdev)
> > >  		data->dft_brightness =3D data->max_brightness;
> > >  	}
> > >
> > > -	bl->props.brightness =3D data->dft_brightness;
> > > +	bl->props.brightness =3D 0;
> > >  	backlight_update_status(bl);
> > >
> > > +	bl->props.brightness =3D data->dft_brightness;
> > > +
> > >  	platform_set_drvdata(pdev, bl);
> > >  	return 0;
> > >
> >=20
> > It would be nice if it was that easy. But we can't do this, because it
> > will regress for users of this driver that don't use a panel or DRM. If
> > the PWM backlight driver is used for example in conjunction with a plain
> > fbdev driver it isn't necessarily hooked up with anything and won't be
> > enabled automatically. That's really bad if fbdev is the only output you
> > have since you'd have to blindly type the commands to enable the
> > backlight. Furthermore disabling backlight isn't always what you want to
> > do. For example if the bootloader already turned it on and you hand over
> > from bootloader to kernel in a seamless way, then you absolutely want to
> > keep backlight on all the time.
> >=20
> > See also[0] for a different proposal to solve the same problem. Back at
> > the time that received only a very few replies, but it would be nice if
> > Lee and Bryan could look at it again and see if we can come up with some
> > way to deal with this situation.
>=20
> (+cc Ajay Kumar)
>=20
> As I said earlier, I agree with this proposal.

I'm not sure which proposal exactly. I originally proposed adding a
backlight-boot-off property, but that received some pushback from DT
people because it isn't strictly hardware information but configuration
data.

Perhaps a better solution would be to default to not touching the
backlight status on probe at all. But we can't do that for non-DT
because of backwards-compatibility. For DT it seems like all users have
some form of DRM/KMS driver too, so I'd expect them to turn it off when
appropriate.

Should we just go and make that change (no changing backlight state for
DT) and see if anybody complains? If so, I'll gladly prepare a patch to
do just that.

Thierry

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUNSpuAAoJEN0jrNd/PrOhF3MP/3I1wJF3YUTIJe+8YMoLMVYJ
CdE9w0c5jar6AARLwOpIWQgKJ9PJiiIklmfyQ4WVO+nVCGb2Y9+zMzUXRQxl6uyn
ojIQLO7NHmexHfN7w5BnMdfFLZxfOoqrvivwyiUERniQ39ZD9RAeFklArj7TzOhx
Q89xuIy7J9VJBVAbc8osZ5ItvNZUvCKrbRyOAFvyqQ6LmtqyqKlaojjIkGeVDTXw
+WcKZJTI7zv7U8XQDX4K7ESy0RrWLhHTJKo3EML4CWm8EFmMD1zdfnHXZEFqFs9n
lZ58z5OxGZzJHHtzzHiZI+7Ppe3TaOz99oHyCt3Kq5t/tqxkd2EvJ5BNk2OSalbt
MfgkuZLAEIXF26h9+sYXf0x3acB8O9O1dSVxAiy+olxDEcJJBsjpG1yK5+FKsR09
TG0aB01n63pCR2v5MO3+IpDbEsoKwLuxJQgZOPYt3CI1rjc/wXqi31V7i0LDfJgi
wRm6SCp88jQ8ebj70/eGuA2AO2Dw6Mlol3BmvCwpHKYTJZ7mbS28gJ7Olpuqtzay
CYdzXKelHUoRPwzXN688xT/Soeyp3n7EkJHg4hUsBv5o3iiG10MKWoeIMBnvaPil
hMX9tjmQz5LkPKNoSMZLf2BMViavP81z3aqWSHfm4gEuuuTyBihIF2+EcJAdogED
BqhRx70HsauPixD5ikiM
=zcuU
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
