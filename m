From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2] video: backlight: pwm_bl: Initialize fb_bl_on[x] and
 use_count during pwm_backlight_probe()
Date: Wed, 9 Nov 2016 22:05:05 +0100
Message-ID: <20161109220505.63b301b7@jawa>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
        <1477985147-18835-1-git-send-email-l.majewski@majess.pl>
        <20161108232525.639ea49f@jawa>
        <20161109145238.GE13127@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/udxqKTZg=CkOg2PtODuYID4"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161109145238.GE13127@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, linux-fbdev@vger.kernel.org, Liu Ying <Ying.Liu@freescale.com>
List-Id: linux-pwm@vger.kernel.org

--Sig_/udxqKTZg=CkOg2PtODuYID4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lee,

> On Tue, 08 Nov 2016, Lukasz Majewski wrote:
>=20
> > Dear All,
> >=20
> > > The commit a55944ca82d2 ("backlight: update bd state & fb_blank
> > > properties when necessary") has posed some extra restrictions on
> > > blanking and unblanking frame buffer device.
> > >=20
> > > Unfortunately, pwm_bl driver's probe did not initialize members of
> > > struct backlight_device necessary for further blank/unblank
> > > operation.
> > >=20
> > > This code in case of initial unblank of backlight device (default=20
> > > behaviour) sets use_count to 1 and marks this particular backlight
> > > device as used by all available fb devices (since it is not known
> > > during probe how much and which fb devices will be assigned).
> > >=20
> > > Without this code, the backlight works properly until one tries to
> > > blank it manually from sysfs with "echo 1
> > > > /sys/class/graphics/fb0/blank". Since fb_bl_on[0] and use_count
> > > > were both set to 0, the logic at
> > > fb_notifier_callback (@backlight.c) thought that we didn't turn on
> > > (unblanked) the backlight device and refuses to disable (blank)
> > > it. As a result we see garbage from fb displayed.
> >=20
> > COmments/acks are more than welcome :-)
>=20
> I thought Jingoo already replied to you?

Yes, Jingoo replied to me and asked for correcting the patch
description. The corrected patch is the v2.


Best regards,
=C5=81ukasz Majewski

>=20
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > ---
> > > The patch has been tested on i.MX6q with 4.9-rc3
> > > SHA1: a909d3e636995ba7c349e2ca5dbb528154d4ac30
> > > ---
> > > Changes for v2:
> > > - Update commit message with proper other commit reference
> > >=20
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > b/drivers/video/backlight/pwm_bl.c index 1261400..6859ba0 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -202,7 +202,7 @@ static int pwm_backlight_probe(struct
> > > platform_device *pdev) struct pwm_bl_data *pb;
> > >  	int initial_blank =3D FB_BLANK_UNBLANK;
> > >  	struct pwm_args pargs;
> > > -	int ret;
> > > +	int ret, i;
> > > =20
> > >  	if (!data) {
> > >  		ret =3D pwm_backlight_parse_dt(&pdev->dev,
> > > &defdata); @@ -348,6 +348,14 @@ static int
> > > pwm_backlight_probe(struct platform_device *pdev)=20
> > >  	bl->props.brightness =3D data->dft_brightness;
> > >  	bl->props.power =3D initial_blank;
> > > +
> > > +	if (initial_blank =3D=3D FB_BLANK_UNBLANK) {
> > > +		for (i =3D 0; i < FB_MAX; i++)
> > > +			bl->fb_bl_on[i] =3D true;
> > > +
> > > +		bl->use_count =3D 1;
> > > +	}
> > > +
> > >  	backlight_update_status(bl);
> > > =20
> > >  	platform_set_drvdata(pdev, bl);
> >=20
>=20
>=20
>=20


--Sig_/udxqKTZg=CkOg2PtODuYID4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgjj4gACgkQf9/hG2YwgjHvYQCfW7+y+sELEMqfIgRdZ+nQfdyK
EhgAoLiYNglkCqG3knJAl8vFdIKQR+XC
=p/Yr
-----END PGP SIGNATURE-----

--Sig_/udxqKTZg=CkOg2PtODuYID4--
