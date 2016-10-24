From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH] video: backlight: pwm_bl: Initialize fb_bl_on[x] and
 use_count during pwm_backlight_probe()
Date: Mon, 24 Oct 2016 23:00:41 +0200
Message-ID: <20161024230041.41959e5e@jawa>
References: <1477169904-14997-1-git-send-email-l.majewski@majess.pl>
        <000201d22d9f$22acb6c0$68062440$@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/H2kKJ4jDJFeGHiFTA0QADSF"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:38275 "EHLO
        15.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965637AbcJXVBM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Oct 2016 17:01:12 -0400
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 921CF4B3F2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Oct 2016 23:01:05 +0200 (CEST)
In-Reply-To: <000201d22d9f$22acb6c0$68062440$@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jingoohan1@gmail.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Fabio Estevam' <fabio.estevam@nxp.com>, 'Fabio Estevam' <festevam@gmail.com>, 'Liu Ying' <Ying.Liu@freescale.com>

--Sig_/H2kKJ4jDJFeGHiFTA0QADSF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jingoo,

> On Saturday, October 22, 2016, Lukasz Majewski wrote:
> >=20
> > The commit: a55944ca82d287ca099ca90413af857af9086773 has posed some
> > extra
>=20
> Please add the subject of the patch, in order to let people know
> which patch you mention exactly. Please loot at other commits that
> fixed bugs or behavior
> of other patches.

Thanks for the tip.

The mentioned patch:

commit a55944ca82d287ca099ca90413af857af9086773
Author: Liu Ying <Ying.Liu@freescale.com>
Date:   Thu Apr 3 14:48:54 2014 -0700

    backlight: update bd state & fb_blank properties when necessary
   =20
    We don't have to update the state and fb_blank properties of a backlight
    device every time a blanking or unblanking event comes because they may
    have already been what we want.  Another thought is that one backlight
    device may be shared by multiple framebuffers.  The backlight driver
    should take the backlight device as a resource shared by all the
    associated framebuffers.
   =20
    This patch adds some logic to record each framebuffer's backlight usage
    to determine the backlight device use count and whether the two
    properties should be updated or not.  To be more specific, only one
    unblank operation on a certain blanked framebuffer may increase the
    backlight device's use count by one, while one blank operation on a
    certain unblanked framebuffer may decrease the use count by one, because
    the userspace is likely to unblank an unblanked framebuffer or blank a
    blanked framebuffer.


Could you provide more feedback regarding provided fix?

Thanks in advance,

=C5=81ukasz Majewski

>=20
> > restrictions on blanking and unblanking frame buffer device.
> >=20
> > Unfortunately, pwm_bl driver's probe did not initialize members of
> > struct backlight_device necessary for further blank/unblank
> > operation.
> >=20
> > This code in case of initial unblank of backlight device (default
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
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > ---
> > The patch has been tested on i.MX6q with vanilla 4.7 and 4.8
> > kernels. It applies on 4.9-rcX SHA1:
> > dcd4693cf47801b7d988ea897519de90dfd25d17.
> >=20
> > ---
> >  drivers/video/backlight/pwm_bl.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c
> > b/drivers/video/backlight/pwm_bl.c
> > index 8040fd6..def39e8 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -203,7 +203,7 @@ static int pwm_backlight_probe(struct
> > platform_device *pdev)
> >  	struct pwm_bl_data *pb;
> >  	int initial_blank =3D FB_BLANK_UNBLANK;
> >  	struct pwm_args pargs;
> > -	int ret;
> > +	int ret, i;
> >=20
> >  	if (!data) {
> >  		ret =3D pwm_backlight_parse_dt(&pdev->dev,
> > &defdata); @@ - 349,6 +349,14 @@ static int
> > pwm_backlight_probe(struct platform_device *pdev)
> >=20
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
> >=20
> >  	platform_set_drvdata(pdev, bl);
> > --
> > 2.1.4
>=20
>=20


--Sig_/H2kKJ4jDJFeGHiFTA0QADSF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgOdoIACgkQf9/hG2YwgjFIQACfTZ8StQzFWhuwKxgMaEMOWs5m
QDUAoIb/wxlxeq44TA6XEg53DBv3O+jC
=18ek
-----END PGP SIGNATURE-----

--Sig_/H2kKJ4jDJFeGHiFTA0QADSF--
