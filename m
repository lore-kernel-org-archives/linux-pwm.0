From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC v2] pwm: Add Xilinx AXI Timer in PWM mode support
Date: Wed, 12 Dec 2018 11:42:41 +0100
Message-ID: <20181212104241.GA17654@ulmo>
References: <20180322135316.19685-1-alvaro.gamez@hazent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322135316.19685-1-alvaro.gamez@hazent.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 02:53:16PM +0100, Alvaro Gamez Machado wrote:
> This patch adds support for the IP core provided by Xilinx.
> This IP core can function as a two independent timers, but also use both
> counters as values for period and duty cycle of a PWM output.
>=20
> There can be many instances of this IP in a design, but the first one of
> them will be used to generate system's clock. If we were to use this driv=
er
> against the first timer instance found on the DT, we would expose it as a
> PWM controller, and reconfiguring it will break the clock.
>=20
> To avoid this we add an attribute pwm-outputs to this device declaration.
> This new driver will fail to probe when pwm-outputs is different than 1.
>=20
> We could use a boolean, but future versions of this IP core could impleme=
nt
> several PWM and counters, so when (if) this happens, we would only have to
> adjust the pwm-outputs comparison to allow more than one PWM devices.
>=20
> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> ---
>=20
> This is the second proposal on getting AXI Timer PWM capability into Linu=
x.=20
> The other alternative, which was sent un June past year, didn't look for
> pwm-output attribute, so in order not to kidnap control from
> arch/microblaze/kernel/timer.c it used a different compatible string. Tha=
t's
> not wrong per se, but raises the question: can one piece of hardware have
> two compatible strings depending on its intended use, rather than on the
> nature of the hardware itself?
>=20
> If there's interest in mainlining this or the proposal I sent last year, =
I'd
> be grateful to hear from the devicetree maintainers and maybe approve or
> suggest any different aproach.
>=20
> Best regards
>=20
>  drivers/pwm/Kconfig         |   9 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-axi-timer.c | 204 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/pwm/pwm-axi-timer.c

Did any discussion regarding the above-mentioned issues ever ensue? How
do you want to proceed? At the very least we'll need some sort of device
tree binding for this driver, so perhaps start with a DT binding
proposal and take it from there?

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ5h8ACgkQ3SOs138+
s6Eqvw//dWmvMrydYl6c8WeS0Y8XwZY64KX/7cExH8bO6PvV/+WoPzyrIXW4CRDP
oPSIkzrGvg04uoNYs/5lI23t0pxu11cSsG1oqZJcbJymRyv4HzoaXk9eek6OCLff
Z3emfLCGplLrR/vpL9lIvatGUGV35JiQ8FC2KSEPqwRU3TqKxJEWu/WcT5JwCO9f
qI99RS+eef5rzoUiiekePrkQu9U9FXlnLszTyp9bm+vSCHvjWaKfBADPEIkieCXv
+KvqjGgCZq0r88Hjk/14Cp1XGda9hq0olKKYyXFrQUIT7dIULycpp/HehjLr7SrD
CHzOOKNGf4el5KZZNsWQGTqJB0LjgoMne8gEe4+T5P6F5Dh1Q1nL09H+HWUKmB5l
JASjN2cQK/+CC/GCx0wtkt/ESw10ZvQb8Ln3YFGHmNRkO4rYkzWTL6Y3hZ3d9QA3
mU0KidpgJwvxCaEaTf6n7DmEs2VkbZnaMaQOaEndvfcIrPhGpzsUNEqqXKc1JvXd
Pa6DCbdlhN0OiYisPGn3ZmFlOlvLZVBBhYunL1rJWToP4R9vGyIQXo7m/BhZg7aR
F1I8D88eSW4wy3oLA4QPgJJyr8TDE3Z7InSZCEWkAcYZrNxGOHFqeWyhKYpex0+e
uW2VUXRbmSOCAnM+eqZE9GTUSj1siQ/M5v7XdctaoI9Hdu25prA=
=ri20
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
