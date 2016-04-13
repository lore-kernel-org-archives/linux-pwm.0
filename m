From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 08/11] pwm: sti: Add support for PWM Capture IRQs
Date: Wed, 13 Apr 2016 11:05:21 +0100
Message-ID: <20160413100521.GP8094@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
 <20160412103521.GD18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412103521.GD18882@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pwm@vger.kernel.org

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 02, 2016 at 03:32:06PM +0000, Lee Jones wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> [...]
> > +static irqreturn_t sti_pwm_interrupt(int irq, void *data)
> > +{
> > +	struct sti_pwm_chip *pc =3D data;
> > +	struct device *dev =3D pc->dev;
> > +	struct sti_cpt_data *d;
> > +	int channel;
> > +	int cpt_int_stat;
> > +	int reg;
> > +	int ret =3D IRQ_NONE;
> > +
> > +	ret =3D regmap_field_read(pc->pwm_cpt_int_stat, &cpt_int_stat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	while (cpt_int_stat) {
> > +		channel =3D ffs(cpt_int_stat) - 1;
> > +
> > +		d =3D pc->cpt_data[channel];
> > +
> > +		/*
> > +		 * Capture input:
> > +		 *    _______                   _______
> > +		 *   |       |                 |       |
> > +		 * __|       |_________________|       |________
> > +		 *   ^0      ^1                ^2
> > +		 *
> > +		 * Capture start by the first available rising edge
> > +		 * When a capture event occurs, capture value (CPT_VALx)
> > +		 * is stored, index incremented, capture edge changed.
> > +		 *
> > +		 * After the capture, if the index > 1, we have collected
> > +		 * the necessary data so we signal the thread waiting for it
> > +		 * and disable the capture by setting capture edge to none
> > +		 *
> > +		 */
>=20
> How do you deal with the situation where someone will stop the PWM
> signal half-way in? That is, suppose you've got events for the first =
and
> second snapshots (0 and 1) and then someone stops the PWM and the eve=
nt
> for snapshot 2 never happens, how does the code recover?

The 'wait' will timeout and the cycle will be reset.

> > +
> > +		regmap_read(pc->regmap,
> > +			    PWM_CPT_VAL(channel), &d->snapshot[d->index]);
> > +
> > +		switch (d->index) {
> > +		case 0:
> > +		case 1:
> > +			regmap_read(pc->regmap, PWM_CPT_EDGE(channel), &reg);
> > +			reg ^=3D PWM_CPT_EDGE_MASK;
> > +			regmap_write(pc->regmap, PWM_CPT_EDGE(channel), reg);
> > +
> > +			d->index++;
> > +			break;
> > +		case 2:
> > +			regmap_write(pc->regmap,
> > +				     PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> > +			wake_up(&d->wait);
> > +			break;
> > +		default:
> > +			dev_err(dev, "Internal error\n");
> > +		}
> > +
> > +		clear_bit(channel, (unsigned long int *)&cpt_int_stat);
>=20
> clear_bit() is a little unusual to use on regular data types, as
> evidenced by the need for the goofy cast here.

It's just a bit neater (and provides locking) than manually bit
twiddling using bitwise operators.  What do you suggest?

> > +
> > +		ret =3D IRQ_HANDLED;
> > +	}
> > +
> > +	/* Just ACK everything */
> > +	regmap_write(pc->regmap, PWM_INT_ACK, PWM_INT_ACK_MASK);
> > +
> > +	return ret;
> > +}
> > +
> >  static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
> >  {
> >  	struct device *dev =3D pc->dev;
> > @@ -354,6 +425,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chi=
p *pc)
> >  	if (IS_ERR(pc->pwm_cpt_int_en))
> >  		return PTR_ERR(pc->pwm_cpt_int_en);
> > =20
> > +	pc->pwm_cpt_int_stat =3D devm_regmap_field_alloc(dev, pc->regmap,
> > +						reg_fields[PWM_CPT_INT_STAT]);
> > +	if (IS_ERR(pc->pwm_cpt_int_stat))
> > +		return PTR_ERR(pc->pwm_cpt_int_stat);
> > +
> >  	return 0;
> >  }
> > =20
> > @@ -371,7 +447,7 @@ static int sti_pwm_probe(struct platform_device=
 *pdev)
> >  	struct sti_pwm_chip *pc;
> >  	struct resource *res;
> >  	unsigned int chan;
> > -	int ret;
> > +	int ret, irq;
> > =20
> >  	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> >  	if (!pc)
> > @@ -392,6 +468,19 @@ static int sti_pwm_probe(struct platform_devic=
e *pdev)
> >  	if (IS_ERR(pc->regmap))
> >  		return PTR_ERR(pc->regmap);
> > =20
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> > +		return -ENODEV;
> > +	}
>=20
> I think you need to propagate the return value of platform_get_irq()
> here.

Yes, could do.  Although, I think we could go either way:

$ git grep -A5 platform_get_irq | grep "return ret\|return irq" | wc -l
176
$ git grep -A5 platform_get_irq | grep "return -EINVAL\|-ENODEV\|-ENXIO=
" | wc -l
256

Happy to change it though.

> > +
> > +	ret =3D devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt,
> > +			       0, pdev->name, (void *) pc);
>=20
> No need for the explicit cast to void *.

You're right.  Will drop it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
