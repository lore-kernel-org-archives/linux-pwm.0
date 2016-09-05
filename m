From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 12/17] pwm: sti: Initialise PWM Capture device data
Date: Mon, 5 Sep 2016 12:50:11 +0200
Message-ID: <20160905105011.GL31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-13-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-13-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:03AM +0100, Lee Jones wrote:
> Each PWM Capture device is allocated a structure to hold its own
> state.  During a capture the device may be partaking in one of 3
> phases.  Initial (rising) phase change, a subsequent (falling)
> phase change indicating end of the duty-cycle phase and finally
> a final (rising) phase change indicating the end of the period.
> The timer value snapshot each event is held in a variable of the
> same name, and the phase number (0, 1, 2) is contained in the
> index variable.  Other device specific information, such as GPIO
> pin, the IRQ wait queue and locking is also contained in the
> structure.  This patch initialises this structure for each of
> the available devices.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)

Applied this with two small changes. See below.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> +struct sti_cpt_ddata {
> +	u32 snapshot[3];
> +	int index;

I made this unsigned int because it never needs to be negative.

> @@ -350,6 +366,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	struct sti_pwm_compat_data *cdata;
>  	struct sti_pwm_chip *pc;
>  	struct resource *res;
> +	unsigned int devnum;

Renamed this variable to "i" because it's...

>  	int ret;
> =20
>  	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> @@ -378,7 +395,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	cdata->reg_fields   =3D &sti_pwm_regfields[0];
>  	cdata->max_prescale =3D 0xff;
>  	cdata->max_pwm_cnt  =3D 255;
> -	cdata->num_devs     =3D 1;
> +	cdata->pwm_num_devs =3D 1;
> +	cdata->cpt_num_devs =3D 0;
> =20
>  	pc->cdata =3D cdata;
>  	pc->dev =3D dev;
> @@ -416,7 +434,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	pc->chip.dev =3D dev;
>  	pc->chip.ops =3D &sti_pwm_ops;
>  	pc->chip.base =3D -1;
> -	pc->chip.npwm =3D pc->cdata->num_devs;
> +	pc->chip.npwm =3D pc->cdata->pwm_num_devs;
>  	pc->chip.can_sleep =3D true;
> =20
>  	ret =3D pwmchip_add(&pc->chip);
> @@ -426,6 +444,19 @@ static int sti_pwm_probe(struct platform_device *pde=
v)
>  		return ret;
>  	}
> =20
> +	for (devnum =3D 0; devnum < cdata->cpt_num_devs; devnum++) {

=2E.. usage here becomes more idiomatic.

Thierry

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzU3jAAoJEN0jrNd/PrOhSUMQAJ1QvuLDp7MuwIlk0t9tHa3X
kLGklBhgSkZLakS30zf266MRAqi0t8tKaDxqcA2y236WBZ2/EU5C9HQae9K/6Hy7
I9S6pbxAh8ExTmocP6/GEgAuxGhpxRJiCQdyiN3bCl2OMfi/3jJnGijBLupNhwvV
xycCIGgv4gMBlVgvwMMknyGCXPsoPZEQOw6jEYK5WKFrN/1E/QJ7sBMqozVQ7WsL
uq5JHeC/UU5wvvvIcFzP9AYVxcF7tQe/cUNWGRLK8Ui4qe+KQv5G5GPtD61KNw8k
KQjo33gYt6XPoNrcDCZ9x6jiwhHlxu5qs/FgG19wFSL+ddVzXtW0QlRqlaIeyfmP
b4nZ/Z2iu7jRSJ3zg88bHnoGN1QCNLCR/b+aW4A6hV0JQJy1HpE6eaqe12P7Wjca
I836ov2B0BGV9NlKa2pW6VeZRm1hiq5lHf7Dp6zQKS9K+1c61nZvIeJJ/0hgW8XB
15YB41FxmQMmpirqs1Iwg7D8EBtO2AqDpwYI4re8uGeBpA1FaGbynRF8EMkJ6IvS
MQuTZzLA4dDfkZt/jbIwiYRB9YY4EomvgbrvwIy3IcjUGb0tGATvVlJoQ6OT8qjE
GsWFltoMRwIGL9mKs8Ch4ltn+aSwnVLq8b/yWmFd8l1qKnt8KAk4wcm3c4riRqsQ
9EoSw3zyci4YxQXaXs8s
=RS7V
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--
