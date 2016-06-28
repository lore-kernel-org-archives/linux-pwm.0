From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND 2/3] pwm: kona: Add support for Broadcom iproc pwm
 controller
Date: Tue, 28 Jun 2016 14:52:23 +0200
Message-ID: <20160628125223.GA5662@ulmo.ba.sec>
References: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
 <1459261350-23851-3-git-send-email-yendapally.reddy@broadcom.com>
 <20160510144024.GA7149@ulmo.ba.sec>
 <20160623223252.6b674ca3@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160623223252.6b674ca3@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2016 at 10:32:52PM +0200, Boris Brezillon wrote:
> Hi,
>=20
> On Tue, 10 May 2016 16:40:24 +0200
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>=20
> > On Tue, Mar 29, 2016 at 10:22:29AM -0400, Yendapally Reddy Dhananjaya R=
eddy wrote:
> > > Update the kona driver to support Broadcom iproc pwm controller
> > >=20
> > > Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@br=
oadcom.com>
> > > ---
> > >  drivers/pwm/Kconfig        |   6 +-
> > >  drivers/pwm/pwm-bcm-kona.c | 183 +++++++++++++++++++++++++++++++++++=
++++------
> > >  2 files changed, 163 insertions(+), 26 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index c182efc..e45ea33 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -76,9 +76,11 @@ config PWM_ATMEL_TCB
> > > =20
> > >  config PWM_BCM_KONA
> > >  	tristate "Kona PWM support"
> > > -	depends on ARCH_BCM_MOBILE
> > > +	depends on ARCH_BCM_MOBILE || ARCH_BCM_IPROC
> > > +	default ARCH_BCM_IPROC =20
> >=20
> > Why the default? Typically you'd enable this in one or more of the
> > default configurations. default ARCH_* is really only useful if the
> > driver is essential. PWM doesn't usually fall into this category.
> >=20
> > > diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> > > index c634183..ef152e3a 100644
> > > --- a/drivers/pwm/pwm-bcm-kona.c
> > > +++ b/drivers/pwm/pwm-bcm-kona.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/math64.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pwm.h>
> > >  #include <linux/slab.h>
> > > @@ -47,30 +48,90 @@
> > > =20
> > >  #define PWM_CONTROL_OFFSET			(0x00000000)
> > >  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
> > > -#define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
> > > +#define PWM_CONTROL_TYPE_SHIFT(shift, chan)	(shift + chan) =20
> >=20
> > You need to put the parameters into parentheses to avoid expansion from
> > potentially messing up the expression.
> >=20
> > >  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
> > >  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
> > > =20
> > >  #define PRESCALE_OFFSET				(0x00000004)
> > > -#define PRESCALE_SHIFT(chan)			((chan) << 2)
> > > -#define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> > > +#define PRESCALE_SHIFT				(0x00000004)
> > > +#define PRESCALE_MASK				(0x00000007) =20
> >=20
> > Hmm... this looks odd. Why are you dropping the chan parameter here?
> >=20
> > >  #define PRESCALE_MIN				(0x00000000)
> > >  #define PRESCALE_MAX				(0x00000007)
> > > =20
> > > -#define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
> > > +#define PERIOD_COUNT_OFFSET(offset, chan)	(offset + (chan << 3)) =20
> >=20
> > Need parentheses here as well.
> >=20
> > >  #define PERIOD_COUNT_MIN			(0x00000002)
> > >  #define PERIOD_COUNT_MAX			(0x00ffffff)
> > > +#define KONA_PERIOD_COUNT_OFFSET		(0x00000008)
> > > =20
> > > -#define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
> > > +#define DUTY_CYCLE_HIGH_OFFSET(offset, chan)	(offset + (chan << 3))
> > >  #define DUTY_CYCLE_HIGH_MIN			(0x00000000)
> > >  #define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
> > > +#define KONA_DUTY_CYCLE_HIGH_OFFSET		(0x0000000c)
> > > +
> > > +#define PWM_CHANNEL_CNT				(0x00000006)
> > > +#define SIGNAL_PUSH_PULL			(0x00000001)
> > > +#define PWMOUT_TYPE_SHIFT			(0x00000010)
> > > +
> > > +#define IPROC_PRESCALE_OFFSET			(0x00000024)
> > > +#define IPROC_PRESCALE_SHIFT			(0x00000006)
> > > +#define IPROC_PRESCALE_MAX			(0x0000003f)
> > > +
> > > +#define IPROC_PERIOD_COUNT_OFFSET		(0x00000004)
> > > +#define IPROC_PERIOD_COUNT_MIN			(0x00000002)
> > > +#define IPROC_PERIOD_COUNT_MAX			(0x0000ffff)
> > > +
> > > +#define IPROC_DUTY_CYCLE_HIGH_OFFSET		(0x00000008)
> > > +#define IPROC_DUTY_CYCLE_HIGH_MIN		(0x00000000)
> > > +#define IPROC_DUTY_CYCLE_HIGH_MAX		(0x0000ffff)
> > > +
> > > +#define IPROC_PWM_CHANNEL_CNT			(0x00000004)
> > > +#define IPROC_SIGNAL_PUSH_PULL			(0x00000000)
> > > +#define IPROC_PWMOUT_TYPE_SHIFT			(0x0000000f)
> > > +
> > > +/*
> > > + * pwm controller reg structure
> > > + *
> > > + * @prescale_offset: prescale register offset
> > > + * @period_offset: period register offset
> > > + * @duty_offset: duty register offset
> > > + * @no_of_channels: number of channels
> > > + * @out_type_shift: out type shift in the register
> > > + * @signal_type: push-pull or open drain
> > > + * @prescale_max: prescale max
> > > + * @prescale_shift: prescale shift in register
> > > + * @prescale_ch_ascending: prescale ch order in prescale register
> > > + * @duty_cycle_max: value of max duty cycle
> > > + * @duty_cycle_min: value of min duty cycle
> > > + * @period_count_max: max period count val
> > > + * @period_count_min: min period count val
> > > + * @smooth_output_support: pwm smooth output support
> > > + */
> > > +struct kona_pwmc_reg {
> > > +	u32 prescale_offset;
> > > +	u32 period_offset;
> > > +	u32 duty_offset;
> > > +	u32 no_of_channels;
> > > +	u32 out_type_shift;
> > > +	u32 signal_type;
> > > +	u32 prescale_max;
> > > +	u32 prescale_shift;
> > > +	bool prescale_ch_ascending;
> > > +	u32 duty_cycle_max;
> > > +	u32 duty_cycle_min;
> > > +	u32 period_count_max;
> > > +	u32 period_count_min;
> > > +	bool smooth_output_support;
> > > +}; =20
> >=20
> > This is rather tedious. It looks to me like this isn't very similar to
> > the existing driver. Register offsets move around, bitfield positions
> > change, feature set is different. Might be better off turning this into
> > a separate driver after all.
> >=20
> > > +static const struct kona_pwmc_reg kona_pwmc_reg_data =3D {
> > > +	.prescale_offset =3D PRESCALE_OFFSET,
> > > +	.period_offset =3D KONA_PERIOD_COUNT_OFFSET,
> > > +	.duty_offset =3D KONA_DUTY_CYCLE_HIGH_OFFSET,
> > > +	.no_of_channels =3D PWM_CHANNEL_CNT,
> > > +	.out_type_shift =3D PWMOUT_TYPE_SHIFT,
> > > +	.signal_type =3D SIGNAL_PUSH_PULL,
> > > +	.prescale_max =3D PRESCALE_MAX,
> > > +	.prescale_shift =3D PRESCALE_SHIFT,
> > > +	.prescale_ch_ascending =3D false,
> > > +	.duty_cycle_max =3D DUTY_CYCLE_HIGH_MAX,
> > > +	.duty_cycle_min =3D DUTY_CYCLE_HIGH_MIN,
> > > +	.period_count_max =3D PERIOD_COUNT_MAX,
> > > +	.period_count_min =3D PERIOD_COUNT_MIN,
> > > +	.smooth_output_support =3D true,
> > > +};
> > > +
> > > +static const struct kona_pwmc_reg iproc_pwmc_reg_data =3D {
> > > +	.prescale_offset =3D IPROC_PRESCALE_OFFSET,
> > > +	.period_offset =3D IPROC_PERIOD_COUNT_OFFSET,
> > > +	.duty_offset =3D IPROC_DUTY_CYCLE_HIGH_OFFSET,
> > > +	.no_of_channels =3D IPROC_PWM_CHANNEL_CNT,
> > > +	.out_type_shift =3D IPROC_PWMOUT_TYPE_SHIFT,
> > > +	.signal_type =3D IPROC_SIGNAL_PUSH_PULL,
> > > +	.prescale_max =3D IPROC_PRESCALE_MAX,
> > > +	.prescale_shift =3D IPROC_PRESCALE_SHIFT,
> > > +	.prescale_ch_ascending =3D true,
> > > +	.duty_cycle_max =3D IPROC_DUTY_CYCLE_HIGH_MAX,
> > > +	.duty_cycle_min =3D IPROC_DUTY_CYCLE_HIGH_MIN,
> > > +	.period_count_max =3D IPROC_PERIOD_COUNT_MAX,
> > > +	.period_count_min =3D IPROC_PERIOD_COUNT_MIN,
> > > +	.smooth_output_support =3D false,
> > > +}; =20
> >=20
> > This looks like you could possible support a lot more hardware with this
> > driver because it's now almost completely parameterized.
> >=20
> > I don't see much sense in keeping this in the same driver and I think
> > it'd be better to write a new one from scratch, even if that means
> > slight duplication.
> >=20
> > Or you'll have to make a very compelling argument as to why this is the
> > better option.
>=20
> Sorry to enter the discussion just now (Brian CCed me in an answer he
> made to v4 of this series).
>=20
> Honestly, I'd have the exact opposite argument: if you have a look at
> newer versions of this patch, you'll see that more than 90% of the code
> is duplicated, and re-using the same logic with different field
> positions is quite common in other drivers. Actually the counter
> argument to your suggestion are bug fixes: when you find a bug, you'll
> have to remember fixing it for all implementations. Having a common
> code base has IMO more pros than cons.
>=20
> BTW, if you switch to regmap, you have this field-position
> customization for free (see reg_field).

My point was that with the above structures you have an almost
completely parameterized driver. There's probably a number of other PWM
controllers that you could support using those structure, or by adding
to them. The question then becomes: where do we draw the line? When is
a new driver warranted, and when is it not.

Your argument regarding bug fixes has some weight, but these drivers are
really trivial, so bug fixes will be equally trivial to port between
them.

There's also the issue about errata and quirks that may apply to one but
not all supported versions. The outcome of supporting all those
combinations can be completely unmaintainable, so I am willing to take a
bit of duplication if it means that in the end it will make things
easier for me.

Thierry

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXcnMEAAoJEN0jrNd/PrOhOj0P/j3FLEh/ckEY4LBd5cfZewY4
YNrgBjIiimnALEtv9P54C38hkJbeXQ6wHRd9q1kb6wGOpg9IAQk9s1CkJIwYOUJF
vkVsZoI0NDMMuXqvXz7+qk52sqSbfjuHBa8O048DYADwlA5W7mKsdo//ra4cbuhJ
EO2aauHsfy+Cgnu699wmb0j+XoLfu+TzI/5TOz6GvknzM5df3KYyUv81396xzA6n
XsyLFz4l3AosZN1vsSehUtQIRGpr4xjSzdsjyFiRjHGIfqFAqlZR+khDLM684HwK
znGyFOI7wp/k/uQdgtecNN0EqqD+ReboMhN+ClVSFozJ1f2xwW019J//klZqZYVZ
oq+IE5GHi9+0g0/6J0QtspJjMwDXvp+nB4eVXKRLhbX4gPOvGiSmAEJYbwVvkAsG
G9JJIU3HuyPpRIO4xqA8iTnfs2ig5B8hc0dVW5XjRIeqqRXs6A7AxVd4wJmWK0Y3
emUDGlx0usVAhWiuWAPZxALAKLs55UarZ8P/MeF88BhehnwIqW6zFPQJdjuX3Ief
n/CRet9UigqX4u6sWosPtkjKposLF6U9iB9OcZZPqsPRuasJMyePRHMqy+L+Nf4I
Y0WbTLVrCfM9R2WCyQSjZbxY7iOBdrm8KifHNhHJc4mwowW4lg/EaZhFB1pw3n20
3coV7Q7tqXl3YTHYaKSk
=bd58
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
