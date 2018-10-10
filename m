From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Wed, 10 Oct 2018 15:49:26 +0200
Message-ID: <20181010134926.GD21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>
Cc: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org
List-Id: linux-pwm@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>=20
> DT documentation for PWM controller added with updated compatible
> string.
>=20
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 ++++++++++++++++=
++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 00000000..532b10fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,32 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently o=
nly
> +supports one period for all channels in the PWM. This is set globally in=
 DTS.
> +The period also has significant restrictions on the values it can achiev=
e,
> +which the driver rounds to the nearest achievable frequency.

What restrictions are these? If "nearest achievable" is too far off the
target period it might be preferable to error out.

> +Required properties:
> +- compatible: should be one of
> +	"sifive,fu540-c000-pwm0","sifive,pwm0".

What's the '0' in here? A version number?

> +	PWM controller is HiFive Unleashed specific chip which warrants a
> +	specific compatible string. The second string is kept for backward
> +	compatibility until a firmware update with latest compatible string.
> +- reg: physical base address and length of the controller's registers
> +- clocks: The frequency the controller runs at
> +- #pwm-cells: Should be 2.
> +  The first cell is the PWM channel number
> +  The second cell is the PWM polarity
> +- sifive,approx-period: the driver will get as close to this period as i=
t can

Given the above comment, maybe "sifive,period"?

Thierry

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+A2YACgkQ3SOs138+
s6EnhBAAisb2txXuWgUYVwXrt00c7mGjqT9MoPa2RqflyVyREJUhfkZ6cx6C3s6N
ofs5/qGuivoKkknjcTwM8eRoPCvQU29wvA6qBwBwXi8ZHNqconlKZ/kWukNMbzJw
Lg4IT0JKjgHdOzqzLCB/OcD6O8vw18ZmfpVgzBIa/cbmOm140nO4HJcWSfr7QYNt
J32OBqTzOv1ATNjiSL6R+SFkoFTeedrwBDyjWK07P02kEnxJFLC8HGukTz9Kp7dr
75N658I5yoQ/DNvlDfamGAqMGVP0+zRmxz85zWC0XrZtIAlXRlMvaADQiRbF82qy
i2HLlFRV+qg5H/MgVF8aSHPgYX/EER2NFlbfrnSeDDRFS/83sWFPsQRzkbjqOBzI
UXODeUTaU1wz1dFnC800JDwnWCp0hVNwQyasYTv6eNU/YV673tiTTP6jBC/WwSUW
8LZn30e1lKznFwd1LMusco4sZ6NLxIwpgAnXEx4Sg9PSsUSalK3ev+/CXFVQSX/4
xLEkYzr5y+4i4Sg6ncfJBYuO19w1iys97pUbgjKshu1OWNh311pMtUh4gU4o+3FE
Q7u3Jxqa59HNjjWgNxhc89LO0StDrjmpF2wlPnQuuBkkPR8pDFW4cmyFZBNc2bLO
uQVgULnz+3vIy6TvzbegBSzyIHwibIWbVdafoNVnULilsRWKHNE=
=NGVA
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
