From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v3 1/5] pwm: add the Berlin pwm controller driver
Date: Tue, 18 Aug 2015 13:33:03 +0200
Message-ID: <20150818113303.GC3261@kwain>
References: <1439387497-6863-1-git-send-email-antoine.tenart@free-electrons.com>
 <1439387497-6863-2-git-send-email-antoine.tenart@free-electrons.com>
 <55CB565C.8050906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33524 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750928AbbHRLdH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Aug 2015 07:33:07 -0400
Content-Disposition: inline
In-Reply-To: <55CB565C.8050906@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Sebastian,

On Wed, Aug 12, 2015 at 04:21:16PM +0200, Sebastian Hesselbarth wrote:
> On 08/12/2015 03:51 PM, Antoine Tenart wrote:
> >Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> >controller has 4 channels.
> >
> >Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>=20
> nice rework, but...
>=20
> [...]
> >diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> >new file mode 100644
> >index 000000000000..f89e25ea5c6d
> >--- /dev/null
> >+++ b/drivers/pwm/pwm-berlin.c
> >@@ -0,0 +1,227 @@
> [...]
> >+#define BERLIN_PWM_ENABLE		BIT(0)
> >+#define BERLIN_PWM_DISABLE		0x0
>=20
> I'd drop BERLIN_PWM_DISABLE and use reg & ~BERLIN_PWM_ENABLE below.
> Even if there are no more writable bits in that register, IMHO it
> is good practice to affect as little bits as possible.

Sure.

> [...]
> >+/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> >+static const u32 prescaler_diff_table[] =3D {
> >+	1, 4, 2, 2, 4, 4, 4, 4,
> >+};
> >+
> >+static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> >+			     int duty_ns, int period_ns)
> >+{
> >+	struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> >+	int ret, prescale =3D 0;
> >+	u32 val, duty, period;
> >+	u64 cycles;
> >+
> >+	cycles =3D clk_get_rate(berlin_chip->clk);
> >+	cycles *=3D period_ns;
> >+	do_div(cycles, NSEC_PER_SEC);
> >+
> >+	while (cycles > BERLIN_PWM_MAX_TCNT)
> >+		do_div(cycles, prescaler_diff_table[++prescale]);
> >+
> >+	if (cycles > BERLIN_PWM_MAX_TCNT)
> >+		return -EINVAL;
>=20
> Does my idea actually work? Did you test it with some different
> pwm frequencies?

I tested, and it worked well with different pwm frequencies!

> >+	period =3D cycles;
> >+	cycles *=3D duty_ns;
> >+	do_div(cycles, period_ns);
> >+	duty =3D cycles;
> >+
> >+	ret =3D clk_prepare_enable(berlin_chip->clk);
> >+	if (ret)
> >+		return ret;
>=20
> Hmm. I understand that this may be required as the pwm framework
> calls .pwm_config before .pwm_enable, but...
>=20
> >+
> >+	spin_lock(&berlin_chip->lock);
> >+
> >+	val =3D berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTR=
OL);
> >+	val &=3D ~BERLIN_PWM_PRESCALE_MASK;
> >+	val |=3D prescale;
> >+	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL=
);
> >+
> >+	berlin_pwm_writel(duty, berlin_chip, pwm->hwpwm, BERLIN_PWM_DUTY);
> >+	berlin_pwm_writel(period, berlin_chip, pwm->hwpwm, BERLIN_PWM_TCNT=
);
> >+
> >+	spin_unlock(&berlin_chip->lock);
> >+
> >+	clk_disable_unprepare(berlin_chip->clk);
>=20
> Are you sure that register contents are retained after disabling the
> clock? I understand that cfg_clk is the _ip_ input clock and pwm gets
> derived from it.
>=20
> Actually, since cfg_clk seems to be an important, internal SoC clock
> I'd say to clk_prepare_enable() in _probe() before reading any
> registers and clk_disable_unprepare() on _remove() (see below).

I'll update.

>=20
> Internal low-frequency clocks don't consume that much power that it
> is worth the pain ;)
>=20
> >+	return 0;
> >+}
> >+
> >+static int berlin_pwm_set_polarity(struct pwm_chip *chip,
> >+				   struct pwm_device *pwm,
> >+				   enum pwm_polarity polarity)
> >+{
> >+	struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> >+	int ret;
> >+	u32 val;
> >+
> >+	ret =3D clk_prepare_enable(berlin_chip->clk);
> >+	if (ret)
> >+		return ret;
>=20
> These would become unnecessary then.
>=20
> >+	spin_lock(&berlin_chip->lock);
> >+
> >+	val =3D berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTR=
OL);
> >+
> >+	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> >+		val &=3D ~BERLIN_PWM_INVERT_POLARITY;
> >+	else
> >+		val |=3D BERLIN_PWM_INVERT_POLARITY;
> >+
> >+	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL=
);
> >+
> >+	spin_unlock(&berlin_chip->lock);
> >+
> >+	clk_disable_unprepare(berlin_chip->clk);
>=20
> ditto.
>=20
> >+	return 0;
> >+}
> >+
> >+static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
> >+{
> >+	struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> >+	int ret;
> >+
> >+	ret =3D clk_prepare_enable(berlin_chip->clk);
> >+	if (ret)
> >+		return ret;
>=20
> ditto.
>=20
> >+	spin_lock(&berlin_chip->lock);
> >+	berlin_pwm_writel(BERLIN_PWM_ENABLE, berlin_chip, pwm->hwpwm, BERL=
IN_PWM_EN);
> >+	spin_unlock(&berlin_chip->lock);
> >+
> >+	return 0;
> >+}
> >+
> >+static void berlin_pwm_disable(struct pwm_chip *chip, struct pwm_de=
vice *pwm)
> >+{
> >+	struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> >+
> >+	spin_lock(&berlin_chip->lock);
> >+	berlin_pwm_writel(BERLIN_PWM_DISABLE, berlin_chip, pwm->hwpwm, BER=
LIN_PWM_EN);
> >+	spin_unlock(&berlin_chip->lock);
> >+
> >+	clk_disable_unprepare(berlin_chip->clk);
>=20
> ditto.
>=20
> >+}
> >+
> >+static const struct pwm_ops berlin_pwm_ops =3D {
> >+	.config =3D berlin_pwm_config,
> >+	.set_polarity =3D berlin_pwm_set_polarity,
> >+	.enable =3D berlin_pwm_enable,
> >+	.disable =3D berlin_pwm_disable,
> >+	.owner =3D THIS_MODULE,
> >+};
> >+
> >+static const struct of_device_id berlin_pwm_match[] =3D {
> >+	{ .compatible =3D "marvell,berlin-pwm" },
> >+	{ },
> >+};
> >+MODULE_DEVICE_TABLE(of, berlin_pwm_match);
> >+
> >+static int berlin_pwm_probe(struct platform_device *pdev)
> >+{
> >+	struct berlin_pwm_chip *pwm;
> >+	struct resource *res;
> >+	int ret;
> >+
> >+	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> >+	if (!pwm)
> >+		return -ENOMEM;
> >+
> >+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> >+	if (IS_ERR(pwm->base))
> >+		return PTR_ERR(pwm->base);
> >+
> >+	pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> >+	if (IS_ERR(pwm->clk))
> >+		return PTR_ERR(pwm->clk);
> >+
> >+	pwm->chip.dev =3D &pdev->dev;
> >+	pwm->chip.ops =3D &berlin_pwm_ops;
> >+	pwm->chip.base =3D -1;
> >+	pwm->chip.npwm =3D 4;
> >+	pwm->chip.can_sleep =3D true;
> >+	pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> >+	pwm->chip.of_pwm_n_cells =3D 3;
> >+
> >+	spin_lock_init(&pwm->lock);
>=20
> add clk_prepare_enable() before adding the pwmchip...
>=20
> >+	ret =3D pwmchip_add(&pwm->chip);
> >+	if (ret < 0) {
> >+		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> >+		return ret;
> >+	}
> >+
> >+	platform_set_drvdata(pdev, pwm);
> >+
> >+	return 0;
> >+}
> >+
> >+static int berlin_pwm_remove(struct platform_device *pdev)
> >+{
> >+	struct berlin_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> >+
> >+	return pwmchip_remove(&pwm->chip);
>=20
> ... and clk_disable_unprepare after removing it.
>=20
> Besides the comments, for Berlin you get my
>=20
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks!

Antoine

>=20
> >+}
> >+
> >+static struct platform_driver berlin_pwm_driver =3D {
> >+	.probe	=3D berlin_pwm_probe,
> >+	.remove	=3D berlin_pwm_remove,
> >+	.driver	=3D {
> >+		.name	=3D "berlin-pwm",
> >+		.of_match_table =3D berlin_pwm_match,
> >+	},
> >+};
> >+module_platform_driver(berlin_pwm_driver);
> >+
> >+MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>")=
;
> >+MODULE_DESCRIPTION("Marvell Berlin PWM driver");
> >+MODULE_LICENSE("GPL v2");
> >

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
