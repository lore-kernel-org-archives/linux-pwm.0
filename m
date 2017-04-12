From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Wed, 12 Apr 2017 16:31:28 +0200
Message-ID: <20170412163128.5c985a26@free-electrons.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
        <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hello,

Sorry for the late feedback about this.

On Sun,  9 Apr 2017 20:09:27 +0200, Ralph Sennhauser wrote:

> +		gpio1: gpio@18140 {
> +			compatible = "marvell,armada-370-xp-gpio";
> +			reg = <0x18140 0x40>, <0x181c8 0x08>;

One issue I see is that you have only two counters A and B. You
associate counter A with the first bank of GPIOs, and counter B with
the second bank of GPIOs.

Which means that if you need to PWM a GPIO from the third bank of
GPIOs, you can't, even if the HW allows it.

While I'm fine with not supporting all the HW features, but it's a bit
sad that this gets encoded into the DT.

But I guess the only way to make this possible would be to have a
single node for all GPIOs rather than one per bank? Or do we have a way
to have those counter A/B registers bound to a separate PWM driver, and
then the GPIO driver being smart enough to select the counter to be
used? Seems not easy to do though :-/


> +struct mvebu_pwm {
> +	void __iomem		*membase;
> +	unsigned long		 clk_rate;
> +	bool			 used;
> +	struct pwm_chip		 chip;
> +	spinlock_t		 lock;
> +	struct mvebu_gpio_chip	*mvchip;
> +
> +	/* Used to preserve GPIO/PWM registers across suspend/resume */
> +	u32			 blink_select;
> +	u32			 blink_on_duration;
> +	u32			 blink_off_duration;
> +};
> +
>  struct mvebu_gpio_chip {
>  	struct gpio_chip   chip;
>  	spinlock_t	   lock;
> @@ -87,6 +113,10 @@ struct mvebu_gpio_chip {
>  	struct irq_domain *domain;
>  	int		   soc_variant;
>  
> +	/* Used for PWM support */
> +	struct clk	  *clk;
> +	struct mvebu_pwm  *mvpwm;

Why does mvpwm needs to be allocated separately? Why not directly embed
it inside the mvebu_gpio_chip structure?

Do we need a separate spinlock?


> @@ -555,6 +842,10 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
>  		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
>  	},
>  	{
> +		.compatible = "marvell,armada-370-xp-gpio",
> +		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,

Whum, what are you doing here?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
