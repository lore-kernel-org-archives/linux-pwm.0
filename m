From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v6 1/5] pwm: add the Berlin pwm controller driver
Date: Fri, 25 Sep 2015 11:15:24 +0200
Message-ID: <20150925091524.GB19573@kwain>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150921084008.GE19865@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57634 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755524AbbIYJPg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2015 05:15:36 -0400
Content-Disposition: inline
In-Reply-To: <20150921084008.GE19865@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 21, 2015 at 10:40:08AM +0200, Thierry Reding wrote:
> On Thu, Sep 17, 2015 at 12:13:04PM +0200, Antoine Tenart wrote:
> > +
> > +#define BERLIN_PWM_EN			0x0
> > +#define BERLIN_PWM_CONTROL		0x4
> > +#define BERLIN_PWM_DUTY			0x8
> > +#define BERLIN_PWM_TCNT			0xc
> > +
> > +#define BERLIN_PWM_ENABLE		BIT(0)
> > +#define BERLIN_PWM_INVERT_POLARITY	BIT(3)
> > +#define BERLIN_PWM_PRESCALE_MASK	0x7
> > +#define BERLIN_PWM_PRESCALE_MAX		4096
> > +#define BERLIN_PWM_MAX_TCNT		65535
>=20
> It'd be nice to see some sort of connection between the register
> definitions and which fields belong to them.

Something like:

#define BERLIN_PWM_EN		0x0
#define  BERLIN_PWM_ENABLE	BIT(0)
#define BERLIN_PWM_CONTROL	0x4
=2E..

> > +struct berlin_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	void __iomem *base;
> > +	spinlock_t lock;
>=20
> I don't think that lock is necessary here. You have per-channel
> registers and each channel can only be used by one consumer at a time
> anyway.

Sure. I'll make some tests and remove the lock if possible.

> > +#define to_berlin_pwm_chip(chip)	\
> > +	container_of((chip), struct berlin_pwm_chip, chip)
> > +
> > +#define berlin_pwm_readl(chip, channel, offset)		\
> > +	readl_relaxed((chip)->base + (channel) * 0x10 + offset)
> > +#define berlin_pwm_writel(val, chip, channel, offset)	\
> > +	writel_relaxed(val, (chip)->base + (channel) * 0x10 + offset)
>=20
> These should be static inline functions. Also I think for
> berlin_pwm_writel() val should come after chip and channel to preserv=
e a
> more natural ordering of parameters.

What's the benefit of using static inline functions here?

I'm not convinced having val after chip and channel is more natural, bu=
t
this is not a big matter. I'll update.

> > +
> > +/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> > +static const u32 prescaler_diff_table[] =3D {
> > +	1, 4, 2, 2, 4, 4, 4, 4,
> > +};
>=20
> I don't see any relationship between these values and the prescaler
> table given in the comment. Please expand the comment to explain the
> connection.
>=20
> After reading the remainder of the code, I see that the values in thi=
s
> table are the multiplication factors for each of the prescalers. It
> shouldn't be necessary to read the code to find out, so please clarif=
y
> in the comment (and perhaps rename the table to something more relate=
d
> to its purpose, such as prescale_factors).

Will do.

> Perhaps an even more easily digestible alternative would be to make t=
his
> a list of prescaler values and then use the values directly to comput=
e
> the number of cycles rather than iteratively dividing and needing thi=
s
> unintuitive mapping.

Would something like the following be better?

"""
static const prescaler_table =3D {1, 4, 8, 16, 64, 256, 1024, 4096};
unsigned int prescale;
u64 tmp;

for (prescale =3D 0; prescale < ARRAY_SIZE(prescaler_table); prescale++=
) {
	tmp =3D cycles;
	do_div(tmp, prescaler_table[prescale]);

	if (tmp <=3D BERLIN_PWM_MAX_TCNT)
		break;
}

if (tmp > BERLIN_PWM_MAX_TCNT)
	return -ERANGE;

cycles =3D tmp;
"""

I personally prefer the prescale factors implementation, but I admit
this is maybe more readable.

> > +
> > +	while (cycles > BERLIN_PWM_MAX_TCNT)
> > +		do_div(cycles, prescaler_diff_table[++prescale]);
>=20
> Don't you need to make sure that prescale doesn't exceed the table si=
ze?

Sure.

> > +
> > +	ret =3D pwmchip_add(&pwm->chip);
> > +	if (ret < 0) {
> > +		clk_disable_unprepare(pwm->clk);
>=20
> Why not enable the clock until after successful registration? It does=
n't
> seem like you need access before that. Doing so would introduce a sub=
tle
> race condition between adding the chip (and hence exposing it via sys=
fs)
> and enabling the clock, so perhaps an even better approach would be t=
o
> add more fine-grained clock management by enabling or disabling it on=
ly
> when necessary (clock enables are reference counted, so ->request() a=
nd
> ->free() would probably work fine in this case).
>=20
> This isn't a real objection, though. If you prefer to keep things sim=
ple
> the current code is fine with me.

That was the idea. We may update this latter.

> > +static int berlin_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct berlin_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret =3D pwmchip_remove(&pwm->chip);
> > +	if (ret)
> > +		return ret;
> > +
> > +	clk_disable_unprepare(pwm->clk);
>=20
> You might want to disable the clock regardless. The driver will be
> unloaded regardless of whether pwmchip_remove() returns failure or
> not. The above would leak a clock enable, which may not be what you
> want.

Yes, I'll call clk_disable_unprepare() regardless of what pwmchip_remov=
e()
returns.

Thanks for the review!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
