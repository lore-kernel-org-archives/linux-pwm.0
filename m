From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 14/17] pwm: sti: Add PWM Capture call-back
Date: Mon, 5 Sep 2016 13:10:56 +0200
Message-ID: <20160905111056.GN31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-15-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-15-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:05AM +0100, Lee Jones wrote:
> Once a PWM Capture has been initiated, the capture call
> enables a rising edge detection IRQ, then waits.  Once each
> of the 3 phase changes have been recorded the thread then
> wakes.  The remaining part of the call carries out the
> relevant calculations and passes back a formatted string to
> the caller.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 88 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 88 insertions(+)

Applied with minor changes. See below.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> +#define SECS_TO_NANOSECS(x) ((x) * 1000 * 1000 * 1000)

I dropped this in favour of doing the multiplication by NSEC_PER_SEC in
situ.

> +
>  #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Device's Duty Cycle registe=
r */
>  #define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
>  #define PWM_CPT_EDGE(x) (0x30 + (4 * (x))) /* Edge to capture on */
> @@ -305,7 +307,88 @@ static void sti_pwm_free(struct pwm_chip *chip, stru=
ct pwm_device *pwm)
>  	clear_bit(pwm->hwpwm, &pc->configured);
>  }
> =20
> +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_capture *result, unsigned long timeout)
> +{
> +	struct sti_pwm_chip *pc =3D to_sti_pwmchip(chip);
> +	struct sti_pwm_compat_data *cdata =3D pc->cdata;
> +	struct sti_cpt_ddata *ddata =3D pwm_get_chip_data(pwm);
> +	struct device *dev =3D pc->dev;
> +	unsigned int effective_ticks;
> +	unsigned long long high, low;
> +	int ret;
> +
> +	if (pwm->hwpwm > cdata->cpt_num_devs - 1) {

Turned this into:

	if (pwm->hwpwm >=3D cdata->cpt_num_devs) {

because I find that easier to read.

Thierry

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzVK9AAoJEN0jrNd/PrOhIDIP/3xZ8955cq0Zx36UOSJKgNWu
O17JNMdHNIUicDyLst3beKiItMtRP+ctBUOCmjuhW8kgioZoqGk8VbyvJy7fOWMa
x38gKkNoOoIpdeGl5FWIIeWhPWfx4AwurKOB1XJ8qnqsAPX4w/jMbC90AGB3hMeK
QHtAYMNLivxn5G8aHVRKS0nU4lUJRc5l2lmhI1jtNOvp6VTjKKS6wiarcZDlv9iK
1Y5qao5fRXOAD3VoX92qh2nmGMBVxvw/AqwYwGh5yUGEanDPWqC8GyoimRxW2GiM
u4g2p8hstkP/ZT9LIS/y5mq2F1E3sN0QAf83/f+LKBl0HAcCM+0xU+SNOGmWfiEn
H26HhsDH2dPGZMU1wsuurvvVyvMP6sdU44hmtWFH8fCbp0FgDYWLfatJ94SHn/Lt
7if3r8e1Cu6MO2hIrun+xqwjrSOh/tQbLoxuUfNv8Cmjf542mkLbR4l8rzWz/7SH
zaIeTi+hf+FfFLvTBuJq5QA4/qMqloCcnKmVJyxqseV3Od7v7TqYBH1khvU/TteQ
GuaK/EtsfdTOYqscjPStUZcMJFUP4Akeai/b9JwFGrnhuIuRTBDDhWd+AIB0f0cu
0n7LfKFbrWVUNJKnnvczQRESgUhnfyNeCURlz6s7aJ2boJqXRBmkmN7+EIcK7J9y
yqrfYbNDTXpYGh06m9BN
=OMXh
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
