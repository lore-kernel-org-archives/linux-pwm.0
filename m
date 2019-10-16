From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/3] pwm: stm32: add power management support
Date: Wed, 16 Oct 2019 09:06:35 +0200
Message-ID: <20191016070635.GC1296874@ulmo>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-4-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5870743600026654597=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1570193633-6600-4-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org


--===============5870743600026654597==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 02:53:53PM +0200, Fabrice Gasnier wrote:
> Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
> channel isn't active. Let the PWM consumers disable it during their own
> suspend sequence, see [1]. So, perform a check here, and handle the
> pinctrl states. Also restore the break inputs upon resume, as registers
> content may be lost when going to low power mode.
>=20
> [1] https://lkml.org/lkml/2019/2/5/770
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> Follow Uwe suggestions/remarks:
> - Add a precursor patch to ease reviewing
> - Use registers read instead of pwm_get_state
> - Add a comment to mention registers content may be lost in low power mode
> ---
>  drivers/pwm/pwm-stm32.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Applied, thanks. I made two minor changes, though, see below.

>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index cf8658c..546b661 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -12,6 +12,7 @@
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> =20
> @@ -655,6 +656,42 @@ static int stm32_pwm_remove(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> +static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> +{
> +	struct stm32_pwm *priv =3D dev_get_drvdata(dev);
> +	unsigned int ch;

I renamed this to just "i", which is more idiomatic for loop variables.
The function is small enough not to need to differentiate between loop
variables.

> +	u32 ccer, mask;
> +
> +	/* Look for active channels */
> +	ccer =3D active_channels(priv);
> +
> +	for (ch =3D 0; ch < priv->chip.npwm; ch++) {
> +		mask =3D TIM_CCER_CC1E << (ch * 4);
> +		if (ccer & mask) {
> +			dev_err(dev, "The consumer didn't stop us (%s)\n",
> +				priv->chip.pwms[ch].label);

Changed this to:

	"PWM %u still in use by consumer %s\n", i, priv->chip.pwms[i].label

I think that might help clarify which PWM is still enabled in case the
consumers don't set a label.

Thierry

> +			return -EBUSY;
> +		}
> +	}
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused stm32_pwm_resume(struct device *dev)
> +{
> +	struct stm32_pwm *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* restore breakinput registers that may have been lost in low power */
> +	return stm32_pwm_apply_breakinputs(priv);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_=
resume);
> +
>  static const struct of_device_id stm32_pwm_of_match[] =3D {
>  	{ .compatible =3D "st,stm32-pwm",	},
>  	{ /* end node */ },
> @@ -667,6 +704,7 @@ static struct platform_driver stm32_pwm_driver =3D {
>  	.driver	=3D {
>  		.name =3D "stm32-pwm",
>  		.of_match_table =3D stm32_pwm_of_match,
> +		.pm =3D &stm32_pwm_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_pwm_driver);
> --=20
> 2.7.4
>=20

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2mwXsACgkQ3SOs138+
s6GqmQ//aMbyiuKupfEKiM3NlzeTFHoXGDg+k4W+S9nTP9R1XcCo+LUn9otYurGO
f44vih/M5jOuxA1RJ3w3Ji1fFOLD4/QXpTCN1nf+E1U0E/wo8HuPjpPJsZGj3vEJ
YeLxDNmpVe/VID1GKuyACOChqCI0dSvMmZYqbKMSSRhUVNmfja/FnubM6iCQ8xzY
qqUDkr4R1OCc4EjB9h5L+uBb+vy6iwGxEIZZNuMn3khiVvNTZpiI0D5qGLC0eVLM
3pDe6BTs/B7sI6OgQ2EJjqne9CbYXT3j/ANty3k4NcPXnMZ2nJT+8anoczxo2ZwB
zyA5SzMctvcCHNpqrbAZLuOPERTA//X8BisEzJ9YRC1WjKuvJ9ykyXWWtcEnYdyr
JeS6NNslrxDC1Fl4mrJV4rEJqm01giH2Pz1J0+8FAYYiga9QYQoYqjjxos6NSxde
PcruGHt6xLWd647jwNGDrrG1G8gz+7xUEVpyHD8xSVXsNZ41Rst3WSkmwmu0vr4Y
S7y5ylK/O9SW9p3yhyVuQPCc0rk/Mgln4BnOj8jq0FQDNVFosnC0eKX3tI8/CWlB
Mpe9Rc7W4v3Hr7GBXoNqbNx4Uudfg7exBCc0pk2LFrobvyyjy+1vmKPtW6HnH4k3
S6h+dAMVH0QFmOimR8+QXtzTSUQ3ik96+Na4q+C44ozzuX/EBNs=
=+BC6
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--


--===============5870743600026654597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5870743600026654597==--
