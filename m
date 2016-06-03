From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 08/14] pwm: sti: Avoid glitches on already running PWMs
Date: Fri, 3 Jun 2016 13:38:48 -0700
Message-ID: <20160603203848.GF124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-9-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1464942192-25967-9-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@stlinux.com, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Doug Anderson <dianders@google.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 03, 2016 at 10:23:06AM +0200, Boris Brezillon wrote:
> The current logic will disable the PWM clk even if a PWM was left
> enabled by the bootloader (because it's controlling a critical device
> like a regulator for example).
> Keep the PWM clk enabled if at least one PWM is enabled to avoid any
> glitches.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-sti.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 6300d3e..8232c5b 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -340,7 +340,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	struct sti_pwm_compat_data *cdata;
>  	struct sti_pwm_chip *pc;
>  	struct resource *res;
> -	int ret;
> +	int i, ret;
>  
>  	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>  	if (!pc)
> @@ -391,7 +391,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	ret = clk_prepare(pc->clk);
> +	ret = clk_prepare_enable(pc->clk);
>  	if (ret) {
>  		dev_err(dev, "failed to prepare clock\n");
>  		return ret;
> @@ -409,6 +409,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/*
> +	 * Keep the PWM clk enabled if some PWMs appear to be up and
> +	 * running.
> +	 */
> +	for (i = 0; i < pc->chip.npwm; i++) {
> +		struct pwm_state state;
> +
> +		pwm_get_state(&pc->chip.pwms[i], &state);
> +		if (state.enabled)

Similar to pwm-rockchip: you could just do if (pwm_is_enabled(...)).

Brian

> +			clk_enable(pc->clk);
> +	}
> +	clk_disable(pc->clk);
> +
>  	platform_set_drvdata(pdev, pc);
>  
>  	return 0;
> -- 
> 2.7.4
> 
