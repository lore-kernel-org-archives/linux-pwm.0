From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Mon, 30 Jan 2017 08:54:46 +0100
Message-ID: <20170130075446.GL3585@ulmo.ba.sec>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
 <1485726855-16236-8-git-send-email-lukma@denx.de>
 <20170130084914.672dd16e@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wA9WyeW1yVBM2Q32"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33931 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbdA3ICn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 03:02:43 -0500
Content-Disposition: inline
In-Reply-To: <20170130084914.672dd16e@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>


--wA9WyeW1yVBM2Q32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 08:49:14AM +0100, Boris Brezillon wrote:
> On Sun, 29 Jan 2017 22:54:11 +0100
> Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > This commit provides apply() callback implementation for i.MX's PWMv2.
> >=20
> > Suggested-by: Stefan Agner <stefan@agner.ch>
> > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Changes for v5:
> > - Modify ->apply() function to avoid unbalanced clock enabling/disabling
> > - Fix preventing iMX7 from hanging
> >=20
> > Changes for v4:
> > - Avoid recalculation of PWM parameters when disabling PWM signal
> > - Unconditionally call clk_prepare_enable(imx->clk_per) and
> >   clk_disable_unprepare(imx->clk_per)
> >=20
> > Changes for v3:
> > - Remove ipg clock enable/disable functions
> >=20
> > Changes for v2:
> > - None
> > ---
> >  drivers/pwm/pwm-imx.c | 68 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 68 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index 60cdc5c..fdaa11b 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -249,6 +249,73 @@ static int imx_pwm_config(struct pwm_chip *chip,
> >  	return ret;
> >  }
> > =20
> > +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +			    struct pwm_state *state)
> > +{
> > +	unsigned long period_cycles, duty_cycles, prescale;
> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > +	struct pwm_state cstate;
> > +	unsigned long long c;
> > +	int ret;
> > +
> > +	pwm_get_state(pwm, &cstate);
> > +
> > +	if (state->enabled) {
> > +		c =3D clk_get_rate(imx->clk_per);
> > +		c *=3D state->period;
> > +
> > +		do_div(c, 1000000000);
> > +		period_cycles =3D c;
> > +
> > +		prescale =3D period_cycles / 0x10000 + 1;
> > +
> > +		period_cycles /=3D prescale;
> > +		c =3D (unsigned long long)period_cycles * state->duty_cycle;
> > +		do_div(c, state->period);
> > +		duty_cycles =3D c;
> > +
> > +		/*
> > +		 * according to imx pwm RM, the real period value should be
> > +		 * PERIOD value in PWMPR plus 2.
> > +		 */
> > +		if (period_cycles > 2)
> > +			period_cycles -=3D 2;
> > +		else
> > +			period_cycles =3D 0;
> > +
> > +		/*
> > +		 * Wait for a free FIFO slot if the PWM is already enabled, and
> > +		 * flush the FIFO if the PWM was disabled and is about to be
> > +		 * enabled.
> > +		 */
> > +		if (cstate.enabled) {
> > +			imx_pwm_wait_fifo_slot(chip, pwm);
> > +		} else if (state->enabled) {
>=20
> Should just be
>=20
> 		} else {
>=20
> since we're already in the 'if (state->enabled)' block (see above).
>=20
> I see that Thierry already applied the series, so, just for the record,
> with this fixed, the whole series is
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

I haven't gotten to that patch yet because I need to manually apply a
bunch of these because of the const pwm_ops patch. I'll apply the change
you mentioned and will add your R-b tag.

Thanks,
Thierry

--wA9WyeW1yVBM2Q32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO8UMACgkQ3SOs138+
s6GrKxAAleV2h5bzpMBXOxlOz7vDRw+3GlHvv5k5z07cBIog/aCPgNT39mv8KrlX
DqFEtcMowZEvXNoL77TOIzxG8DPnpGwhk+wY5xnJYQTRRZtiUtDnNzKhgk8daZt4
1f0SoI7d/QRuZh4o2OfNQu+iejd1NQO3tN2eo3mI3uyoF3Ua/aMfr9FLNhSazS48
gdPVRVNIDJHvG3ZinHFczcYgCaEDqn4HzK9KKAQpEj1H1aMgiLBqTnJkSngmVUTK
Y7yyWD8TtGxTmnMAWXVDgJFVnZNd4SGEggnd/Iw190dGMtusliSd1qPTCDG4+jP7
YJg7ctIRFqriK2ilaA95TGaGXae9+dMWvjT+mGVnVZxH7LNOfbjh9qz7BBRIeK7z
bHz0NDbg49RTxVBtxDzMIh4CZEw2hV06i9X3VA7OMsOi63p6Ajxe3qs2X8njORXI
rupc6HH3/+0MSCW/X9CVy7shtTzNjtpj8DJSKwNAW+KdIVECi1xyt7/fqQ0XQUO2
ho+Y58Z+omJRyJL2TQMBR9pml4gozL+m4QbVjsnv98L1wiWgmPQiOIg8YDEYlAjM
XGtzgaYlR5AgDA/w+0lMgn+HBE9ZgGYGygJBdbPcroMa1QjEdFBdY92yAG7nXWQs
nU555PehzSxp1NRkmHtczqR7TKWqvz6719UMeI4nMvjsgWEaUek=
=oCdS
-----END PGP SIGNATURE-----

--wA9WyeW1yVBM2Q32--
