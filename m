From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Tue, 12 Apr 2016 12:29:26 +0200
Message-ID: <20160412102926.GC18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pwm@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
[...]
> +struct sti_cpt_data {
> +	u32 snapshot[3];
> +	int index;
> +	int gpio;

On a side-note, this should probably use struct gpio_desc * instead of
an integer along with the gpiod_*() APIs for the GPIO handling.

> +	struct mutex lock;
> +	wait_queue_head_t wait;
> +};
> +
>  struct sti_pwm_compat_data {
>  	const struct reg_field *reg_fields;
> -	unsigned int num_chan;
> +	unsigned int pwm_num_chan;
> +	unsigned int cpt_num_chan;
>  	unsigned int max_pwm_cnt;
>  	unsigned int max_prescale;
>  };
> @@ -77,6 +90,7 @@ struct sti_pwm_chip {
>  	struct clk *cpt_clk;
>  	struct regmap *regmap;
>  	struct sti_pwm_compat_data *cdata;
> +	struct sti_cpt_data *cpt_data[STI_MAX_CPT_CHANS];

The PWM subsystem allows chip-specific data to be associated with each
PWM device. I'd prefer if the driver used it rather than homebrew some-
thing similar. See pwm_set_chip_data() and pwm_get_chip_data().

> @@ -389,6 +411,19 @@ static int sti_pwm_probe(struct platform_device *pde=
v)
>  	if (ret)
>  		return ret;
> =20
> +	for (chan =3D 0; chan < cdata->cpt_num_chan; chan++) {
> +		struct sti_cpt_data *data;
> +
> +		data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +
> +		init_waitqueue_head(&data->wait);
> +		mutex_init(&data->lock);
> +		data->gpio =3D of_get_named_gpio(np, "capture-gpios", chan);
> +		pc->cpt_data[chan] =3D data;

Converting to per-PWM data should be as simple as turning this last line
into:

	pwm_set_chip_data(pc->chip.pwms[chan], data);

Also I don't see any cleanup for this data in the driver. The memory for
the per-PWM data should be freed by devm_*() infrastructure, but how
will the GPIO be released?

Thierry

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDM4DAAoJEN0jrNd/PrOhPAwP/2uMGQBNtEnesbN91CbSwMtp
N/6Id7Z5nE0qX7nlBx9Nn5e62RrSZlY59csJbkx/c5mfqyAUzaRI1P/PV9aRJxb+
sosK5ei31MH5iIpy7BaP0hLquKxrG0lxguZvAPN1Js/KIiyUcNhEZu3QZQ0PMexg
cNcNyRdyg2e1FDDfQJI2cw/DNRJkFLLy4RunEZEOOE07dpsFuJP1X2jhl3dM/84P
1wYTvwFZsU60S676T4GItdKwPKGWtXV20QJ4mgMXDbiThyUhvmDUoD3V7lzp4scb
23mnt7DuI+mEET5v8mRe9YvcJTAC4cYsxZlSrbSwnIc/lpEjIcFBYZAI3vF835gv
BrFh43UYXx+kUPB3NlFJJO9vHGy1NFwzoPSD+cGY8i7aD+qznb9JXJpTyCS9okzL
16XqM3XP6JpLNvFZzfElJXAnleAmTENBhR+le1GVqeoFCtECOQ0w0I624z4DyzYw
yux5rPPHrR1EMxNutXj6lynzvZgRpZivILJmoCdaQvrDQgI7z2pwVMmXn6ES/WdK
DCnkU9VzDFxYHqp8aHCvmwiC9uNbBpGM4FTEOP9G0q1EfSM0MLymfZ7qV29yEP1j
rdS/uGXkPGzuA+o47lrfMH+3wUrt9Lbh65CQmwBWep7Wq2QhShLKI/85qIUWC1zs
PIuCNGyDHRw59j5wo/V9
=nwwB
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
