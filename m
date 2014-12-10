From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3] clk: Add PWM clock driver
Date: Wed, 10 Dec 2014 15:59:53 +0100
Message-ID: <1418223593.3258.10.camel@pengutronix.de>
References: <1418138392-17081-1-git-send-email-p.zabel@pengutronix.de>
	 <54872810.7000700@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54872810.7000700@elproma.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz =?UTF-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Mike Turquette <mturquette@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Janusz,

thank you for the comments.

Am Dienstag, den 09.12.2014, 17:49 +0100 schrieb Janusz U=C5=BCycki:
[...]
> > +int clk_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *node =3D pdev->dev.of_node;
> > +	struct clk_init_data init;
> > +	struct clk_pwm *clk_pwm;
> > +	struct pwm_device *pwm;
> > +	const char *clk_name;
> > +	struct clk *clk;
> > +	int ret;
> > +
> > +	clk_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL=
);
> > +	if (!clk_pwm)
> > +		return -ENOMEM;
> > +
> > +	pwm =3D devm_pwm_get(&pdev->dev, NULL);
>=20
> NULL or clk_name ?

There's only one pwm input to the pwm-clock, so I see no need to use a
con_id here and require the pwm-names device tree property to be set.

> > +	if (IS_ERR(pwm))
> > +		return PTR_ERR(pwm);
> > +
> > +	if (!pwm || !pwm->period) {
> > +		dev_err(&pdev->dev, "invalid pwm period\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed=
_rate))
> > +		clk_pwm->fixed_rate =3D 1000000000 / pwm->period;
>=20
> You can use NSEC_PER_SEC instead of the hardcoded value.

Thanks, I'll fix that.

> > +
> > +	if (pwm->period !=3D 1000000000 / clk_pwm->fixed_rate &&
> > +	    pwm->period !=3D DIV_ROUND_UP(1000000000, clk_pwm->fixed_rate=
)) {
> > +		dev_err(&pdev->dev,
> > +			"clock-frequency does not match pwm period\n");
> > +		return -EINVAL;
> > +	}
>=20
> This can't prevent against buggy pwm driver (bad frequency)
> because there is not function to read the period back, ie.
> .pwm_config callback does not modify duty_ns and period_ns to real=20
> values indeed.

Of course, this is only to make sure that the clock-frequency and pwm
duty cycle are roughly the same.

> There is the way to set directly
>          pwm->period =3D NSEC_PER_SEC / clk_pwm>fixed_rate;
> instead of third argument (period_ns) of pwms. Although the argument =
is=20
> required
> (#pwm-cells >=3D 2 and *_xlate_* functions) it could be set to 0 in p=
wms.
> Such calculation should be right for most PWMs if they are clocked no=
t=20
> faster
> than eg. 40MHz. Above div-round issue can appear but it also appears =
due=20
> to ns resolution.
> I can't point if this is the best solution for the future.
>=20
> > +
> > +	ret =3D pwm_config(pwm, (pwm->period + 1) >> 1, pwm->period);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	clk_name =3D node->name;
> > +	of_property_read_string(node, "clock-output-names", &clk_name);
> > +
> > +	init.name =3D clk_name;
> > +	init.ops =3D &clk_pwm_ops;
> > +	init.flags =3D CLK_IS_ROOT;
>=20
> and what about CLK_IS_BASIC?

Yes, I'll add that.

> > +	init.num_parents =3D 0;
>=20
> Is it proof against suspend/resume race of pwm driver vs pwm-clock's=20
> customer?
> Otherwise chain of clocks can be broken.

Are there pwm drivers that disable pwm output in their suspend callback=
?
I don't think system wide suspend/resume ordering can protect against
that at all, since the two devices may be on completely different buses=
=2E
In that case it'd probably be best to use runtime pm to keep the pwm
activated until clk_disable/pwm_disable is called by the consumer.

[...]
> > +static struct platform_driver clk_pwm_driver =3D {
> > +	.probe =3D clk_pwm_probe,
>=20
> missing
>                  .remove =3D clk_pwm_remove,
>=20
> > +	.driver =3D {
> > +		.name =3D "pwm-clock",
> > +		.owner =3D THIS_MODULE,
>=20
> .owner could be removed (not a problem now)

Will add and remove those, respectively.

> > +		.of_match_table =3D of_match_ptr(clk_pwm_dt_ids),
> > +	},
>=20
> Why doesn't mcp251x trigger probe of pwm-clock driver?
> The fixed-clock uses CLK_OF_DECLARE which defines .data
> of of_device_id instead of .probe. Unfortunately I'm not so much=20
> familiar with DT.
> Any idea?

Did you add "simple-bus" to the clocks node compatible? The pwm-clock
device tree node needs to be placed somewhere where of_platform_populat=
e
will consider it.

regards
Philipp
