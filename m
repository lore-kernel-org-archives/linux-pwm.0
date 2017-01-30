From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 03/11] pwm: imx: Add separate set of pwm ops for
 PWMv1 and PWMv2
Date: Mon, 30 Jan 2017 09:36:49 +0100
Message-ID: <20170130093649.236e67b1@jawa>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
        <1485726855-16236-4-git-send-email-lukma@denx.de>
        <20170130072312.GI3585@ulmo.ba.sec>
        <20170130074318.GK3585@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/2an2nbXJD/8ajUjjfJy1dKk"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37815 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdA3IhL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 03:37:11 -0500
In-Reply-To: <20170130074318.GK3585@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>

--Sig_/2an2nbXJD/8ajUjjfJy1dKk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

> On Mon, Jan 30, 2017 at 08:23:12AM +0100, Thierry Reding wrote:
> > On Sun, Jan 29, 2017 at 10:54:07PM +0100, Lukasz Majewski wrote:
> > > From: Lukasz Majewski <l.majewski@majess.pl>
> > >=20
> > > This patch provides separate set of pwm ops utilized by
> > > i.MX's PWMv1 and PWMv2.
> > >=20
> > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > > Changes for v5:
> > > - None
> > >=20
> > > Changes for v4:
> > > - None
> > >=20
> > > Changes for v3:
> > > - Adjust the code to work with ipg clock removed
> > >=20
> > > Changes for v2:
> > > - New patch
> > > ---
> > >  drivers/pwm/pwm-imx.c | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index b1d1e50..0fa480d 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -239,7 +239,14 @@ static void imx_pwm_disable(struct pwm_chip
> > > *chip, struct pwm_device *pwm)
> > > clk_disable_unprepare(imx->clk_per); }
> > > =20
> > > -static struct pwm_ops imx_pwm_ops =3D {
> > > +static struct pwm_ops imx_pwm_ops_v1 =3D {
> > > +	.enable =3D imx_pwm_enable,
> > > +	.disable =3D imx_pwm_disable,
> > > +	.config =3D imx_pwm_config,
> > > +	.owner =3D THIS_MODULE,
> > > +};
> > > +
> > > +static struct pwm_ops imx_pwm_ops_v2 =3D {
> >=20
> > Can't these two be const? No need to respin for only this, just let
> > me know and I can make the change while applying.
>=20
> Nevermind that. I just remembered that I had picked up a patch to make
> the original imx_pwm_ops a const and things still work fine if I make
> both of the above const, so I just had to manually apply your patch,
> but other than that it seems fine. Let me apply the rest of this set
> and push out. It'd be great if you could check afterwards that it's
> all still what you expect.

I will do that. Thanks for integrating the patch series :-).

>=20
> Thierry


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/2an2nbXJD/8ajUjjfJy1dKk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliO+zIACgkQf9/hG2YwgjFsHwCfWB4SyNytRST7psUnLYR2Mqec
cW8AnRrpY+PdVni9otrZBiC0jsgpNRWR
=Iozp
-----END PGP SIGNATURE-----

--Sig_/2an2nbXJD/8ajUjjfJy1dKk--
