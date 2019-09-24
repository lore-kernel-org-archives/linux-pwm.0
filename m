From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Date: Tue, 24 Sep 2019 12:52:09 +0200
Message-ID: <20190924105209.GC14924@ulmo>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
 <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: 'Anson Huang' <Anson.Huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linux-imx@nxp.com" <Linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 09:46:20AM +0000, David Laight wrote:
> From: Anson Huang
> > Sent: 24 September 2019 10:00
> > Add helper variable dev =3D &pdev->dev to simply the code.
> >=20
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/pwm/pwm-imx27.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 434a351..3afee29 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -290,27 +290,28 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> >=20
> >  static int pwm_imx27_probe(struct platform_device *pdev)
> >  {
> > +	struct device *dev =3D &pdev->dev;
> >  	struct pwm_imx27_chip *imx;
> >=20
> > -	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> > +	imx =3D devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
> >  	if (imx =3D=3D NULL)
> >  		return -ENOMEM;
> >=20
> >  	platform_set_drvdata(pdev, imx);
> >=20
> > -	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> > +	imx->clk_ipg =3D devm_clk_get(dev, "ipg");
> >  	if (IS_ERR(imx->clk_ipg)) {
> > -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> > +		dev_err(dev, "getting ipg clock failed with %ld\n",
> >  				PTR_ERR(imx->clk_ipg));
> >  		return PTR_ERR(imx->clk_ipg);
> >  	}
> >=20
> > -	imx->clk_per =3D devm_clk_get(&pdev->dev, "per");
> > +	imx->clk_per =3D devm_clk_get(dev, "per");
> >  	if (IS_ERR(imx->clk_per)) {
> >  		int ret =3D PTR_ERR(imx->clk_per);
> >=20
> >  		if (ret !=3D -EPROBE_DEFER)
> > -			dev_err(&pdev->dev,
> > +			dev_err(dev,
> >  				"failed to get peripheral clock: %d\n",
> >  				ret);
>=20
> Hopefully the compiler will optimise this back otherwise you've added ano=
ther
> local variable which may cause spilling to stack.
> For a setup function it probably doesn't matter, but in general it might
> have a small negative performance impact.
>=20
> In any case this doesn't shorten any lines enough to remove line-wrap
> and using &pdev->dev is really one less variable to mentally track
> when reading the code.
>=20
> 	David

I agree. A positive diffstat is often a good indication that it's not
worth it. Don't get me wrong, I think there are cases where an extra
local variable can be worth it, but this isn't one of them, so it's
really just unnecessary churn.

Thierry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9VkACgkQ3SOs138+
s6GMJg//bvf+OGrw1S50zc7bzLwcnYJplwxuW36Us6ij9LhycYXn6wD2ohn4gqRn
kUQrplDzpuaQb3iMiISayc/XpoWdK13OSb3EFx2VsuWsr6rJAj4rL5USr2xMqiUa
uBulkEYMiajAHue6zdmSSHsrElHPmExS8ZH8OnUFGJ1nBKAaZxY8yN5vfCqbg+mh
MrByM3ZfzGf/9QtGAi9FxkdJ3pNWVMYGRoLYrRi++Zq8HPntmHC4FNKrZcgnPfUx
07Wg2n7Cf8hCokJ9HHCeL4YTdZEbdx0YrnNsa959W8c/WaBcO4nP3PNIl3jK4PbY
xLB5wFBl9093d9oIcBGi2c7EibLCPjZAND0TTdvAEpjMAMCW713o8izEWLbkSwNc
g12nbkPW2yBDcKyWhEKgIdn8EpFR6jLMDYezr/4ytOnQSpGTyU8gcaTrqZvraNAv
9+Cio6TDZQPRZRCnd0g9wcLCAwqwzugSihM6Un5xhNTMiWJmK4z2Mox7KqbLAHSj
Kwos9cIWKS80h1PuclQUvKg8PcEdml5k8ygbUpAfs7rCd7r5gxuBM28IH2WbdqOD
0A1GgT2fobCS9WvqV8Ei9fYk3qR+sSrV0mJZ108DO5F5Tv4shwzqGdQQBw2na/LP
4iEz9LJ3wK6s+R7oXf4NprcCFHSnDiPwKyo/R86MCu06dNGL5Tk=
=vqSk
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
