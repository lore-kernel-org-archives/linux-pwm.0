From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 RESEND] video: backlight: pwm_bl: Initialize
 fb_bl_on[x] and use_count during pwm_backlight_probe()
Date: Mon, 23 Jan 2017 17:09:17 +0100
Message-ID: <20170123160917.GA2043@ulmo.ba.sec>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
 <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Ying <Ying.Liu@freescale.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-pwm@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 11:21:36PM +0100, Lukasz Majewski wrote:
> The commit a55944ca82d2=20
> ("backlight: update bd state & fb_blank properties when necessary")
> has posed some extra restrictions on blanking and unblanking frame buffer
> device.
>=20
> Unfortunately, pwm_bl driver's probe did not initialize members of
> struct backlight_device necessary for further blank/unblank operation.
>=20
> This code in case of initial unblank of backlight device (default=20
> behaviour) sets use_count to 1 and marks this particular backlight device
> as used by all available fb devices (since it is not known during probe=
=20
> how much and which fb devices will be assigned).
>=20
> Without this code, the backlight works properly until one tries to blank =
it
> manually from sysfs with "echo 1 > /sys/class/graphics/fb0/blank".
> Since fb_bl_on[0] and use_count were both set to 0, the logic at
> fb_notifier_callback (@backlight.c) thought that we didn't turn on
> (unblanked) the backlight device and refuses to disable (blank) it.
> As a result we see garbage from fb displayed.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> ---
> The patch has been tested on i.MX6q with vanilla 4.9 kernel.
> It applies on 4.10-rc1.
> ---
>  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

It's difficult to wrap one's head around the above-mentioned commit
a55944ca82d2 ("backlight: update bd state & fb_blank properties when
necessary"). The solution borders on crazy. That said, this patch
builds on top of crazy, and given that it looks okay to me.

Acked-by: Thierry Reding <thierry.reding@gmail.com>

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 1261400..6859ba0 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -202,7 +202,7 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  	struct pwm_bl_data *pb;
>  	int initial_blank =3D FB_BLANK_UNBLANK;
>  	struct pwm_args pargs;
> -	int ret;
> +	int ret, i;
> =20
>  	if (!data) {
>  		ret =3D pwm_backlight_parse_dt(&pdev->dev, &defdata);
> @@ -348,6 +348,14 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
> =20
>  	bl->props.brightness =3D data->dft_brightness;
>  	bl->props.power =3D initial_blank;
> +
> +	if (initial_blank =3D=3D FB_BLANK_UNBLANK) {
> +		for (i =3D 0; i < FB_MAX; i++)
> +			bl->fb_bl_on[i] =3D true;
> +
> +		bl->use_count =3D 1;
> +	}
> +
>  	backlight_update_status(bl);
> =20
>  	platform_set_drvdata(pdev, bl);
> --=20
> 2.1.4
>=20

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliGKqsACgkQ3SOs138+
s6FVxBAAjHCEYVd7/RCu6zBSnrRAzgw2Vv5n8A6EyZ7eFWYr5sYTWkuJu1GvzVQi
+NIyHUFWd9Eg1yjk457QkcSnLDk3zasPsiLIe25YXBZJXLgto2ssjriw8O+FlQVl
OZe/VFB+Dg84WIQO7BZJaboOufYZbGl5BigbB/PNKaVtROn/BNAgy1anOlH0nD1S
xh3Atb4PCsBDYAWSnTJEvYugxCvfbu7sw8+icwj7huL22fYNusWx9Wbrp8x72BL1
hx4Pp/9vZFCMcW/ETUzXZFNclijsmUiLvL/q6O4R1w7ZcGd+y8P1rM8CTKQkCIvk
HF36Jaa5YockwWsGeLU9EpvQMSDd4E9/NJfGL0URFNuIox+pfvlYAXXj3WhESJI0
G4viSzOJXSIeOqDHFkMfxNYoaB6MQNIePa5AySYzEen21VFQOj65Z6m77DIjGUcc
zcgoy4EPNVb4YITl+iemU0rKs3RJwhnQys9p7tNsLVlOHF0K1vKBtQizNk5DZgPT
oHsKGDjxpJBkfhwv5LSushEN25Hg82iCXXJN+wJqR9xvdRIWsIGRmo9k8v+CKmOC
cph9Bnp0O7AOJBveHSvFpE5mHTYhOmTCAjAeJzovl/kwmeefIDySOGiOU31X8Ayx
Y9WrGvgKPhgfu10nn4usF/YNT26gyDjS/mH2aGxWQyo16fExA+4=
=lbel
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
