From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 2/2] gpio: mvebu: fix gpio bank registration when pwm is used
Date: Tue, 30 May 2017 15:16:59 +0200
Message-ID: <87y3tetrg4.fsf@free-electrons.com>
References: <20170530122848.2803-1-richard.genoud@gmail.com>
        <20170530122848.2803-2-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170530122848.2803-2-richard.genoud@gmail.com> (Richard
        Genoud's message of "Tue, 30 May 2017 14:28:48 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi Richard,
 
 On mar., mai 30 2017, Richard Genoud <richard.genoud@gmail.com> wrote:

> If more than one gpio bank has the "pwm" property, only one will be
> registered successfully, all the others will fail with:
> mvebu-gpio: probe of f1018140.gpio failed with error -17
>
> That's because in alloc_pwms(), the chip->base (aka "int pwm"), was not
> set (thus, ==0) ; and 0 is a meaningful start value in alloc_pwm().
> What was intended is chip->base = -1.
> Like that, the numbering will be done auto-magically
>
> Tested on clearfog-pro (Marvell 88F6828)
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/gpio/gpio-mvebu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index cdef2c78cb3b..4734923e11fd 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -768,6 +768,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  	mvpwm->chip.dev = dev;
>  	mvpwm->chip.ops = &mvebu_pwm_ops;
>  	mvpwm->chip.npwm = mvchip->chip.ngpio;
> +	mvpwm->chip.base = -1;

Why not using
mvpwm->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;
as it is done in the mvebu_gpio_probe() function?

I think that if you use base = -1, then the number start from (512 -
number of pin already use). So starting from a low number for one
compatible and a high number for an other compatible could be confusing.

Besides that I agree that mvpwm->chip.base must be initialized and here
again for adding mor context to this patch, we could add:

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")

Gregory

>  
>  	spin_lock_init(&mvpwm->lock);
>  

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
