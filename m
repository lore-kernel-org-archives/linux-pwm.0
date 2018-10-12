From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Date: Fri, 12 Oct 2018 17:54:59 +0200
Message-ID: <20181012155459.GG31561@ulmo>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 03:04:48PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> On 12.10.2018 10:57, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Oct 10, 2018 at 09:33:26AM +0000, Vok=C3=A1=C4=8D Michal wrote:
[...]
> >> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> >> +		struct platform_device *pdev)
> >> +{
> >> +	imx_chip->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> >> +	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {
> >> +		dev_info(&pdev->dev, "can not get pinctrl\n");
> >> +		return PTR_ERR(imx_chip->pinctrl);
> >> +	}
> >> +
> >> +	imx_chip->pinctrl_pins_pwm =3D pinctrl_lookup_state(imx_chip->pinctr=
l,
> >> +			"pwm");
> >> +	imx_chip->pinctrl_pins_gpio =3D pinctrl_lookup_state(imx_chip->pinct=
rl,
> >> +			"gpio");
> >> +	imx_chip->pwm_gpiod =3D devm_gpiod_get_optional(&pdev->dev, "pwm",
> >> +			GPIOD_IN);
> >> +
> >> +	if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER) {
> >=20
> > You must not use PTR_ERR on a value that might not contain an error
> > pointer.
>=20
> OK, thank you for valuable info.
> So it seems like the I2C folks are in troubles as well:
>=20
> 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-im=
x.c#L996

There's nothing inherently wrong with doing it like the above, just
maybe slightly unusual. PTR_ERR() is really just casting from a pointer
to an integer, so if the pointer happens to contain the value
-EPROBE_DEFER, then the above will be true. If it contains a valid
pointer, the above will be false, so it does exactly what you want.

Perhaps a more idiomatic way to write this would be:

	if (IS_ERR(imx_chip->pwm_gpiod)) {
		if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER)
			return -EPROBE_DEFER;
	}

But that's not much clearer than what you have, so feel free to keep it
that way.

Thierry

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAw88ACgkQ3SOs138+
s6GXsw//ZQtbpCz6HK0hGZvNAC+fn9QWEcg3hHDpDjDkDXJSvkbmcb0DicppwFE7
DRJcqK6M1bMI3JwZBUlrg2V3o3365DBXr+ojnTt7v1nKNhzG7+FIvL4ke6mxaiC9
NlpCqTZcD8rHxkRmT+fv5x38dIUOZJt85himbtGtO4F7uetHe5qrSRCxtbPjaeb/
Wv2lsGsaPtfTUTjO+XuoBnfpsmNrfm/iM2hJaw/YJgPk0u/roCvS2sIWcy2ldYUd
loTNjQAvPMYmQNyraEs+6cfiz0NuukN2Z16KBppbInxtLmyWqUmDMdegVzOliAWd
m0KGiSBykCkv0HeTEtvFcQwVYpvnY2NJATu06o3NvlsAabLK5O6ZEBUHu81DCo5w
NWY85+kFu+99prTYD9zJGUOaGFAPHI6jTN3bIvKG2yL7vKugqkvlAdt8+7CnalRS
7+HP+3wP22ejckc36PbT0Uiit3IiNWb+E5tkZ/CgfT+V6bCSRnG6J/IGexi7QKbi
RNIIBqrjaremE9vWtJ3jjwJIMTSwHndoOM56GoYyCNk2URoUkjuZWt47NmI78R7f
/7KtZrxYH63wQOqdstOW6WMDRJefG5XHnpubPTXplNEYSaByTkeMJJwK/SBazcDS
a2bnidG/OjnWqy8ayJkgsacoN32FNNJAf9s9PMAHLQwt/wyIFY4=
=A30V
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
