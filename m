From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: Re: [PATCH] pwm: sunxi: wait for the READY bit
Date: Tue, 3 Jan 2017 16:56:16 +0100
Message-ID: <73f5fc87-717f-2238-b653-1b117359cbb8@schinagl.nl>
References: <20170103145732.2108-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103145732.2108-1-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hey Alexandre,

I've sent several patches regarding pwm a while ago, sadly you never 
responded [0]. So I guess this is a follow up from that?

I couldn't quickly find the resubmitted version however.

Anyway, see below for my comments.

On 03-01-17 15:57, Alexandre Belloni wrote:
> Most of the call sites in the kernel are not really prepared to handle
> -EBUSY when calling pwm_config(). This means that they will either fail
> silently or fail without letting the user retry at a later time.
>
> This can be seen for example when using pwm-backlight (the most common use
> case for this driver). It will first call pwm_config() with a 0 duty cycle
> and disable the pwm. Then it will call pwm_config() that fails because the
> pwm had no chance to update its period internally and
> pwm_enable() ending up with a duty cycle of 0.
>
> Instead, actually wait for the RDY bit to go low before continuing.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index b0803f6c64d9..be489388e006 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -103,7 +104,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u32 prd, dty, val, clk_gate;
>  	u64 clk_rate, div = 0;
>  	unsigned int prescaler = 0;
> -	int err;
> +	int err = 0;
>
>  	clk_rate = clk_get_rate(sun4i_pwm->clk);
>
> @@ -154,18 +155,22 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>
> -	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
> -		spin_unlock(&sun4i_pwm->ctrl_lock);
> -		clk_disable_unprepare(sun4i_pwm->clk);
> -		return -EBUSY;
> -	}
> -
>  	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> -	if (clk_gate) {
> -		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +
> +	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
> +		val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>  		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +
> +		err = readl_poll_timeout(sun4i_pwm->base + PWM_CTRL_REG, val,
> +					 !(val & PWM_RDY(pwm->hwpwm)), 400,
> +					 500000);
> +		if (err)
> +			goto finish;
>  	}
>
What happens on sun4i here? sun4i does not have the RDY flag, but it 
does need the PWM_CLK_GATING to be active.

maybe only the readl_poll_timeout() should be guarded by the has_rdy, 
where you poll the register as you do now, and in the else just have a 
'known safe delay' to emulate the has_rdy behavior? I'm guessing a few 
clock cycles of the PWM block. I don't think the documentation states 
how long this could/should be.

With my 'wait before disable' patch [1] I run into the same issue, I 
think. We do not know how long to wait before the hardware is ready.

> +	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +
>  	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  	val &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
>  	val |= BIT_CH(prescaler, pwm->hwpwm);
> @@ -174,6 +179,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	val = (dty & PWM_DTY_MASK) | PWM_PRD(prd);
>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>
> +finish:
>  	if (clk_gate) {
>  		val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  		val |= clk_gate;
> @@ -183,7 +189,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	spin_unlock(&sun4i_pwm->ctrl_lock);
>  	clk_disable_unprepare(sun4i_pwm->clk);
>
> -	return 0;
> +	return err;
>  }
>
>  static int sun4i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>

[0] https://patchwork.kernel.org/patch/9299635/
[1] https://lkml.org/lkml/2016/9/26/91
