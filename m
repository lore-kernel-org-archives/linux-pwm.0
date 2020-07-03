From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC PATCH 06/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Date: Fri, 3 Jul 2020 18:15:56 +0200
Message-ID: <20200703161556.GA2578@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-5-j.neuschaefer@gmx.net>
 <20200622081802.pv4xmb7vn4te5r5t@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200622081802.pv4xmb7vn4te5r5t-T6qyLwKrzP+Pq0V0m3QNwQq/OYV65a7L4Y2cMoPwMik@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, allen <allen.chen-4K37Az1KcQB9nmWX13WWKA@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-
List-Id: linux-pwm@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:18:02AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Jun 21, 2020 at 12:42:17AM +0200, Jonathan Neusch=C3=A4fer wrote:
> > The Netronix EC provides a PWM output, which is used for the backlight
>=20
> s/,//
>=20
> > on ebook readers. This patches adds a driver for the PWM output.
>=20
> on *some* ebook readers

Ok, I'll fix these.

>=20
> > +#define NTXEC_UNK_A		0xa1
> > +#define NTXEC_UNK_B		0xa2
> > +#define NTXEC_ENABLE		0xa3
> > +#define NTXEC_PERIOD_LOW	0xa4
> > +#define NTXEC_PERIOD_HIGH	0xa5
> > +#define NTXEC_DUTY_LOW		0xa6
> > +#define NTXEC_DUTY_HIGH		0xa7
> > +
> > +/*
> > + * The time base used in the EC is 8MHz, or 125ns. Period and duty cyc=
le are
> > + * measured in this unit.
> > + */
> > +static int ntxec_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm_dev,
> > +				 int duty_ns, int period_ns)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> > +	uint64_t duty =3D duty_ns;
> > +	uint64_t period =3D period_ns;
>=20
> As you cannot use values bigger than 8191999 anyhow, I wonder why you
> use a 64 bit type here.

No particular reason; I possibly got confused by the division API. I'll
use uint32_t instead.

> > +	int res =3D 0;
> > +
> > +	do_div(period, 125);
>=20
> Please use a define instead of plain 125.

Will do.

> > +	if (period > 0xffff) {
> > +		dev_warn(pwm->dev,
> > +			 "Period is not representable in 16 bits: %llu\n", period);
> > +		return -ERANGE;
> > +	}
> > +
> > +	do_div(duty, 125);
> > +	if (duty > 0xffff) {
> > +		dev_warn(pwm->dev, "Duty cycle is not representable in 16 bits: %llu=
\n",
> > +			duty);
> > +		return -ERANGE;
> > +	}
>=20
> This check isn't necessary as the pwm core ensures that duty <=3D period.

Ok, I'll remove it.
>=20
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);
>=20
> Does this complete the currently running period? Can it happen that a
> new period starts between the first and the last write and so a mixed
> period can be seen at the output?

Good question. I haven't measured it, and also don't have the code
running on the EC.

>=20
> > +
> > +	return (res < 0) ? -EIO : 0;
> > +}
> > +
> > +static int ntxec_pwm_enable(struct pwm_chip *chip,
> > +				 struct pwm_device *pwm_dev)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> > +
> > +	return ntxec_write8(pwm->ec, NTXEC_ENABLE, 1);
> > +}
> > +
> > +static void ntxec_pwm_disable(struct pwm_chip *chip,
> > +				   struct pwm_device *pwm_dev)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> > +
> > +	ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
> > +}
> > +
> > +static struct pwm_ops ntxec_pwm_ops =3D {
> > +	.config		=3D ntxec_pwm_config,
> > +	.enable		=3D ntxec_pwm_enable,
> > +	.disable	=3D ntxec_pwm_disable,
> > +	.owner		=3D THIS_MODULE,
>=20
> Please don't align the =3D, just a single space before them is fine.

Ok

> More important: Please implement .apply() (and .get_state()) instead of
> the old API. Also please enable PWM_DEBUG which might save us a review
> iteration.

Will do!

>=20
> > +};
> > +
> > +static int ntxec_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct ntxec_pwm *pwm;
> > +	struct pwm_chip *chip;
> > +	int res;
> > +
> > +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > +	if (!pwm)
> > +		return -ENOMEM;
> > +
> > +	pwm->ec =3D ec;
> > +	pwm->dev =3D &pdev->dev;
> > +
> > +	chip =3D &pwm->chip;
> > +	chip->dev =3D &pdev->dev;
> > +	chip->ops =3D &ntxec_pwm_ops;
> > +	chip->base =3D -1;
> > +	chip->npwm =3D 1;
> > +
> > +	res =3D pwmchip_add(chip);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	platform_set_drvdata(pdev, pwm);
> > +
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_A, 0xff);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_B, 0xff);
> > +
> > +	return (res < 0) ? -EIO : 0;
>=20
> This is broken for several reasons:
>=20
>  - You're not supposed to modify the output in .probe
>  - if ntxec_write8 results in an error you keep the pwm registered.
>  - From the moment on pwmchip_add returns the callbacks can be called.
>    The calls to ntxec_write8 probably interfere here.

Ok, I'll rework the probe function to avoid these issues.


Thanks for the review,
Jonathan Neusch=C3=A4fer

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl7/WbUACgkQCDBEmo7z
X9sA1BAAoaUXyqhLeTCR3RU7shyvr9x8b/kQ4QQahjrf7CK5jyE4aDDebspprYnq
13AftAJFOoVGhnFOqT8H8jhNO9qCRZ7udKCPABMdc4kzs5NMWQ2zK+s9890zcIZC
6UClwhRCkG+/wEY55LEW0lVCkQJtrkIXQ8OHCc9Cgb83hTQXULu/7Lxq/kOW5rkH
7mffJP46Ul5mtNYdd/EfKxHzxViPHswPKNEkQ9tI26Lc4IcQ3tg4amS480uez8Mi
EJZQaQAPYUPmxF5msepumrB5lAm9UL+Hn1EFnHhFdoWv+9TuaHTOwJM6uksOGPjr
RBcup36uhof9G80yNlFm59IgR52KWeAMWNBixBYHlkT6uObYMsY4RZOVb61lgf+v
WhVi8EJS7xIGTrT6DyYZRqhaN4SaPdQ5YOMsr+W0QqbeGv9W2Z6MtY3cZxKnyREI
EcrZ/qlbdcwhwpwknW/TyPA5qXO5M9WLnaJ4AR8bwDpX04CmtwDx0ej088ID2mwC
tWoy/bz0Ubsip1h8F5ClTGK8C/vg1PVD6qKTai1iDhVmucwL6KrU2lnvEmzY/RJX
6HYkfboXXEGAiK3TBw5rJ/x5MvhKPBUrlaI9Zfk/A/m27FlgUutWbCVcWYiOdeKo
K/nBRBQW9L8ArmDjUOpv2jXTs6wa+eMX7sxaO7uhyxZu5amuemA=
=1TeA
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
