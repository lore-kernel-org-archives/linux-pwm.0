Date: Mon, 9 Sep 2013 14:08:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: pxa: add device tree support to pwm driver
Message-ID: <20130909120845.GB22197@ulmo>
References: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2013 at 12:40:18PM -0700, Mike Dunn wrote:
> This patch adds device tree support to the pxa's pwm driver.  Only an OF =
match

"PXA" and "PWM"

> table is added; nothing needs to be extracted from the device tree node. =
 The
> existing platform_device id table is reused for the match table data.  Su=
pport

"ID table"

> Changle log:
> v2:
> - of_match_table contains only the "pxa250-pwm" compatible string; requir=
e one
>   device instance per pwm
> - add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> - add support for polarity flag in DT and implement set_polarity() method
>   (the treo 680 inverts the signal between pwm out and backlight)
> - return -EINVAL instead of -ENODEV if platform data or DT node not found
> - output dev_info string if platform data missing
> - expanded CC list of patch

I think this needs to be reviewed by the device tree bindings
maintainers (as listed in MAINTAINERS) as well. Would you mind resending
the patch with all of them on Cc so that they have full context? Thanks.

>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 33 +++++++++++++
>  arch/arm/boot/dts/pxa27x.dtsi                     | 24 ++++++++++
>  drivers/pwm/pwm-pxa.c                             | 57 +++++++++++++++++=
++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Document=
ation/devicetree/bindings/pwm/pxa-pwm.txt
> new file mode 100644
> index 0000000..7b09bfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -0,0 +1,33 @@
> +Marvell pwm controller
> +
> +Required properties:
> +- compatible:
> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible =3D "marvell,px=
a250-pwm";
> +- reg: physical base address and length of the registers used by the pwm=
 channel

"pwm" -> "PWM". There are a few more occurrences that I haven't
explicitly pointed out.

> +  NB: One device instance must be created for each pwm that is used, so =
the
> +  length covers only the register window for one pwm output, not that of=
 the
> +  entire pwm controller.  Currently length is 0x10 for all supported dev=
ices.

I'm not sure I like that very much. It seems a wrong representation of
the hardware for the sake of modifying a smaller number of lines in the
driver.

> +- #pwm-cells: should be 3.
> +   cell 1: the per-chip index of the PWM to use,
> +   cell 2: the period in nanoseconds,
> +   cell 3: flags; set bit 0 to specify inverse polarity.  The pwm contro=
ller

This is the standard binding, so you can just refer to the standard
binding documentation instead, like so:

	- #pwm-cells: Should be 2. See pwm.txt in this directory for a description=
 of
	  the cells format.

> +   does not implement reverse polarity, but some boards may pass the pwm=
 output
> +   through an external inverter, which can cause problems if a client de=
vice
> +   assumes that an increase in the duty cycle results in an increase in =
output
> +   power.  The pwm-backlight is an example of such a client.

Please don't do that. Reverse polarity support should not be emulated.
Either the hardware supports it or it doesn't. In the above case you
should be able to achieve the same effect by adding the correct values
in the pwm-backlight device node's brightness-levels property.

> +Example pwm client node:
> +
> +backlight {
> +      	compatible =3D "pwm-backlight";
> +     	pwms =3D <&pwm0 0 5000000 1>;  /* pwm output is inverted */
> +	...

The indentation here is funky. You should be using only tabs to indent.

> +#ifdef CONFIG_OF
> +/*
> + * Device tree users should create one device instance for each pwm chan=
nel.
> + * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original =
driver
> + * code that this is a single channel pxa25x-pwm.
> + */
> +static struct of_device_id pwm_of_match[] =3D {
> +	{ .compatible =3D "marvell,pxa250-pwm", .data =3D &pwm_id_table[0]},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_of_match);
> +
> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device =
*dev)
> +{
> +	const struct of_device_id *pwm_pxa_devid =3D
> +		of_match_device(pwm_of_match, dev);

If you name this variable something much shorter, like "id", this will
fit on a single line, and the code below will be slightly more readable
as well.

> +	if (pwm_pxa_devid)
> +		return (const struct platform_device_id *)pwm_pxa_devid->data;
> +	else
> +		return NULL;
> +}

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLbpNAAoJEN0jrNd/PrOhQEgP/i1u1XgzgvxrWl9Zj9Msej+f
ZbvrxHg+S8XwmrY7eT83yLCJAqsdwPtrRFQv+kUNhCDBul1jj7ZZDqDOFZ0l/oZ7
1wl1TFVCqr9RXE9TgkL9HduXBsRGZTcHdry2TcWsG6EUcV713OcY2iVuMkM3VHP+
KPDKwTeKjwnB6ejGnHb6g/vXFZPCS7nxRVS/owwuyvLjArmsZuKNX99tmeU2Rwg/
pEZU7jHYTpDLhnjYulmYRpD38WZeT72pfQXLRftqiWXDpkdtV1ttTAe2OM/ViVQW
0nlza1u8k3UM9Zf8JedfD+FZIbrgFzBIyiHAKlKIZwbCbn+giTmwQW3VcYJUrmgj
hsSbna9RkAaxexyzi/kVrss2u5JEJenpJLSgEx2g5QJr0kFI/RNFU2Am2oe3SAFI
ChhycwuQDe34+KFUHbTtTpFPTW2wQmvz1e+TbeokC5OQ63IU6W/eUhG/lbQaF0kb
RWOTjxU7GJxqVw2njOKpmgkDai06OqVralU2dzaD/VnsCuCZAi+5ssqAwYspyOuN
gzTaNzoF10rFNI485ZMUM1bUDLb31mkNeu0CIw5d2Y16Spku1aa5MEnjha7iIKRP
4S3wizmlHfeRKYvdmIIM+/HzHlsKStEjb9FwoMYlu2O9JtAbv+u9hMuZKaqXHuFN
9xRpTSK8S6hRRi6h+vQd
=sB8n
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
