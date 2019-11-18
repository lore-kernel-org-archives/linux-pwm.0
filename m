From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Date: Mon, 18 Nov 2019 12:06:40 +0100
Message-ID: <20191118110640.GE4345@gilmour.lan>
References: <20191118110034.19444-1-peron.clem@gmail.com>
 <20191118110034.19444-2-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YE4mVuFar47/lB0E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191118110034.19444-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Jernej Skrabec <jernej.skrabec@siol.net>, Rob Herring <robh@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--YE4mVuFar47/lB0E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
>
> Expand Allwinner PWM binding with H6 PWM specifics.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 0ac52f83a58c..1bae446febbb 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -30,13 +30,51 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
> +      - const: allwinner,sun50i-h6-pwm
>
>    reg:
>      maxItems: 1
>
>    clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Module Clock
> +      - description: Bus Clock
> +
> +  # Even though it only applies to subschemas under the conditionals,
> +  # not listing them here will trigger a warning because of the
> +  # additionalsProperties set to false.
> +  clock-names: true
> +
> +  resets:
>      maxItems: 1
>
> +  if:
> +    properties:
> +      compatible:
> +        contains:
> +          const: allwinner,sun50i-h6-pwm
> +
> +  then:
> +    properties:
> +      clocks:
> +        maxItems: 2
> +
> +      clock-names:
> +        items:
> +          - const: mod
> +          - const: bus
> +
> +    required:
> +      - clock-names
> +      - resets
> +
> +  else:
> +    properties:
> +      clocks:
> +        maxItems: 1
> +

Sorry for not noticing this earlier, but this should be at the topmost
level

Maxime

--YE4mVuFar47/lB0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdJ7QAAKCRDj7w1vZxhR
xUZpAQDf57xL+KiMJD5aQ0XQT0XHFOYAwW8cCUu/FgXYpgJmjwEAqJZh4AHN3JSQ
09PXO0+LTVk76RQKjiW46/vLtI+iIgo=
=u4lN
-----END PGP SIGNATURE-----

--YE4mVuFar47/lB0E--
