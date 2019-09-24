From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: pwm-mxs: use devm_platform_ioremap_resource()
 to simplify code
Date: Tue, 24 Sep 2019 13:02:48 +0200
Message-ID: <20190924110248.GF14924@ulmo>
References: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 05:42:48PM +0800, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> 	- This is a resend version of patch: https://patchwork.kernel.org/patch/=
11048365/
> ---
>  drivers/pwm/pwm-mxs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

When you do resend patches, please make sure to include an Reviewed-by
or Acked-by tags that you get.

In this case that's not necessary since I had already applied the other
patch.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 04c0f6b..b14376b 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -126,15 +126,13 @@ static int mxs_pwm_probe(struct platform_device *pd=
ev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct mxs_pwm_chip *mxs;
> -	struct resource *res;
>  	int ret;
> =20
>  	mxs =3D devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
>  	if (!mxs)
>  		return -ENOMEM;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mxs->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	mxs->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mxs->base))
>  		return PTR_ERR(mxs->base);
> =20
> --=20
> 2.7.4
>=20

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J99gACgkQ3SOs138+
s6GQAhAArhAUpmU0pjAl8qc9eLxwkVNYkfxSagID+AR2KE1BW29cp1kDA5Mkg2/s
dy4eDAwIjvNSh0l8rlFrUmZ2Mxa5kOkHwEcfnHxNf6sps28wd2TseR0oIs/Nka4p
F8PDHqh7ukLOuJpLCt4H2oC2BkmXLq18w7fneryX8TMfg/KgrOqLDyuUIxUP7OzW
HKfgz6u1IfDH6U/1ehn601t6MJBNjenqFIJsiEVqUbynIBRqE4Ss7+QAxGQ2jrAu
A4NnolWe05xJjLeRqXGmD71fkHZHjyyN1sRggpsOOXCWkqcAZP0/wWq25PI055jv
eFZ/WjvqMfEVXCvxqR1iLmr/cgIsCpTrW8kzbyVbIjcWaw6fQtKdPOnEx0TQIC4v
GgDmVIMnjxhG82CSr9LBQ1hpQL6hDQJKltYSkQPZ8WwO2ISY0xmjCcvm1+FMG2ak
QjROGJw7JGoKQ46sD5/iYlEnGaEQTqVKCsTwb8kWGbQswKMxMmdd9cBImxTJxrua
ta2PsGUDKC18XSbw+bzh4EDJ1wYr4kOca2rWYbO9ubKXTsEkM4iiDIN9zrEhbmIH
L+CIlM03DnQq++a3DQsTS3/XpLAHVynaID9sa7nzcadb0ex6Twno+WP7weo/xySH
Q6S0fwoqdI8yJgN2SMmI/xePpnp7CDmRJ0pmXRx1GbJnfbsZbrI=
=h/nA
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
