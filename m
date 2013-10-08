Date: Tue, 8 Oct 2013 15:12:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Message-ID: <20131008131214.GA12839@ulmo.nvidia.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
 <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mike Dunn <mikedunn@newsguy.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
> This patch adds device tree support to the PXA's PWM driver.  Nothing
> needs to be extracted from the device tree node by the PWM device.
> Client devices need only specify the period; the per-chip index is
> implicitly zero because one device node must be present for each PWM
> output in use.  This approach is more convenient due to the wide
> variability in the number of PWM channels present across the various PXA
> variants, and is made possible by the fact that the register sets for
> each PWM channel are segregated from each other.  An of_xlate() method
> is added to parse this single-cell node.  The existing ID table is
> reused for the match table data.
>=20
> Tested on a Palm Treo 680 (both platform data and DT cases).
>=20
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
>  drivers/pwm/pwm-pxa.c                             | 52 +++++++++++++++++=
+++++-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt

This looks good to me, but I'd like to get an Acked-by: from one of the
device tree bindings maintainers.

Thierry

>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Document=
ation/devicetree/bindings/pwm/pxa-pwm.txt
> new file mode 100644
> index 0000000..5ae9f1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -0,0 +1,30 @@
> +Marvell PWM controller
> +
> +Required properties:
> +- compatible: should be one or more of:
> +  - "marvell,pxa250-pwm"
> +  - "marvell,pxa270-pwm"
> +  - "marvell,pxa168-pwm"
> +  - "marvell,pxa910-pwm"
> +- reg: Physical base address and length of the registers used by the PWM=
 channel
> +  Note that one device instance must be created for each PWM that is use=
d, so the
> +  length covers only the register window for one PWM output, not that of=
 the
> +  entire PWM controller.  Currently length is 0x10 for all supported dev=
ices.
> +- #pwm-cells: Should be 1.  This cell is used to specify the period in
> +  nanoseconds.
> +
> +Example PWM device node:
> +
> +pwm0: pwm@40b00000 {
> +	compatible =3D "marvell,pxa250-pwm";
> +	reg =3D <0x40b00000 0x10>;
> +	#pwm-cells =3D <1>;
> +};
> +
> +Example PWM client node:
> +
> +backlight {
> +	compatible =3D "pwm-backlight";
> +	pwms =3D <&pwm0 5000000>;
> +	...
> +}
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index a4d2164..e928cc8 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
> +#include <linux/of_device.h>
> =20
>  #include <asm/div64.h>
> =20
> @@ -124,6 +125,45 @@ static struct pwm_ops pxa_pwm_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +#ifdef CONFIG_OF
> +/*
> + * Device tree users must create one device instance for each pwm channe=
l.
> + * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original =
driver
> + * code that this is a single channel pxa25x-pwm.  Currently all devices=
 are
> + * supported identically.
> + */
> +static struct of_device_id pwm_of_match[] =3D {
> +	{ .compatible =3D "marvell,pxa250-pwm", .data =3D &pwm_id_table[0]},
> +	{ .compatible =3D "marvell,pxa270-pwm", .data =3D &pwm_id_table[0]},
> +	{ .compatible =3D "marvell,pxa168-pwm", .data =3D &pwm_id_table[0]},
> +	{ .compatible =3D "marvell,pxa910-pwm", .data =3D &pwm_id_table[0]},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_of_match);
> +#else
> +static struct of_device_id *pwm_of_match;
> +#endif
> +
> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device =
*dev)
> +{
> +	const struct of_device_id *id =3D of_match_device(pwm_of_match, dev);
> +	return id ? id->data : NULL;
> +}
> +
> +static struct pwm_device *
> +pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> +{
> +	struct pwm_device *pwm;
> +
> +	pwm =3D pwm_request_from_chip(pc, 0, NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm_set_period(pwm, args->args[0]);
> +
> +	return pwm;
> +}
> +
>  static int pwm_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> @@ -131,6 +171,12 @@ static int pwm_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	int ret =3D 0;
> =20
> +	if (IS_ENABLED(CONFIG_OF) && id =3D=3D NULL)
> +		id =3D pxa_pwm_get_id_dt(&pdev->dev);
> +
> +	if (id =3D=3D NULL)
> +		return -EINVAL;
> +
>  	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>  	if (pwm =3D=3D NULL) {
>  		dev_err(&pdev->dev, "failed to allocate memory\n");
> @@ -145,7 +191,10 @@ static int pwm_probe(struct platform_device *pdev)
>  	pwm->chip.ops =3D &pxa_pwm_ops;
>  	pwm->chip.base =3D -1;
>  	pwm->chip.npwm =3D (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
> -
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		pwm->chip.of_xlate =3D pxa_pwm_of_xlate;
> +		pwm->chip.of_pwm_n_cells =3D 1;
> +	}
>  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pwm->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(pwm->mmio_base))
> @@ -176,6 +225,7 @@ static struct platform_driver pwm_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "pxa25x-pwm",
>  		.owner	=3D THIS_MODULE,
> +		.of_match_table	=3D of_match_ptr(pwm_of_match),
>  	},
>  	.probe		=3D pwm_probe,
>  	.remove		=3D pwm_remove,
> --=20
> 1.8.1.5
>=20

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVASuAAoJEN0jrNd/PrOhPkoP/0w8bW6w7KuSRaaWYyk4Bd66
2sh0gC1AQOr6nDnPlHesCQEHAalwIionWJvutwD8LSpm5BdMPPIlfHu1hggM5Ua6
nCLieJi/srGjcpV9xQx8Vx3q9Kc54PtSZ9lZMCwWb1Em47dSOkrlXNs3AILZj23i
fJrwClmLNrr6D1mbJhj0m9fnjan1weI5iIGMSZATHk0qjk6oS72RdS8S1DUWXzO7
1B9psO3MKBGjSmgKeUYwUB5WeBFLsGesNw3VB5o1QmyU7ybFJX6tT1FIfr/svKVx
Vp/4JnRagsCiDbXEzAUl+p0LgPhKbOPiosQxhimh3+QbVWzLTcw2ngwTx/GKwxi2
482GqSxW0+ByaM0bxdm8+45/tFBj5zu2iwly5cqGkcg9ncC5qADsuejIYu+tDNWC
W/qhYm2Dup+3ZMgkzIrFxQCT0vMWwSrRVik/ljL9wbgKSTVSv4Dc76zxtcBfgd1S
aPCi0b+JQ7g+ndmXTGec0T43hd+S2G0oeS4DuU5qnGu0tGvckUa1ta4NKe+Gjqir
yaniZtCNPYy1gU1ZlzaChws0xSVighzkjBLFM/gnL/9ym59oZWbcApPim6VyrUx4
V1wbR4m9tEIgHv7B7zXyV/gPXUmQRiDCxgCNwwCdKXUZtyUjN5pLzPLZwWiqi/S0
g76O+KW86Scb50CX75qU
=YL/a
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
