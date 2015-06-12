From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] pwm: Add support for R-Car PWM Timer
Date: Fri, 12 Jun 2015 14:06:01 +0200
Message-ID: <20150612120600.GM19400@ulmo.nvidia.com>
References: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1432205846-4312-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KSn4sQg3MnruwCB4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432205846-4312-3-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--KSn4sQg3MnruwCB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 07:57:26PM +0900, Yoshihiro Shimoda wrote:
[...]
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
[...]
> +#define to_rcar_pwm_chip(chip)	container_of(chip, struct rcar_pwm_chip, chip)

For consistency with other drivers I'd like this to be a static inline
function.

> +
> +static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data, u32 reg)
> +{
> +	iowrite32(data, rp->base + reg);
> +}
> +
> +static u32 rcar_pwm_read(struct rcar_pwm_chip *rp, u32 reg)
> +{
> +	return ioread32(rp->base + reg);
> +}

ioread*() and iowrite*() are to be used for devices that can be on a
memory-mapped bus or an I/O mapped bus. I suspect that this particular
IP block doesn't fall into that category, so it should be using the
regular readl()/writel() instead.

> +static void rcar_pwm_bit_modify(struct rcar_pwm_chip *rp,
> +				u32 mask, u32 data, u32 reg)

You should try to fill up lines as much as you can: mask and data should
still fit on the first line.

> +{
> +	u32 val = rcar_pwm_read(rp, reg);
> +
> +	val &= ~mask;
> +	val |= data & mask;
> +	rcar_pwm_write(rp, val, reg);
> +}
> +
> +static int rcar_pwn_get_clock_division(struct rcar_pwm_chip *rp,

Typo: "pwn" -> "pwm"

> +				       int period_ns)
> +{
> +	int div;

Perhaps make this unsigned int?

> +	unsigned long clk_rate = clk_get_rate(rp->clk);
> +	unsigned long long max;	/* max cycle / nanoseconds */

I think you want to check for clk_rate == 0 here and return an error.
Otherwise the do_div() call below may try to divide by 0.

> +	for (div = 0; div <= RCAR_PWM_MAX_DIVISION; div++) {
> +		max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
> +			(1 << div);
> +		do_div(max, clk_rate);
> +		if (period_ns < max)
> +			break;
> +	}
> +
> +	return div;
> +}
> +
> +static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp, int div)
> +{
> +	u32 val = rcar_pwm_read(rp, RCAR_PWMCR);
> +
> +	if (div > RCAR_PWM_MAX_DIVISION)
> +		return;

Shouldn't you return an error here (and propagate it later on) if an
invalid value is passed in? Or perhaps even avoid calling this function
with an invalid value in the first place? As it is, you're silently
ignoring cases where an invalid value is being passed in. That'll leave
anybody working with this driver completely puzzled when it doesn't
behave the way they expect it too. And it gives users no indication
about what went wrong.

> +
> +	val &= ~(RCAR_PWMCR_CCMD | RCAR_PWMCR_CC0_MASK);
> +	if (div & 1)
> +		val |= RCAR_PWMCR_CCMD;
> +	div >>= 1;
> +	val |= div << RCAR_PWMCR_CC0_SHIFT;
> +	rcar_pwm_write(rp, val, RCAR_PWMCR);
> +}
> +
> +static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div,
> +				 int duty_ns, int period_ns)
> +{
> +	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
> +	unsigned long clk_rate = clk_get_rate(rp->clk);
> +	u32 cyc, ph;
> +
> +	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
> +	do_div(one_cycle, clk_rate);
> +
> +	tmp = period_ns * 100ULL;
> +	do_div(tmp, one_cycle);
> +	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
> +
> +	tmp = duty_ns * 100ULL;
> +	do_div(tmp, one_cycle);
> +	ph = tmp & RCAR_PWMCNT_PH0_MASK;
> +
> +	/* Avoid prohibited setting */
> +	if (cyc && ph)
> +		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);

So if a period and duty-cycle are passed in that yield the prohibited
setting the operation will simply be silently ignored?

> +}
> +
> +static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +
> +	return clk_prepare_enable(rp->clk);
> +}
> +
> +static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +
> +	clk_disable_unprepare(rp->clk);
> +}
> +
> +static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +	int div;
> +
> +	div = rcar_pwn_get_clock_division(rp, period_ns);

The above three lines can be collapsed into a single one.

> +
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> +	rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
> +	rcar_pwm_set_clock_control(rp, div);
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> +
> +	return 0;
> +}
> +
> +static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +	u32 pwmcnt;
> +
> +	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
> +	pwmcnt = rcar_pwm_read(rp, RCAR_PWMCNT);
> +	if (!(pwmcnt & RCAR_PWMCNT_CYC0_MASK) ||
> +	    !(pwmcnt & RCAR_PWMCNT_PH0_MASK))
> +		return -EINVAL;
> +
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_EN0, RCAR_PWMCR_EN0, RCAR_PWMCR);
> +
> +	return 0;
> +}
> +
> +static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> +}
> +
> +static const struct pwm_ops rcar_pwm_ops = {
> +	.request	= rcar_pwm_request,
> +	.free		= rcar_pwm_free,
> +	.config		= rcar_pwm_config,
> +	.enable		= rcar_pwm_enable,
> +	.disable	= rcar_pwm_disable,
> +	.owner		= THIS_MODULE,
> +};

No need for this padding. Single spaces around = are good enough.

> +
> +static int rcar_pwm_probe(struct platform_device *pdev)
> +{
> +	struct rcar_pwm_chip *rcar_pwm;
> +	struct resource *res;
> +	int ret;
> +
> +	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
> +	if (rcar_pwm == NULL)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rcar_pwm->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rcar_pwm->base))
> +		return PTR_ERR(rcar_pwm->base);
> +
> +	rcar_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rcar_pwm->clk)) {
> +		dev_err(&pdev->dev, "cannot get clock\n");
> +		return PTR_ERR(rcar_pwm->clk);
> +	}
> +
> +	platform_set_drvdata(pdev, rcar_pwm);
> +
> +	rcar_pwm->chip.dev = &pdev->dev;
> +	rcar_pwm->chip.ops = &rcar_pwm_ops;
> +	rcar_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> +	rcar_pwm->chip.base = -1;
> +	rcar_pwm->chip.npwm = 1;
> +
> +	ret = pwmchip_add(&rcar_pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register PWM chip\n");
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "R-Car PWM Timer registered\n");

No need to brag about success. Expect that things will go well and let
users know when they don't. Output error messages, not success messages.

> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int rcar_pwm_remove(struct platform_device *pdev)
> +{
> +	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = pwmchip_remove(&rcar_pwm->chip);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_disable(&pdev->dev);

Perhaps you'd still like to disable runtime PM even if the chip can't be
removed?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rcar_pwm_of_table[] = {
> +	{ .compatible = "renesas,pwm-rcar", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);

No blank line between the above two.

Thierry

--KSn4sQg3MnruwCB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVesslAAoJEN0jrNd/PrOhOoUQAJo+TiOuWfL7IabY6UtFcjjk
kS16UELoQbnHF4jpHjybwC5FuCn33jbn8urqQDydrVBNioNgTxdXjLBRwDayYuut
/K0AuS1u1xHuljk459eef0PsXbwiX9yyR04jSJj2DOxQdZ88iKMdJmyyyAztHaN5
sy+u/3ttB1VNujwg1k7BXjGfEXwAoklRCV8p1lOOg0O6H5dFyST2wFZJIWD+QDtq
TgzxSl1WMmBZN2AvjV+zaregHPPXIU58zne7CiGpWUyG1+Pfwx7cNO8XhivD0wg+
oi9YvSUHv/UAZcDVtrFjMPANWBvkJmsV44KL3SaJH1EB8goVxUpOicoUiQVYmONF
sW/u2hkoBfSYvR128+acsfUFIflL7eZx3ysq7IodGHoskGnWJ/JmXcqzMKeorLr7
AeXFl6KnqDPvJ9ceRRGPSH824iguTGjfnhQaZWCjWpYwWeve6uDyRoXY0mrIq5QY
7GE+58aEy6j1EMxDq/vE8T13c+AYh3or/MMTbcuokZpyVrOPX9yGQlodKY8C6nvR
JZ4YBFD0XV/ZUcYq2UgWfYQwRLE293/ooL9KD3/XpcNkAaTBN468DB66NCEw/ptr
cBFeQsN5n7B5KZx0u+s7REAR3SGNlGec4gfZ7zyxfz9T0JKCN0GFjHcvYWLrxlQS
D8sXceUdxwFTiGfBi2+C
=64Nx
-----END PGP SIGNATURE-----

--KSn4sQg3MnruwCB4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
