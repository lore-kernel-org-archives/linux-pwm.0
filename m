Return-Path: <thierry.reding@gmail.com>
Date: Thu, 19 Sep 2013 14:28:08 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] PWM: PXA: add device tree support to PWM driver
Message-ID: <20130919122807.GH10852@ulmo>
References: <1379519982-7618-1-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Content-Disposition: inline
In-Reply-To: <1379519982-7618-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2013 at 08:59:42AM -0700, Mike Dunn wrote:
[...]
> Only an OF match table is added;
[...]

That's no longer true. You also add a custom .of_xlate() function.

> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Document=
ation/devicetree/bindings/pwm/pxa-pwm.txt
[...]
> +Required properties:
> +- compatible: should be one or more of:
> +  - "marvell,pxa250-pwm"
> +  - "marvell,pxa270-pwm"
> +  - "marvell,pxa168-pwm"
> +  - "marvell,pxa910-pwm"
> +- reg: physical base address and length of the registers used by the PWM=
 channel
> +  NB: One device instance must be created for each PWM that is used, so =
the

Nit: "NB:" looks like it starts a new property. Perhaps something like:

	"Note that one device node must be present for each PWM ..."

would be less confusing to the eye.

> +  length covers only the register window for one PWM output, not that of=
 the
> +  entire PWM controller.  Currently length is 0x10 for all supported dev=
ices.

So that again confuses me. If the controller really is one or two PWM
channels, and four PWM channels, as given in the pxa27x.dtsi, are in
fact two controllers (not four) then I wonder if this really is the
correct binding for it.

That said, Stephen seems to be okay with it, and I'll yield to his
authority on the matter.

> +- #pwm-cells: should be 1.  This cell is used to specify the period in

Nit: "Should be 1." It's a sentence and therefore should start with a
capital letter.

> +  nanoseconds.  (Because one device instance is created for each PWM out=
put,
> +  the per-chip index is superflous and not used.)

I'd omit the parentheses (and their content). The description of the
cell is plenty specific about what it should contain. No need to list
what it shouldn't contain.

> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi

I think this belongs in a separate patch so it can go through the
arm-soc tree.

> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
[...]
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
> +
> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device =
*dev)
> +{
> +	const struct of_device_id *id =3D of_match_device(pwm_of_match, dev);
> +	if (id)
> +		return (const struct platform_device_id *)id->data;

Is that cast really necessary? id->data is const void *, so shouldn't
need a cast.

> +	else
> +		return NULL;

Perhaps "return id ? id->data : NULL;"?

> +struct pwm_device *
> +pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)

Should be static.

> +{
> +	struct pwm_device *pwm;
> +

You probably want to check that pc->of_pwm_n_cells at least 1 here.

> +	pwm =3D pwm_request_from_chip(pc, 0, NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm_set_period(pwm, args->args[0]);
> +
> +	return pwm;
> +}
> +
> +#else  /* !CONFIG_OF */
> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device =
*dev)
> +{
> +	dev_err(dev, "missing platform data\n");
> +	return NULL;
> +}
> +
> +struct pwm_device *
> +pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> +{
> +	return NULL;
> +}
> +#endif

I prefer not to have these dummy implementations for static functions.
See below...

>  static int pwm_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> @@ -131,6 +185,11 @@ static int pwm_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	int ret =3D 0;
> =20
> +	if (id =3D=3D NULL)		/* using device tree */
> +		id =3D pxa_pwm_get_id_dt(&pdev->dev);

This could be replaced with:

	if (IS_ENABLED(CONFIG_OF) && id =3D=3D NULL)
		id =3D pxa_pwm_get_id_dt(&pdev->dev);

And pxa_pwm_get_id_dt() can be unconditionally defined. The compiler
will automatically remove it for !OF because it is never used. Also the
comment can then be dropped since the code is already explicit.

>  	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>  	if (pwm =3D=3D NULL) {
>  		dev_err(&pdev->dev, "failed to allocate memory\n");
> @@ -145,6 +204,8 @@ static int pwm_probe(struct platform_device *pdev)
>  	pwm->chip.ops =3D &pxa_pwm_ops;
>  	pwm->chip.base =3D -1;
>  	pwm->chip.npwm =3D (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
> +	pwm->chip.of_xlate =3D pxa_pwm_of_xlate;
> +	pwm->chip.of_pwm_n_cells =3D 1;

Similarly if you write this as:

	if (IS_ENABLED(CONFIG_OF)) {
		pwm->chip.of_xlate =3D pxa_pwm_of_xlate;
		pwm->chip.of_pwm_n_cells =3D 1;
	}

Then the only thing that needs #ifdef CONFIG_OF protection will be the
OF match table.

Thierry

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOu3WAAoJEN0jrNd/PrOhFhUP/iyDu3G7+0eVXc2eTbZG7rd6
Yl0LbXO0+suzdqRxLXXz8LLVi7p+jUzvDQktw4tEGZmNAwARYCr/3/HvMfvcekKm
y+v/Nam4Bh3huKY67pyN/QR8hU18fz77r4dVnilURchjyyKqHqE5R046a7DmBHVT
QLhMmKw8N9L4NFjNEUYXjAygRCeOYdaLLpoFb+i8paxcKa7q6ZV5W3MNzkz2BOlQ
vf+ZUW+WvdPkxzqUiY2wx8K3lxtlxBzUdgpNUo/81oFrlZG9j87zbSMFrPg7B45f
liSPipVe24lBleHctY50nZw6yKurJArD0VrOQODscDV+CzawRxnE9iM8LuoAUmtj
8iJgkFs1+uUWwmjQLxvtAVPDbCB9hTijHuGYFcYJaBSJVvMW7pOcjB6l++y84PxR
HxhOOsbmCvdnK/HLpXSDI96xsSWoqJ5M3f7dStK/i61zjeQVmbtTcZG7U9BcZ3/v
iRVfpVhgZK9gsDjvR8XeGbfanfyXGRSCGTykAMQbTxvxNfwSIYyyxzHdfy6FJ9jm
5eBkTefJwFf/dZxBxaGHIql3Dh96Qy6aiHlErSk1kz9yG7NCNIGyNOKRoTM0UHRC
mYpRbbrCx57qnSUCiWVT0udpHrDYalGA8CUhEHWDxEUr4TYWJOeiWSYUOkhSeSqH
FFHUW2GOBac+TJAiatKF
=3WWy
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
