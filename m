From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 RESEND] video: backlight: pwm_bl: Initialize
 fb_bl_on[x] and use_count during pwm_backlight_probe()
Date: Fri, 6 Jan 2017 13:29:49 +0100
Message-ID: <20170106132949.3fa201f8@jawa>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
        <1482790896-29202-1-git-send-email-l.majewski@majess.pl>
        <20170103083032.GA2977@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/ub5e1_3.5/BomBZpGqTCZCC"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:44703 "EHLO
        1.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936210AbdAFMkS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Jan 2017 07:40:18 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3E1416BCA3
        for <linux-pwm@vger.kernel.org>; Fri,  6 Jan 2017 13:30:15 +0100 (CET)
In-Reply-To: <20170103083032.GA2977@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Ying <Ying.Liu@freescale.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

--Sig_/ub5e1_3.5/BomBZpGqTCZCC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lee, Thierry, Jingoo,

>=20
> Please respond to Lukasz.

Gentel Ping....

Best regards,
=C5=81ukasz Majewski

>=20
> On Mon, 26 Dec 2016, Lukasz Majewski wrote:
>=20
> > The commit a55944ca82d2=20
> > ("backlight: update bd state & fb_blank properties when necessary")
> > has posed some extra restrictions on blanking and unblanking frame
> > buffer device.
> >=20
> > Unfortunately, pwm_bl driver's probe did not initialize members of
> > struct backlight_device necessary for further blank/unblank
> > operation.
> >=20
> > This code in case of initial unblank of backlight device (default=20
> > behaviour) sets use_count to 1 and marks this particular backlight
> > device as used by all available fb devices (since it is not known
> > during probe how much and which fb devices will be assigned).
> >=20
> > Without this code, the backlight works properly until one tries to
> > blank it manually from sysfs with "echo 1
> > > /sys/class/graphics/fb0/blank". Since fb_bl_on[0] and use_count
> > > were both set to 0, the logic at
> > fb_notifier_callback (@backlight.c) thought that we didn't turn on
> > (unblanked) the backlight device and refuses to disable (blank) it.
> > As a result we see garbage from fb displayed.
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > ---
> > The patch has been tested on i.MX6q with vanilla 4.9 kernel.
> > It applies on 4.10-rc1.
> > ---
> >  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c
> > b/drivers/video/backlight/pwm_bl.c index 1261400..6859ba0 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -202,7 +202,7 @@ static int pwm_backlight_probe(struct
> > platform_device *pdev) struct pwm_bl_data *pb;
> >  	int initial_blank =3D FB_BLANK_UNBLANK;
> >  	struct pwm_args pargs;
> > -	int ret;
> > +	int ret, i;
> > =20
> >  	if (!data) {
> >  		ret =3D pwm_backlight_parse_dt(&pdev->dev, &defdata);
> > @@ -348,6 +348,14 @@ static int pwm_backlight_probe(struct
> > platform_device *pdev)=20
> >  	bl->props.brightness =3D data->dft_brightness;
> >  	bl->props.power =3D initial_blank;
> > +
> > +	if (initial_blank =3D=3D FB_BLANK_UNBLANK) {
> > +		for (i =3D 0; i < FB_MAX; i++)
> > +			bl->fb_bl_on[i] =3D true;
> > +
> > +		bl->use_count =3D 1;
> > +	}
> > +
> >  	backlight_update_status(bl);
> > =20
> >  	platform_set_drvdata(pdev, bl);
>=20


--Sig_/ub5e1_3.5/BomBZpGqTCZCC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhvjcQACgkQf9/hG2YwgjGtXgCfTcxyxNpYQzwQEYuSka+TGcZb
dcQAnijZYvxmPhhY0e2/Brtl+dWUzNAQ
=xhCd
-----END PGP SIGNATURE-----

--Sig_/ub5e1_3.5/BomBZpGqTCZCC--
