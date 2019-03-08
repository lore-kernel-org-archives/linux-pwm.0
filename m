From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Fri, 8 Mar 2019 16:59:36 +0530
Message-ID: <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com> <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Fri, Mar 01, 2019 at 04:23:19PM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC=
.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Various fixes and code cleanup]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  drivers/pwm/Kconfig      |  11 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sifive.c | 345 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 357 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sifive.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a8f47df..4a61d1a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,17 @@ config PWM_SAMSUNG
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-samsung.
> >
> > +config PWM_SIFIVE
> > +     tristate "SiFive PWM support"
> > +     depends on OF
> > +     depends on COMMON_CLK
> > +     depends on RISCV || COMPILE_TEST
> > +     help
> > +       Generic PWM framework driver for SiFive SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sifive.
> > +
> >  config PWM_SPEAR
> >       tristate "STMicroelectronics SPEAr PWM support"
> >       depends on PLAT_SPEAR
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9c676a0..30089ca 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)              +=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)        +=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)   +=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > +obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > new file mode 100644
> > index 0000000..6679ec7
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,345 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
> > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pd=
f
> > + *
> > + * Limitations:
> > + * - When changing both duty cycle and period, we cannot prevent in
> > + *   software that the output might produce a period with mixed
> > + *   settings (new period length and old duty cycle).
> > + * - The hardware cannot generate a 100% duty cycle.
> > + * - The hardware generates only inverted output.
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/slab.h>
> > +
> > +/* Register offsets */
> > +#define PWM_SIFIVE_PWMCFG            0x0
> > +#define PWM_SIFIVE_PWMCOUNT          0x8
> > +#define PWM_SIFIVE_PWMS                      0x10
> > +#define PWM_SIFIVE_PWMCMP0           0x20
> > +
> > +/* PWMCFG fields */
> > +#define PWM_SIFIVE_PWMCFG_SCALE              0
> > +#define PWM_SIFIVE_PWMCFG_STICKY     8
> > +#define PWM_SIFIVE_PWMCFG_ZERO_CMP   9
> > +#define PWM_SIFIVE_PWMCFG_DEGLITCH   10
> > +#define PWM_SIFIVE_PWMCFG_EN_ALWAYS  BIT(12)
> > +#define PWM_SIFIVE_PWMCFG_EN_ONCE    13
> > +#define PWM_SIFIVE_PWMCFG_CENTER     16
> > +#define PWM_SIFIVE_PWMCFG_GANG               24
> > +#define PWM_SIFIVE_PWMCFG_IP         28
>
> It's a bit inconsistent to have one of them use BIT and the others not.
> For consistency please use BIT for all defines. (They are unused
> anyhow.) For PWM_SIFIVE_PWMCFG_SCALE use:
>
>         #define PWM_SIFIVE_PWMCFG_SCALE GENMASK(3, 0)
>
> and then FIELD_GET and FIELD_PREP to access the values.

Sure will do that.

>
> > +/* PWM_SIFIVE_SIZE_PWMCMP is used to calculate offset for pwmcmpX regi=
sters */
> > +#define PWM_SIFIVE_SIZE_PWMCMP               4
> > +#define PWM_SIFIVE_CMPWIDTH          16
> > +#define PWM_SIFIVE_DEFAULT_PERIOD    10000000
> > +
> > +struct pwm_sifive_ddata {
> > +     struct pwm_chip chip;
> > +     struct mutex lock; /* lock to protect user_count */
> > +     struct notifier_block notifier;
> > +     struct clk *clk;
> > +     void __iomem *regs;
> > +     unsigned int real_period;
> > +     int user_count;
> > +};
> > +
> > +static inline
> > +struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *c)
> > +{
> > +     return container_of(c, struct pwm_sifive_ddata, chip);
> > +}
> > +
> > +static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device=
 *dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     mutex_lock(&pwm->lock);
> > +     pwm->user_count++;
> > +     mutex_unlock(&pwm->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *=
dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     mutex_lock(&pwm->lock);
> > +     pwm->user_count--;
> > +     mutex_unlock(&pwm->lock);
> > +}
> > +
> > +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     u32 val;
> > +     unsigned long long num;
> > +     /* (1 << (PWM_SIFIVE_CMPWIDTH+scale)) * 10^9/rate =3D real_period=
 */
> > +     unsigned long scale_pow =3D
> > +                     div64_ul(pwm->real_period * (u64)rate, NSEC_PER_S=
EC);
> > +     int scale =3D clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0x=
f);
>
> I tried for some time to verify the code here and this would have been
> easier with a more verbose comment. Something like:
>
> /*
>  * The PWM unit is used with pwmzerocmp=3D0, so the only way to modify th=
e
>  * period length is using pwmscale which provides the number of bits the
>  * counter is shifted before being feed to the comparators. A period
>  * lasts (1 << (PWM_SIFIVE_CMPWIDTH + pwmscale)) clock ticks.
>  */

Ok, will add this.

>
> There is a bad rounding effect here. I don't know the machine's details,
> and so will consider a parent clock running at 250 MHz. So one clock tick
> is 4 ns long and the smallest period length is 4 ns << 16 =3D=3D 262144 n=
s.
> Consider further an initial target period of 10000000 ns (which is
> PWM_SIFIVE_DEFAULT_PERIOD).
>
> The calculation here results in scale_pow =3D 2500000 and so scale =3D 5.
>
> > +     val =3D PWM_SIFIVE_PWMCFG_EN_ALWAYS | (scale << PWM_SIFIVE_PWMCFG=
_SCALE);
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     /* As scale <=3D 15 the shift operation cannot overflow. */
> > +     num =3D 1000000000ULL << (PWM_SIFIVE_CMPWIDTH + scale);
> > +     pwm->real_period =3D div64_ul(num, rate);
> > +     dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_p=
eriod);
> > +}
>
> Then real_period ends up being 8388608 ns. If now the input clk increases
> to 750 MHz it is 8388608 ns which is being used as target period length
> and the calculation results in:
>
>         scale_pow =3D 6291456
>         scale =3D 6
>         real_period =3D 5592405
>
> I'd claim it would be better to use scale =3D 7 here which results in
> 11184810 which is nearer to the initially targeted 10000000 ns. (But we
> cannot be sure as there is no rounding guide for the PWM framework.)
>
> But worse than that is that if the input clock goes back to 250 MHz we
> start with real_period =3D 5592405 and we get
>
>         scale_pow =3D 1398101
>         scale =3D 4
>         real_period =3D 4194304
>
> so we're not going back to the state we had when the clk was initially
> running at 250 MHz.
>
> To get the result independent of the prior configuration you better use
> the real targeted period length as input instead of the last configured
> approximation.

Sure. will change it.

>
> > +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +                              struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     u32 duty, val;
> > +     unsigned long long num;
> > +     int ret;
> > +
> > +     ret =3D clk_enable(pwm->clk);
> > +     if (ret)
> > +             return;
>
> Ideally we'd report state->enabled =3D 0 if the clk was off. I don't know
> how this could be done reliably though.
>
> > +     duty =3D readl(pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +                  dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     state->enabled =3D duty > 0;
>
> If duty is bigger than 0 but PWM_SIFIVE_PWMCFG_EN_ALWAYS isn't set you
> should report enabled =3D false, too.

Will add this.

>
> > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +     val &=3D 0x0F;
>
> Maybe name that "scale" instead of "val"?

Yes, will change it.

>
> > +     num =3D 1000000000ULL << (PWM_SIFIVE_CMPWIDTH + val);
>
> Is this (unsigned long long)NSEC_PER_SEC? (Ditto above in
> pwm_sifive_update_clock().)

Yes, will change this too.

>
> > +     pwm->real_period =3D div64_ul(num, clk_get_rate(pwm->clk));
> > +
> > +     state->period =3D pwm->real_period;
> > +     state->duty_cycle =3D
> > +             (u64)duty * pwm->real_period >> PWM_SIFIVE_CMPWIDTH;
> > +     state->polarity =3D PWM_POLARITY_INVERSED;
> > +
> > +     clk_disable(pwm->clk);
> > +}
> > +
> > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     int ret;
> > +
> > +     if (enable) {
> > +             ret =3D clk_enable(pwm->clk);
> > +             if (ret) {
> > +                     dev_err(pwm->chip.dev, "Enable clk failed:%d\n", =
ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (!enable)
> > +             clk_disable(pwm->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +                         struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     unsigned int duty_cycle, x;
> > +     u32 frac;
> > +     struct pwm_state cur_state;
> > +     bool enabled;
> > +     int ret =3D 0;
> > +     unsigned long num;
> > +
> > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&pwm->lock);
> > +     pwm_get_state(dev, &cur_state);
> > +     enabled =3D cur_state.enabled;
> > +
> > +     if (state->period !=3D cur_state.period) {
>
> Did you test this with more than one consumer? For sure the following
> should work:
>
>         pwm1 =3D pwm_get(.. the first ..);
>         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 10000000, =
.... });
>
>         pwm2 =3D pwm_get(.. the second ..);
>         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 10000000, =
.... });
>
> but for the second pwm_apply_state() run state->period is likely not
> exactly 10000000.

Yes, I have tested multiple consumers using sysfs interface. It is working.

>
> > +             if (pwm->user_count !=3D 1) {
> > +                     ret =3D -EINVAL;
>
> EBUSY?

ok

>
> > +                     goto exit;
> > +             }
> > +             pwm->real_period =3D state->period;
> > +             pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
>
> It's not ensured that pwm->clk is enabled here which is a pre-condition
> to be allowed to call clk_get_rate().

Will fix this

>
> > +     }
> > +
> > +     duty_cycle =3D state->duty_cycle;
> > +     if (!state->enabled)
> > +             duty_cycle =3D 0;
> > +
> > +     x =3D 1U << PWM_SIFIVE_CMPWIDTH;
>
> "x" is a bad name.
>
> > +     num =3D (u64)duty_cycle * x + x / 2;
> > +     frac =3D div_u64(num, state->period);
>
> I don't understand the "+ x / 2" part. Should this better be
> "+ state->period / 2"? Something like

This eqn is as per your comments against v5 of this patch series.
 frac =3D (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 <<
PWM_SIFIVE_CMPWIDTH) / 2) / period;

>
> #define div_u64_round(a, b) ({typeof(b) __b =3D b; div_u64(a + __b / 2, _=
_b)})
>
> would make this less error prone.
>
> > +     /* The hardware cannot generate a 100% duty cycle */
> > +     frac =3D min(frac, x - 1);
> > +
> > +     writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +            dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     if (!state->enabled && enabled) {
> > +             ret =3D pwm_sifive_enable(chip, false);
> > +             if (ret)
> > +                     goto exit;
> > +             enabled =3D false;
> > +     }
> > +
> > +     if (state->enabled && !enabled) {
> > +             ret =3D pwm_sifive_enable(chip, state->enabled);
> > +             if (ret)
> > +                     goto exit;
> > +     }
>
> These two ifs can be combined to:
>
>         if (state->enabled !=3D enabled)
>                 ret =3D pwm_sifive_enable(chip, state->enabled);

Ok, will do that

>
> > +
> > +exit:
> > +     mutex_unlock(&pwm->lock);
> > +     return ret;
> > +}
> > +
> > +static const struct pwm_ops pwm_sifive_ops =3D {
> > +     .request =3D pwm_sifive_request,
> > +     .free =3D pwm_sifive_free,
> > +     .get_state =3D pwm_sifive_get_state,
> > +     .apply =3D pwm_sifive_apply,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int pwm_sifive_clock_notifier(struct notifier_block *nb,
> > +                                  unsigned long event, void *data)
> > +{
> > +     struct clk_notifier_data *ndata =3D data;
> > +     struct pwm_sifive_ddata *pwm =3D
> > +             container_of(nb, struct pwm_sifive_ddata, notifier);
> > +
> > +     if (event =3D=3D POST_RATE_CHANGE)
> > +             pwm_sifive_update_clock(pwm, ndata->new_rate);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int pwm_sifive_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct pwm_sifive_ddata *pwm;
> > +     struct pwm_chip *chip;
> > +     struct resource *res;
> > +     int ret, ch;
> > +     bool is_enabled =3D false;
> > +
> > +     pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> > +     if (!pwm)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&pwm->lock);
> > +     chip =3D &pwm->chip;
> > +     chip->dev =3D dev;
> > +     chip->ops =3D &pwm_sifive_ops;
> > +     chip->of_pwm_n_cells =3D 3;
> > +     chip->base =3D -1;
> > +     chip->npwm =3D 4;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     pwm->regs =3D devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(pwm->regs)) {
> > +             dev_err(dev, "Unable to map IO resources\n");
> > +             return PTR_ERR(pwm->regs);
> > +     }
> > +
> > +     pwm->clk =3D devm_clk_get(dev, NULL);
> > +     if (IS_ERR(pwm->clk)) {
> > +             if (PTR_ERR(pwm->clk) !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "Unable to find controller clock\n")=
;
> > +             return PTR_ERR(pwm->clk);
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(pwm->clk);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable clock for pwm: %d\n", ret)=
;
> > +             return ret;
> > +     }
> > +
> > +     /* Watch for changes to underlying clock frequency */
> > +     pwm->notifier.notifier_call =3D pwm_sifive_clock_notifier;
> > +     ret =3D clk_notifier_register(pwm->clk, &pwm->notifier);
> > +     if (ret) {
> > +             dev_err(dev, "failed to register clock notifier: %d\n", r=
et);
> > +             goto disable_clk;
> > +     }
> > +
> > +     ret =3D pwmchip_add(chip);
> > +     if (ret < 0) {
> > +             dev_err(dev, "cannot register PWM: %d\n", ret);
> > +             goto unregister_clk;
> > +     }
>
> After pwmchip_add is called the first consumer might appear...
>
> > +     /* Initialize PWM */
> > +     pwm->real_period =3D PWM_SIFIVE_DEFAULT_PERIOD;
> > +     pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> > +
> > +     for (ch =3D 0; ch < pwm->chip.npwm; ch++) {
> > +             if (pwm_is_enabled(&pwm->chip.pwms[ch])) {
> > +                     is_enabled =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     if (!is_enabled)
> > +             clk_disable(pwm->clk);
>
> ... so this should better be called after these initialisations.
> (This also means you must not use pwm_is_enabled(), but I'd consider that
> an upside, because this function is for PWM consumers, not
> implementors.)

Ok, will change the sequence.

>
> > +     platform_set_drvdata(pdev, pwm);
> > +     dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> > +
> > +     return 0;
> > +
> > +unregister_clk:
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +disable_clk:
> > +     clk_disable_unprepare(pwm->clk);
> > +
> > +     return ret;
> > +}
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
