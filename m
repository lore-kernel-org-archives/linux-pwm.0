From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH] video: backlight: pwm_bl: Initialize fb_bl_on[x] and
 use_count during pwm_backlight_probe()
Date: Thu, 27 Oct 2016 05:46:44 +0200
Message-ID: <20161027054644.192f1efd@jawa>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
        <000201d22d9f$22acb6c0$68062440$@gmail.com>
        <20161024230041.41959e5e@jawa>
        <000d01d22f11$b333ed80$199bc880$@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/JYOmf/AYAwBEfzgL+5SSJfH"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000d01d22f11$b333ed80$199bc880$@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jingoo Han <jingoohan1@gmail.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Fabio Estevam' <fabio.estevam@nxp.com>, 'Fabio Estevam' <festevam@gmail.com>, 'Liu Ying' <Ying.Liu@freescale.com>
List-Id: linux-pwm@vger.kernel.org

--Sig_/JYOmf/AYAwBEfzgL+5SSJfH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jingoo,

> On Monday, October 24, 2016, Lukasz Majewski wrote:
> >=20
> > Hi Jingoo,
> >=20
> > > On Saturday, October 22, 2016, Lukasz Majewski wrote:
> > > >
> > > > The commit: a55944ca82d287ca099ca90413af857af9086773 has posed
> > > > some extra
>=20
> Please add the 'subject' of patch as below.
>=20
> The commit a55944ca82d2 ("backlight: update bd state & fb_blank
> properties when necessary ") has posted some extra.

Ok, I will add such information.

However, I'm more interested in some technical comments regarding
proposed fix.

Could you provide some feedback on the technical side of the patch?

Best regards,
=C5=81ukasz Majewski

>=20
> Best regards,
> Jingoo Han
>=20
>=20
> > >
> > > Please add the subject of the patch, in order to let people know
> > > which patch you mention exactly. Please loot at other commits that
> > > fixed bugs or behavior
> > > of other patches.
> >=20
> > Thanks for the tip.
> >=20
> > The mentioned patch:
> >=20
> > commit a55944ca82d287ca099ca90413af857af9086773
> > Author: Liu Ying <Ying.Liu@freescale.com>
> > Date:   Thu Apr 3 14:48:54 2014 -0700
> >=20
> >     backlight: update bd state & fb_blank properties when necessary
> >=20
> >     We don't have to update the state and fb_blank properties of a
> > backlight
> >     device every time a blanking or unblanking event comes because
> > they may
> >     have already been what we want.  Another thought is that one
> > backlight device may be shared by multiple framebuffers.  The
> > backlight driver should take the backlight device as a resource
> > shared by all the associated framebuffers.
> >=20
> >     This patch adds some logic to record each framebuffer's
> > backlight usage
> >     to determine the backlight device use count and whether the two
> >     properties should be updated or not.  To be more specific, only
> > one unblank operation on a certain blanked framebuffer may increase
> > the backlight device's use count by one, while one blank operation
> > on a certain unblanked framebuffer may decrease the use count by
> > one, because
> >     the userspace is likely to unblank an unblanked framebuffer or
> > blank a blanked framebuffer.
> >=20
> >=20
> > Could you provide more feedback regarding provided fix?
> >=20
> > Thanks in advance,
> >=20
> > =C5=81ukasz Majewski
> >=20
> > >
> > > > restrictions on blanking and unblanking frame buffer device.
> > > >
> > > > Unfortunately, pwm_bl driver's probe did not initialize members
> > > > of struct backlight_device necessary for further blank/unblank
> > > > operation.
> > > >
> > > > This code in case of initial unblank of backlight device
> > > > (default behaviour) sets use_count to 1 and marks this
> > > > particular backlight device as used by all available fb devices
> > > > (since it is not known during probe how much and which fb
> > > > devices will be assigned).
> > > >
> > > > Without this code, the backlight works properly until one tries
> > > > to blank it manually from sysfs with "echo 1
> > > > > /sys/class/graphics/fb0/blank". Since fb_bl_on[0] and
> > > > > use_count were both set to 0, the logic at
> > > > fb_notifier_callback (@backlight.c) thought that we didn't turn
> > > > on (unblanked) the backlight device and refuses to disable
> > > > (blank) it. As a result we see garbage from fb displayed.
> > > >
> > > >
> > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > ---
> > > > The patch has been tested on i.MX6q with vanilla 4.7 and 4.8
> > > > kernels. It applies on 4.9-rcX SHA1:
> > > > dcd4693cf47801b7d988ea897519de90dfd25d17.
> > > >
> > > > ---
> > > >  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > > b/drivers/video/backlight/pwm_bl.c
> > > > index 8040fd6..def39e8 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -203,7 +203,7 @@ static int pwm_backlight_probe(struct
> > > > platform_device *pdev)
> > > >  	struct pwm_bl_data *pb;
> > > >  	int initial_blank =3D FB_BLANK_UNBLANK;
> > > >  	struct pwm_args pargs;
> > > > -	int ret;
> > > > +	int ret, i;
> > > >
> > > >  	if (!data) {
> > > >  		ret =3D pwm_backlight_parse_dt(&pdev->dev,
> > > > &defdata); @@ - 349,6 +349,14 @@ static int
> > > > pwm_backlight_probe(struct platform_device *pdev)
> > > >
> > > >  	bl->props.brightness =3D data->dft_brightness;
> > > >  	bl->props.power =3D initial_blank;
> > > > +
> > > > +	if (initial_blank =3D=3D FB_BLANK_UNBLANK) {
> > > > +		for (i =3D 0; i < FB_MAX; i++)
> > > > +			bl->fb_bl_on[i] =3D true;
> > > > +
> > > > +		bl->use_count =3D 1;
> > > > +	}
> > > > +
> > > >  	backlight_update_status(bl);
> > > >
> > > >  	platform_set_drvdata(pdev, bl);
> > > > --
> > > > 2.1.4
> > >
> > >
>=20
>=20


--Sig_/JYOmf/AYAwBEfzgL+5SSJfH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgReK0ACgkQf9/hG2YwgjGwlQCfWEneSIJ3PuhtD7bqKM5FO7ul
m/YAn1FiBLTApDX23kqfcInF1pcjtER5
=fB32
-----END PGP SIGNATURE-----

--Sig_/JYOmf/AYAwBEfzgL+5SSJfH--
