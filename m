From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [pwm] question about potential division by zero
Date: Tue, 16 May 2017 16:56:53 -0500
Message-ID: <20170516165653.Horde.Xe6MBOoWtIt1Jni0nYqF1GM@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


Hello everybody,

While looking into Coverity ID 1408721 I ran into the following piece  
of code at /drivers/pwm/pwm-mediatek.c:77:

  77static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
  78                          int duty_ns, int period_ns)
  79{
  80        struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
  81        struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
  82        u32 resolution, clkdiv = 0;
  83
  84        resolution = NSEC_PER_SEC / clk_get_rate(clk);
  85
  86        while (period_ns / resolution > 8191) {
  87                resolution *= 2;
  88                clkdiv++;
  89        }
  90
  91        if (clkdiv > 7)
  92                return -EINVAL;
  93
  94        mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
  95        mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
  96        mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
  97
  98        return 0;
  99}

The issue here is that in case _clk_ is null, function clk_get_rate()  
at line 84 will return zero and a division by zero will occur.

So my question here is if there is any chance for _clk_ to be null at  
line 81, hence ending up triggering a division by zero at line 84?

I'm trying to figure out if this is a false positive or something that  
needs to be fixed.

I'd really appreciate any comment on this.

Thank you
--
Gustavo A. R. Silva
