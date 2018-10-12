From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
Date: Fri, 12 Oct 2018 14:15:52 +0200
Message-ID: <20181012121552.GE31561@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: shc_work@mail.ru, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 04:01:25PM +0300, Claudiu Beznea wrote:
> Add documentation for PWM push-pull mode.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
>  Documentation/pwm.txt                         | 16 ++++++++++++++++
>  include/dt-bindings/pwm/pwm.h                 |  1 +
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentatio=
n/devicetree/bindings/pwm/pwm.txt
> index 7c8aaac43f92..6a60c0fca112 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of fl=
ags (defined in
>  - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channe=
ls
>  with two outputs); if not specified, the default for PWM channel will be
>  used
> +- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
> +two outputs); if not specified the default for PWM channel will be used

What if somebody has this in the DT:

	PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL

which one takes precedence, or do we reject it?

Wouldn't it be preferable to either move the modes into an extra field
within the flags field, or perhaps even add another field?

I guess since Rob's already acked this, that concern may be unfounded.

Thierry

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAkHUACgkQ3SOs138+
s6GvYA//VhYSRVNBzW3PbPthk9TMJ5k2nfLZjUjH7vwAEhSSE9MAEdP+M/ScAfpE
b++6J3rnvfzUciUZRJtlHRC6AO7GyV2/oiju6Qlfn3Sg+mg5B+e2TH1eTRZuy25a
8iUBaCGO4awJbTNFiYwO7NtgWRcdCvQijcvt1VM2iPI38t4a8GCPVSqbFmpu5y3B
NvCP1oEyRxa91JDgIUaLgewiYf9Bmeld6hNVhEUx8IlA3WTX1zoj+Jnpdbnwps8l
BHl6TuMdUWHzWPy31YVZp5US/1nuuIaFc0byl8UHzZ30TNdVOTxmHKzwUo2b5XPq
GyDqZHuy0e8GacggIDY6YTOG4sgd15HBp8pFlNZwYm8rJaJzRDYWBWdMFlwaqxzx
N6y42buFEaXUbOuXZFH675HylfhL8FCdiO/xfSAHsPWt032wfFrYoVBcIyNyRAAQ
Dj8o8gMKXGJtmeNK/CKrFFuO7ZqfvhSPa6we2iCQdxvM78XRutmpsxu4sr06FT6B
HnOIq1Lm7cqQqc4rZ9fQkWrj7FTDHr0zjGZUqIClune7X6gRi00wXZV+8MaSjbpl
ghDRISv3+5V7Bz4AXREQxZNL2xpLxiNFAfuhGIuSj+T4i4aqc1AvNDzwoXy9vSxS
8NVtXk20MV4CxF14GkSITHo1y8d6sDUDbo2xhINzWcbMxAFiBM4=
=Vkfu
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
