From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMS8yXSBk?= =?utf-8?Q?t-bindings?=
 =?utf-8?Q?=3A?= pwm: imx: Allow switching PWM output between PWM and GPIO
Date: Wed, 10 Oct 2018 15:39:04 +0200
Message-ID: <20181010133904.GB21134@ulmo>
References: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
 <1539163920-9442-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539163920-9442-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 09:33:25AM +0000, Vok=C3=A1=C4=8D Michal wrote:
> Output of the PWM block on i.MX SoCs is always low when the block is
> disabled. This can cause issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle =3D 0% corresponds to high level on
> the output. Now, when PWM is disabled its output instantly goes low
> which corresponds to duty cycle =3D 100%.
>=20
> To get a truly inverted PWM output two pinctrl states of the PWM pin
> can be used. Configure the pin to GPIO function when PWM is disabled
> and switch back to PWM function whenever non-zero duty cycle is needed.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
> Changes in v2:
>  - Do not use the "default" pinctrl state for GPIO.
>  - Use two new "pwm" and "gpio" pinctrl states.
>  - Add a new pwm-gpios signal.
>=20
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 51 +++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Document=
ation/devicetree/bindings/pwm/imx-pwm.txt
> index c61bdf8..bd5b6bd 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> @@ -14,6 +14,17 @@ See the clock consumer binding,
>  	Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - interrupts: The interrupt for the pwm controller
> =20
> +Optional properties:
> +- pinctrl: For i.MX27 and newer SoCs. Use "pwm" and "gpio" specific pinc=
trls
> +  instead of the "default" to configure the PWM pin to GPIO and PWM func=
tion.
> +  It allows control over the pin output level when the PWM block is disa=
bled.
> +  This is useful if you use the PWM for single purpose and you need inve=
rted
> +  polarity of the PWM signal. See "Inverted PWM output" section bellow.
> +- pwm-gpios: Specify the GPIO pin that will act as the PWM output. This =
should
> +  be the same pin as is used for normal PWM output. Define the pin as
> +  GPIO_ACTIVE_LOW to get HIGH level on the output when PWM is disabled. =
See
> +  "Inverted PWM output" section bellow.

It's somewhat unfortunate that we have to specify this in DT. For one
thing, we don't really want to use the pin as GPIO, we really only care
about whether it is "active" or "inactive". We also already specify the
GPIO in the pinctrl nodes, albeit via a different name. So we're
effectively duplicating information here. It'd be nice to avoid that.
Two possibilities that I could think about are:

  1) Do not explicitly rely on driving the GPIO as output: I know this
     was discussed before and it sounds like this is not an option for
     PWM because the GPIO may be configured as output by the firmware,
     and hence switching to GPIO mode may not give the expected result.
     I suppose one way to solve this is by using a gpio-hog entry for
     the PWM GPIO so that it will automatically get configured as an
     input and at the same time marked as busy so that nobody can go
     and just request it again (via sysfs for example).

  2) Derive the GPIO from the pin. I'm not sure there's anything in the
     pinctrl framework to do that. The reverse (GPIO -> pin) can be
     done, so perhaps this is something that could be added?

Other than than I think this looks very nice.

Thierry

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+APUACgkQ3SOs138+
s6EoNQ//b8Idg4Gu+BVzZ4N8DTwLjGuEjDEO8Fl0SuBTP7/X76NINQMC4/jXU9fL
ak1Bjn9XGktnVN1oulK96RYfmwKIKMfqFaZVyWk1oHdvNzd4C2l9pT4hJLrE1/Ia
Io1eGPdDtu+C9uWtcaVA0LVpzLys1N0HUgbknaCmhvn0DvPeCtX5TXLegc33S/Yr
rhCoUUvWoOmBa+rrDrVB7Kx1ZwhK/QT6P7CsYapBw8Ik0vd4mEscJBcDEzie3tCO
D7xh+DRKLzUit2vgquqYDgi0vfKhdB6uxM0nMo1GakeO80tsLLriI7RrSMGeEKJa
LR8gC7+FjKD2FDFjGJuD7HP+azq/MoXavKATWzkEpgnmeV8NUwB39/kwZf4T3VQk
Buo9a4M/PH6G/y8ut47DjiVSUJZwOher/tE0tn+SKPzTlO0TIM7yszphAENFG0YA
UhK2UU5bBe7XgJXFphivR927XeP4p4Gy/DLYR37XEutl+MdBzlL8Qn21etYr8MmV
t5JUAikieX9Osnxjn2if5Ql6cvA9uQraNj8QlUkQE65miJDOwFBpUGIdJe/jN1wi
UizZIp260e+8Bprv7q1wBbqaStNoUXvEHwcjtYCocZolfLeRx89BcyrMRLSj7nfF
Iwmvo9EPTQXU7hFFFOmC+OImPTgS3Ka98hKyjr6ulT4ldkwLWKM=
=jFoK
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
