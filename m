From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
Date: Tue, 21 Jun 2016 05:11:07 +0300
Message-ID: <b499570f-e624-cbe1-4fca-44ba0e701054@mleia.com>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Sylvain,

On 03.06.2016 22:37, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
> disable the PWM, the PWM output is always set as a logic 1.
> 
> Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> and a 0 logic level was apply to the output.
> 
> According to the LPC32x0 User Manual [1],
> the default value for bit 30 (PWM_PIN_LEVEL) is 0.
> 
> This change initialize the pin level to 0 (default value) and
> update the register value accordingly during the disable process.
> 
> [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

It looks like a pin control setting, but because it depends
on PWM enabled/disabled status, I suppose it is good enough to
manage it from the PWM driver.

I think here a new optional DTS property should be introduced,
which if present indicates that PWM_OUT pin value is high when
PWM is disabled. And if the property is not found then
PWMx_PIN_LEVEL is set to 0 on driver probe.

By convention the property name should be prefixed by "nxp,",
what name is good? May be "nxp,pwm-disabled-level-high" ?
Or add a property "nxp,pwm-disabled-level" with valid values 0/1?

Also note someone may want to switch the default behaviour
in runtime, but this feature may be added later on.

> ---
>  drivers/pwm/pwm-lpc32xx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
> index 4d470c1..dbf93a1 100644
> --- a/drivers/pwm/pwm-lpc32xx.c
> +++ b/drivers/pwm/pwm-lpc32xx.c
> @@ -22,9 +22,11 @@ struct lpc32xx_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	void __iomem *base;
> +	unsigned int pin_state;
>  };
>  
>  #define PWM_ENABLE	BIT(31)
> +#define PWM_PIN_LEVEL	BIT(30)
>  
>  #define to_lpc32xx_pwm_chip(_chip) \
>  	container_of(_chip, struct lpc32xx_pwm_chip, chip)
> @@ -85,7 +87,14 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	u32 val;
>  
>  	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
> -	val &= ~PWM_ENABLE;
> +	val &= ~(PWM_ENABLE | PWM_PIN_LEVEL);
> +
> +	/*
> +	 * When the PWM is disable, we have to ensure the output is configured
> +	 * correctly:
> +	 */
> +	if(lpc32xx->pin_state)
> +		val |= PWM_PIN_LEVEL;
>  	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
>  
>  	clk_disable_unprepare(lpc32xx->clk);
> @@ -121,6 +130,7 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
>  	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
>  	lpc32xx->chip.npwm = 1;
>  	lpc32xx->chip.base = -1;
> +	lpc32xx->pin_state = 0;
>  
>  	ret = pwmchip_add(&lpc32xx->chip);
>  	if (ret < 0) {
> 

--
With best wishes,
Vladimir
