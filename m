From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 RESEND] video: backlight: pwm_bl: Initialize
 fb_bl_on[x] and use_count during pwm_backlight_probe()
Date: Tue, 3 Jan 2017 00:54:52 +0100
Message-ID: <20170103005452.33d4b117@jawa>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
        <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/fMrRwDv5HRq/.IzEZ.MUZJJ"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:57831 "EHLO
        10.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756719AbdACAfE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Jan 2017 19:35:04 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4532B6D5E0
        for <linux-pwm@vger.kernel.org>; Tue,  3 Jan 2017 00:55:12 +0100 (CET)
In-Reply-To: <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Cc: Liu Ying <Ying.Liu@freescale.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

--Sig_/fMrRwDv5HRq/.IzEZ.MUZJJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear All,

A gentle ping for this patch :-)

We had a discussion about it in a following thread:

http://patchwork.ozlabs.org/patch/689786/

According to comments, I've prepared v2 of this commit and also resend
it recently:

http://patchwork.ozlabs.org/patch/708844/

Any new comments?


Thanks in advance,
=C5=81ukasz Majewski

> The commit a55944ca82d2=20
> ("backlight: update bd state & fb_blank properties when necessary")
> has posed some extra restrictions on blanking and unblanking frame
> buffer device.
>=20
> Unfortunately, pwm_bl driver's probe did not initialize members of
> struct backlight_device necessary for further blank/unblank operation.
>=20
> This code in case of initial unblank of backlight device (default=20
> behaviour) sets use_count to 1 and marks this particular backlight
> device as used by all available fb devices (since it is not known
> during probe how much and which fb devices will be assigned).
>=20
> Without this code, the backlight works properly until one tries to
> blank it manually from sysfs with "echo 1
> > /sys/class/graphics/fb0/blank". Since fb_bl_on[0] and use_count
> > were both set to 0, the logic at
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
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c
> b/drivers/video/backlight/pwm_bl.c index 1261400..6859ba0 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -202,7 +202,7 @@ static int pwm_backlight_probe(struct
> platform_device *pdev) struct pwm_bl_data *pb;
>  	int initial_blank =3D FB_BLANK_UNBLANK;
>  	struct pwm_args pargs;
> -	int ret;
> +	int ret, i;
> =20
>  	if (!data) {
>  		ret =3D pwm_backlight_parse_dt(&pdev->dev, &defdata);
> @@ -348,6 +348,14 @@ static int pwm_backlight_probe(struct
> platform_device *pdev)=20
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


--Sig_/fMrRwDv5HRq/.IzEZ.MUZJJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhq6FMACgkQf9/hG2YwgjEKJQCgkppXhM/FER7argZ+MQ1+nI3W
gJgAniEzToFDO9/e4mPeOewJipg2ukJ+
=Zeol
-----END PGP SIGNATURE-----

--Sig_/fMrRwDv5HRq/.IzEZ.MUZJJ--
