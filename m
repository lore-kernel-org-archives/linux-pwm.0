From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Tue, 5 Feb 2019 23:25:23 +0100
Message-ID: <20190205222522.GB1372@mithrandir>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:47:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
> > Add suspend/resume PM sleep ops. When going to low power, disable
> > active PWM channel. Active PWM channel is resumed, by calling
> > pwm_apply_state(). This is inspired by Thierry's comment in [1].
> > Don't touch inactive channels, as it may be used by other LPTimer MFD
> > child driver.
> > [1]https://lkml.org/lkml/2017/12/5/175
> >=20
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> > index 0059b24c..0c40d48 100644
> > --- a/drivers/pwm/pwm-stm32-lp.c
> > +++ b/drivers/pwm/pwm-stm32-lp.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/mfd/stm32-lptimer.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> > =20
> > @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
> >  	struct pwm_chip chip;
> >  	struct clk *clk;
> >  	struct regmap *regmap;
> > +	struct pwm_state suspend;
> > +	bool suspended;
> >  };
> > =20
> >  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *ch=
ip)
> > @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_dev=
ice *pdev)
> >  	return pwmchip_remove(&priv->chip);
> >  }
> > =20
> > +#ifdef CONFIG_PM_SLEEP
> > +static int stm32_pwm_lp_suspend(struct device *dev)
> > +{
> > +	struct stm32_pwm_lp *priv =3D dev_get_drvdata(dev);
> > +
> > +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
> > +	priv->suspended =3D priv->suspend.enabled;
> > +
> > +	/* safe to call pwm_disable() for already disabled pwm */
> > +	pwm_disable(&priv->chip.pwms[0]);
> > +
> > +	return pinctrl_pm_select_sleep_state(dev);
>=20
> IMHO a PWM should not stop if the PWM user didn't call pwm_disable() (or
> pwm_apply_state() with .enabled =3D false).
>=20
> I don't understand all the PM details, but I think there is no defined
> order in which devices are signalled to suspend. If so the PWM might be
> stopped before its consumer. Then the PWM changes state without the
> consumer being aware of that.
>=20
> I understand Thierry's position in the link you provided in the commit
> log consistant with my position here.

Agreed, we should let users of the PWM take care of resuming the PWM in
the state and at the point in time that they require so. PWM users will
also likely do a pwm_disable() during their suspend implementation, so
doing this again in a PWM ->suspend() is not necessary, even if perhaps
harmless.

So this leaves only the pinctrl_pm_select_sleep_state() call. That seems
fine, but I'm not sure that that's currently guaranteed to work. I think
we may need to implement device link support in the PWM framework to
guarantee the proper suspend/resume sequencing. Otherwise you may end up
in a situation where the PWM is actually suspended before the user and
glitch the pins before the user has a chance to disable the PWM.

I think it'd be fine to merge the driver change here first before we add
device link support if this works for you. Just mentioning the issue
here in case you ever run into it.

Thierry

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxaDU8ACgkQ3SOs138+
s6HIUg/+MBv4yfO0gFeRJM8ZceH9qudcTpN9AN8hEwCrzDssQnbs2xqzGKlcj/x9
pbPd76H/QLjtXeaEILnH6kbpSWZz8I2u9/2SNJ03EzlhhYp+IfE3HwYuvyjCCHEK
d2JCK9X+NDko2K8WBOrtgHYc/KFBhl8GSH/D5ffKpjHg6nJXLOUyfFN48u0YLLXL
OlIdNxoMiUAoYcemG4kO2r/peYBsmYwoKX/mxcZEiLF846HPxxy0KrBGo+Ikzd/D
Kk+bg77SwQhCwQ6fTFWkxPw6lPXaOFGF94KFnUsLaS7Rzx/ti/qfoMgDDbeaB4ME
UpEegQnSOwQ07ruYKAUwFC36HwIii8/60wpdFDlGnZ3i3hYrSHl/mQZHg4mr+/Tt
/41UFS46SkrRy8dJi01O7YTC2k3vWuiHA7fQGz5maWmD1e3vkcVMWk3397rJHKMd
1IYVW4VX8rYOOz/86PXVbCmSY8ElN48zSVB0FEnVaSSbWe8fZ4JSDeOVLVqw/O0Z
lZn8bLFURpagSjFlOX9w9Kr5S9Pl6OvnAdQNTEThhJ8CnKBDnAzDydezQ+a8kLir
/+556979QT0YE+epNlqe7d72BsE+1R3Hep2t7dq6Cx2CLRIqJbktycpUrTe3RdgL
eMT/K20QoEenAgKsqh66pJjJz5RHkI9tqxeKBud8LZs5rWnUZvk=
=jnFr
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
