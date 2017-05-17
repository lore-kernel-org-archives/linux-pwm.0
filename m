From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [pwm] question about potential division by zero
Date: Wed, 17 May 2017 10:33:56 +0200
Message-ID: <89269556-bb5d-b2bf-b44c-a078d6ca274a@gmail.com>
References: <20170516165653.Horde.Xe6MBOoWtIt1Jni0nYqF1GM@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516165653.Horde.Xe6MBOoWtIt1Jni0nYqF1GM@gator4166.hostgator.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 16/05/17 23:56, Gustavo A. R. Silva wrote:
> 
> Hello everybody,
> 
> While looking into Coverity ID 1408721 I ran into the following piece of 
> code at /drivers/pwm/pwm-mediatek.c:77:
> 
>   77static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device 
> *pwm,
>   78                          int duty_ns, int period_ns)
>   79{
>   80        struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
>   81        struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
>   82        u32 resolution, clkdiv = 0;
>   83
>   84        resolution = NSEC_PER_SEC / clk_get_rate(clk);
>   85
>   86        while (period_ns / resolution > 8191) {
>   87                resolution *= 2;
>   88                clkdiv++;
>   89        }
>   90
>   91        if (clkdiv > 7)
>   92                return -EINVAL;
>   93
>   94        mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | 
> clkdiv);
>   95        mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / 
> resolution);
>   96        mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
>   97
>   98        return 0;
>   99}
> 
> The issue here is that in case _clk_ is null, function clk_get_rate() at 
> line 84 will return zero and a division by zero will occur.
> 
> So my question here is if there is any chance for _clk_ to be null at 
> line 81, hence ending up triggering a division by zero at line 84?

No it can't, in the probe function will error out if one of the seven 
clocks are not found.

for (i = 0; i < MTK_CLK_MAX; i++) {
	pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
	if (IS_ERR(pc->clks[i]))
		return PTR_ERR(pc->clks[i]);
}

It registers a pwm chip with five PWMs. When the config function is 
called one of the five PWMs is identified (with a value from 0-4) which 
correspondents to the MTK_CLK_PWM[1-5], so no bug here neither.

Regards,
Matthias

> 
> I'm trying to figure out if this is a false positive or something that 
> needs to be fixed.
> 
> I'd really appreciate any comment on this.
> 
> Thank you
> -- 
> Gustavo A. R. Silva
> 
> 
> 
> 
