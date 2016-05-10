From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND 2/3] pwm: kona: Add support for Broadcom iproc pwm
 controller
Date: Tue, 10 May 2016 16:40:24 +0200
Message-ID: <20160510144024.GA7149@ulmo.ba.sec>
References: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
 <1459261350-23851-3-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36613 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbcEJOk2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2016 10:40:28 -0400
Content-Disposition: inline
In-Reply-To: <1459261350-23851-3-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2016 at 10:22:29AM -0400, Yendapally Reddy Dhananjaya Reddy=
 wrote:
> Update the kona driver to support Broadcom iproc pwm controller
>=20
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadc=
om.com>
> ---
>  drivers/pwm/Kconfig        |   6 +-
>  drivers/pwm/pwm-bcm-kona.c | 183 +++++++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 163 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c182efc..e45ea33 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -76,9 +76,11 @@ config PWM_ATMEL_TCB
> =20
>  config PWM_BCM_KONA
>  	tristate "Kona PWM support"
> -	depends on ARCH_BCM_MOBILE
> +	depends on ARCH_BCM_MOBILE || ARCH_BCM_IPROC
> +	default ARCH_BCM_IPROC

Why the default? Typically you'd enable this in one or more of the
default configurations. default ARCH_* is really only useful if the
driver is essential. PWM doesn't usually fall into this category.

> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index c634183..ef152e3a 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -19,6 +19,7 @@
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
> @@ -47,30 +48,90 @@
> =20
>  #define PWM_CONTROL_OFFSET			(0x00000000)
>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
> -#define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
> +#define PWM_CONTROL_TYPE_SHIFT(shift, chan)	(shift + chan)

You need to put the parameters into parentheses to avoid expansion from
potentially messing up the expression.

>  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
> =20
>  #define PRESCALE_OFFSET				(0x00000004)
> -#define PRESCALE_SHIFT(chan)			((chan) << 2)
> -#define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> +#define PRESCALE_SHIFT				(0x00000004)
> +#define PRESCALE_MASK				(0x00000007)

Hmm... this looks odd. Why are you dropping the chan parameter here?

>  #define PRESCALE_MIN				(0x00000000)
>  #define PRESCALE_MAX				(0x00000007)
> =20
> -#define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
> +#define PERIOD_COUNT_OFFSET(offset, chan)	(offset + (chan << 3))

Need parentheses here as well.

>  #define PERIOD_COUNT_MIN			(0x00000002)
>  #define PERIOD_COUNT_MAX			(0x00ffffff)
> +#define KONA_PERIOD_COUNT_OFFSET		(0x00000008)
> =20
> -#define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
> +#define DUTY_CYCLE_HIGH_OFFSET(offset, chan)	(offset + (chan << 3))
>  #define DUTY_CYCLE_HIGH_MIN			(0x00000000)
>  #define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
> +#define KONA_DUTY_CYCLE_HIGH_OFFSET		(0x0000000c)
> +
> +#define PWM_CHANNEL_CNT				(0x00000006)
> +#define SIGNAL_PUSH_PULL			(0x00000001)
> +#define PWMOUT_TYPE_SHIFT			(0x00000010)
> +
> +#define IPROC_PRESCALE_OFFSET			(0x00000024)
> +#define IPROC_PRESCALE_SHIFT			(0x00000006)
> +#define IPROC_PRESCALE_MAX			(0x0000003f)
> +
> +#define IPROC_PERIOD_COUNT_OFFSET		(0x00000004)
> +#define IPROC_PERIOD_COUNT_MIN			(0x00000002)
> +#define IPROC_PERIOD_COUNT_MAX			(0x0000ffff)
> +
> +#define IPROC_DUTY_CYCLE_HIGH_OFFSET		(0x00000008)
> +#define IPROC_DUTY_CYCLE_HIGH_MIN		(0x00000000)
> +#define IPROC_DUTY_CYCLE_HIGH_MAX		(0x0000ffff)
> +
> +#define IPROC_PWM_CHANNEL_CNT			(0x00000004)
> +#define IPROC_SIGNAL_PUSH_PULL			(0x00000000)
> +#define IPROC_PWMOUT_TYPE_SHIFT			(0x0000000f)
> +
> +/*
> + * pwm controller reg structure
> + *
> + * @prescale_offset: prescale register offset
> + * @period_offset: period register offset
> + * @duty_offset: duty register offset
> + * @no_of_channels: number of channels
> + * @out_type_shift: out type shift in the register
> + * @signal_type: push-pull or open drain
> + * @prescale_max: prescale max
> + * @prescale_shift: prescale shift in register
> + * @prescale_ch_ascending: prescale ch order in prescale register
> + * @duty_cycle_max: value of max duty cycle
> + * @duty_cycle_min: value of min duty cycle
> + * @period_count_max: max period count val
> + * @period_count_min: min period count val
> + * @smooth_output_support: pwm smooth output support
> + */
> +struct kona_pwmc_reg {
> +	u32 prescale_offset;
> +	u32 period_offset;
> +	u32 duty_offset;
> +	u32 no_of_channels;
> +	u32 out_type_shift;
> +	u32 signal_type;
> +	u32 prescale_max;
> +	u32 prescale_shift;
> +	bool prescale_ch_ascending;
> +	u32 duty_cycle_max;
> +	u32 duty_cycle_min;
> +	u32 period_count_max;
> +	u32 period_count_min;
> +	bool smooth_output_support;
> +};

This is rather tedious. It looks to me like this isn't very similar to
the existing driver. Register offsets move around, bitfield positions
change, feature set is different. Might be better off turning this into
a separate driver after all.

> +static const struct kona_pwmc_reg kona_pwmc_reg_data =3D {
> +	.prescale_offset =3D PRESCALE_OFFSET,
> +	.period_offset =3D KONA_PERIOD_COUNT_OFFSET,
> +	.duty_offset =3D KONA_DUTY_CYCLE_HIGH_OFFSET,
> +	.no_of_channels =3D PWM_CHANNEL_CNT,
> +	.out_type_shift =3D PWMOUT_TYPE_SHIFT,
> +	.signal_type =3D SIGNAL_PUSH_PULL,
> +	.prescale_max =3D PRESCALE_MAX,
> +	.prescale_shift =3D PRESCALE_SHIFT,
> +	.prescale_ch_ascending =3D false,
> +	.duty_cycle_max =3D DUTY_CYCLE_HIGH_MAX,
> +	.duty_cycle_min =3D DUTY_CYCLE_HIGH_MIN,
> +	.period_count_max =3D PERIOD_COUNT_MAX,
> +	.period_count_min =3D PERIOD_COUNT_MIN,
> +	.smooth_output_support =3D true,
> +};
> +
> +static const struct kona_pwmc_reg iproc_pwmc_reg_data =3D {
> +	.prescale_offset =3D IPROC_PRESCALE_OFFSET,
> +	.period_offset =3D IPROC_PERIOD_COUNT_OFFSET,
> +	.duty_offset =3D IPROC_DUTY_CYCLE_HIGH_OFFSET,
> +	.no_of_channels =3D IPROC_PWM_CHANNEL_CNT,
> +	.out_type_shift =3D IPROC_PWMOUT_TYPE_SHIFT,
> +	.signal_type =3D IPROC_SIGNAL_PUSH_PULL,
> +	.prescale_max =3D IPROC_PRESCALE_MAX,
> +	.prescale_shift =3D IPROC_PRESCALE_SHIFT,
> +	.prescale_ch_ascending =3D true,
> +	.duty_cycle_max =3D IPROC_DUTY_CYCLE_HIGH_MAX,
> +	.duty_cycle_min =3D IPROC_DUTY_CYCLE_HIGH_MIN,
> +	.period_count_max =3D IPROC_PERIOD_COUNT_MAX,
> +	.period_count_min =3D IPROC_PERIOD_COUNT_MIN,
> +	.smooth_output_support =3D false,
> +};

This looks like you could possible support a lot more hardware with this
driver because it's now almost completely parameterized.

I don't see much sense in keeping this in the same driver and I think
it'd be better to write a new one from scratch, even if that means
slight duplication.

Or you'll have to make a very compelling argument as to why this is the
better option.

Thierry

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXMfLVAAoJEN0jrNd/PrOhppQQALl97HseFhnUY9JkFrKHKygm
WZdTpOeay7T88ho4KX2XL4B8wOWy1zQy86F/awaw5h6ARaIiPhjo0Nyp5qfFofX9
z1txudcsyWwxFhoDANvW9DLGwLKbZpbx/wws8a0hze56s7EzAGN3iTrHxmNIwZFx
1yHczhjFYTenyBZLEJuqeEONiIDWyGsm6YHdCn3r7wl4OTLwgjRKUsEXvS10fC8a
O/Afvs+UbQ3Q0qxgo95XJzSm640Yyujt/d23myLLnLBf5eXnLlNJEMwhD2jf0OWS
OcKIomDgbTEGBSODsUVN+p2OmpnMfHEYalXNGt9EeJb5XeF6eoFIG3IVifHZ2pcL
rNymfriHGlftXqGhiDGaiGA3pN/eYI/sEHOpO6VDnDnfaw+Ev3zGdQpajOlS+ct2
IeDGwFSkLjj1Le3eieuoo6MEakkzZICtvTOSMsf4F+IkD6b4X21nFZ5x+1OkVxJ9
EQw7igOQnKQLXdGwP7YuIU23EqfdHDN3v6rKzNt+8vJr3+BbjfoC1NRwyaMb4jKm
U+7MJ+fHXelilddRpgRJIFcyGi1Kcp7WeuGZXKpg1tByD6ltDfGGFCTxfq7SY7jT
bOyB7Hb+Rf45khalWho/dbm9mFihu8hN9mlM4PMv4zKrTGbC/dfUVKIoBMAf1t2g
bZXMHBL9rk2r03eW/lou
=t7/b
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
