From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 08/20] pwm: Add PWM Capture support
Date: Fri, 10 Jun 2016 15:53:02 +0200
Message-ID: <20160610135302.GK27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-9-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35031 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbcFJNxG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 09:53:06 -0400
Content-Disposition: inline
In-Reply-To: <20160608092135.21184-9-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 10:21:23AM +0100, Lee Jones wrote:
> Supply a PWM Capture call-back Op in order to pass back
> information obtained by running analysis on PWM a signal.
> This would normally (at least during testing) be called from
> the Sysfs routines with a view to printing out PWM Capture
> data which has been encoded into a string.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
>  include/linux/pwm.h | 25 +++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dba3843..4678de6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -525,6 +525,33 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>  EXPORT_SYMBOL_GPL(pwm_apply_state);
> =20
>  /**
> + * pwm_capture() - capture and report a PWM signal
> + * @pwm: PWM device
> + * @result: struct to fill with capture result
> + * @timeout_ms: time to wait, in milliseconds, before giving up on captu=
re
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
> +		unsigned int timeout_ms)
> +{
> +	int err;
> +
> +	if (!pwm || !pwm->chip->ops)
> +		return -EINVAL;
> +
> +	if (!pwm->chip->ops->capture)
> +		return -ENOSYS;
> +
> +	mutex_lock(&pwm_lock);
> +	err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout_ms);
> +	mutex_unlock(&pwm_lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(pwm_capture);
> +
> +/**
>   * pwm_adjust_config() - adjust the current PWM config to the PWM argume=
nts
>   * @pwm: PWM device
>   *
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 17018f3..13cac27 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -5,7 +5,9 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> =20
> +struct pwm_capture;
>  struct seq_file;
> +
>  struct pwm_chip;
> =20
>  /**
> @@ -153,6 +155,7 @@ static inline void pwm_get_args(const struct pwm_devi=
ce *pwm,
>   * @free: optional hook for freeing a PWM
>   * @config: configure duty cycles and period length for this PWM
>   * @set_polarity: configure the polarity of this PWM
> + * @capture: capture and report PWM signal
>   * @enable: enable PWM output toggling
>   * @disable: disable PWM output toggling
>   * @apply: atomically apply a new PWM config. The state argument
> @@ -172,6 +175,8 @@ struct pwm_ops {
>  		      int duty_ns, int period_ns);
>  	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    enum pwm_polarity polarity);
> +	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
> +		       struct pwm_capture *result, unsigned int timeout_ms);

Can we please drop the _ms suffix. It's already documented to be in
milliseconds. Also maybe make that unsigned long for consistency with
the type of the timeout parameter elsewhere in the kernel.

>  	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
>  	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
>  	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -212,6 +217,16 @@ struct pwm_chip {
>  	bool can_sleep;
>  };
> =20
> +/**
> + * struct pwm_capture - PWM capture data
> + * @period: period of the PWM signal (in nanoseconds)
> + * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
> + */
> +struct pwm_capture {
> +	unsigned long long period;
> +	unsigned long long duty_cycle;
> +};

I'd prefer these to be unsigned int, for symmetry with the PWM output
part of the framework. With 32 bits you get about 4.2 seconds of period
and duty cycle, and I doubt that any reasonable signal would extend
beyond that.

> @@ -322,6 +337,9 @@ static inline void pwm_disable(struct pwm_device *pwm)
> =20
> =20
>  /* PWM provider APIs */
> +int pwm_capture(struct pwm_device *pwm,
> +		struct pwm_capture *result,
> +		unsigned int timeout_ms);

This fits into 2 lines. And same comments on the timeout parameter.

>  int pwm_set_chip_data(struct pwm_device *pwm, void *data);
>  void *pwm_get_chip_data(struct pwm_device *pwm);
> =20
> @@ -373,6 +391,13 @@ static inline int pwm_config(struct pwm_device *pwm,=
 int duty_ns,
>  	return -EINVAL;
>  }
> =20
> +static inline int pwm_capture(struct pwm_device *pwm,
> +			      struct pwm_capture *result,
> +			      unsigned int timeout_ms)

Same here.

Otherwise this looks really nice to me from an API point of view.

Thierry

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWsY7AAoJEN0jrNd/PrOhR/IP/jRRdZXmVTOE4gL90G5XgS6p
Z6BYtmP0bgBlVGBzhO5v8SRLr39UHjrBIWR+WsV8vq4KobAVI/VaLd4rH9xMNd/y
fe6SiwdQ2LDv8jWM7xPnPAzmj/6nj3lbkBXdJ+X+1rQDJ/2zENw4+GPJPozWcIhP
Dk3/q98G4FF/Nu1uiMbsQM29K7ZvPV4g2/yddNXRfeX0cYhuA4FkzuFGrHj+IAst
7IZLMwTweBbL7OTU8e+olMymANfE7ssniVvPz9Cu33tLuBrUKoZGqJmmhkvfUBw/
hR5jhBVQTAJOqzik2nnE4OunooKJIIcL3sW8JdrvedLpYKB8HUOUeLQNfx8qrUDb
nm4lk4WCoowRpyXH+HfbstMP/CaKzggt7YFWL7q3UjkLaEfnq/8YrSVUpimoos9x
Q9sbpRwemK5JE+jjq1fV1YqmVpDXdcRY4so4Fa2xy/t6mqfd+wp8Zg8SrWXozztP
Gw2rzDl3DgZQEruNSnCwH7rbczSC3oa+S24tyVCE6sZjp8BZpWskq9EEo/0uo2ak
WUBSdoSAEHyTd2LRPFauyJWsI2k7Ql0oISUTYFKGvCemQlj60jvDHUNyxO4rvFM1
yfp02y0mOoc26lbqWeqR8sDbTeDHjfoHZX8su545K1Ub7c7MFIdWtgJNfsCN+r6G
pRPSx8QnUi3vA5OWSr2G
=OqVB
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
