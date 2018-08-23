From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Date: Thu, 23 Aug 2018 12:40:13 +0200
Message-ID: <20180823123759.68b78e9f@jawa>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SsAnwfOlOr+S3rQE6dj.GB/"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

--Sig_/SsAnwfOlOr+S3rQE6dj.GB/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michal,

> Output of the PWM block of i.MX SoCs is always zero volts when the
> block is disabled. This can caue issues when inverted PWM polarity is
> needed. With inverted polarity a duty cycle =3D 0% corresponds to solid
> high level on the output. If the PWM is dissabled its output
> instantly goes to solid zero which corresponds to duty cycle =3D 100%.
>=20
> To have a trully inverted PWM output configure the PWM pad as a GPIO
> with pull-up. Then switch the pad to PWM output whenever non-zero
> duty cycle is needed.

Just to ask - Is your display equipped with power supply enable/disable
pin?

As fair as I remember the trick to avoid flickering the display
was to disable the display (enable-gpio property) and set the PWM PIN
as GPIO to high in u-boot.

>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44
> +++++++++++++++++++++++ 1 file changed, 44 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
> c61bdf8..3b1bc4c 100644 ---
> a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -14,6 +14,12
> @@ See the clock consumer binding,
> Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - interrupts: The interrupt for the pwm controller
> =20
> +Optional properties:
> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure
> the PWM
> +  pin to gpio function.  It allows control over the pin output level
> when the
> +  PWM block is disabled. This is meant to be used if inverted
> polarity of the
> +  PWM signal is required. See "Inverted PWM output" section bellow.
> +
>  Example:
> =20
>  pwm1: pwm@53fb4000 {
> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>  	clock-names =3D "ipg", "per";
>  	interrupts =3D <61>;
>  };
> +
> +Inverted PWM output
> +-------------------
> +
> +The i.MX=C2=A0SoC has such limitation that whenever a pad is configured
> as a PWM +output, the output level is always zero volts when the PWM
> block is disabled. +The zero output level is actively driven by the
> output stage of the PWM block +and can not be overridden by pull-up.
> It also does not matter what PWM polarity +a PWM client (e.g.
> backlight) requested. +
> +To gain control of the PWM output level in disabled state two
> pinctrl states +can be used. The "default" state and the "pwm" state.
> In the default state the +PWM output is configured as a GPIO with
> pull-up. In the "pwm" state the output +is configured as a PWM
> output. This setup assures that the PWM output is at +the required
> level that corresponds to duty cycle =3D 0 when PWM is disabled. +E.g.
> at boot. +
> +Example:
> +
> +&pwm1 {
> +	pinctrl-names =3D "default", "pwm";
> +	pinctrl-0 =3D <&pinctrl_backlight_gpio>;
> +	pinctrl-1 =3D <&pinctrl_backlight_pwm>;
> +}
> +
> +pinctrl_backlight_gpio: pwm1grp-gpio {
> +	fsl,pins =3D <
> +		/* GPIO with 22kOhm pull-up */
> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
> +	>;
> +};
> +
> +pinctrl_backlight_pwm: pwm1grp-pwm {
> +	fsl,pins =3D <
> +		/* PWM output */
> +		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
> +	>;
> +};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/SsAnwfOlOr+S3rQE6dj.GB/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlt+jw0ACgkQAR8vZIA0
zr3mEAf/REK+lHwHbo/LSJwTaFQuKnHAyWohjN8rW3U6OrVB+3G1nIVpLWUc6EGd
cOFMSUr01+iEFfmQiuFgpfhukEVu9GvApG1+HXw9vrynqDV9+Ty9LgKAFTmABSKU
q6opYlmy3nNgN6ukFxKVKsUZNmAb+hK4XrLp9wXcBnJ1eC5xnLl96Kv4ovmCQD/h
TM+XqoiD5GmRxZqUbo7Wxuu30oAXMNOB8/pNRhMqy6Zw9p+cKZZyvwy9kuyMolpy
ejx+8+FXjlbdapLemjFfxUTGXQyEpT/0Xb0JOZBvUBgBmeZeLUjd6bFuoSAis+9C
DvVybQ0OFfp1kpLDaG/4Ob/ah/kjbw==
=qAdX
-----END PGP SIGNATURE-----

--Sig_/SsAnwfOlOr+S3rQE6dj.GB/--
