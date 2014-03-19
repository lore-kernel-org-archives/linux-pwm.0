From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 09/16] avr32/at32ap: switch to the generic PWM framework
Date: Wed, 19 Mar 2014 15:18:20 +0100
Message-ID: <20140319141820.GA20872@samfundet.no>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-10-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1395234209-15546-10-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bryan Wu <cooloney@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Around Wed 19 Mar 2014 14:03:22 +0100 or thereabout, Alexandre Belloni wrote:
> Switch to the pwm/pwm-atmel driver instead of misc/atmel_pwm
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/mach-at32ap/at32ap700x.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> index a1f4d1e91b52..db85b5ec3351 100644
> --- a/arch/avr32/mach-at32ap/at32ap700x.c
> +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> @@ -1553,7 +1553,7 @@ static struct resource atmel_pwm0_resource[] __initdata = {
>  	IRQ(24),
>  };
>  static struct clk atmel_pwm0_mck = {
> -	.name		= "pwm_clk",
> +	.name		= "at91sam9rl-pwm",

I found this a tiny bit weird, but found the matching instance in
drivers/pwm/pwm-atmel.c

IMHO it would initially have been better to call it atpwm_v1 or something
similar, more generic. But I guess that is too late to change at this point.

>  	.parent		= &pbb_clk,
>  	.mode		= pbb_clk_mode,
>  	.get_rate	= pbb_clk_get_rate,
> @@ -1568,7 +1568,7 @@ struct platform_device *__init at32_add_device_pwm(u32 mask)
>  	if (!mask)
>  		return NULL;
>  
> -	pdev = platform_device_alloc("atmel_pwm", 0);
> +	pdev = platform_device_alloc("at91sam9rl-pwm", 0);
>  	if (!pdev)
>  		return NULL;
>  
> @@ -1576,9 +1576,6 @@ struct platform_device *__init at32_add_device_pwm(u32 mask)
>  				ARRAY_SIZE(atmel_pwm0_resource)))
>  		goto out_free_pdev;
>  
> -	if (platform_device_add_data(pdev, &mask, sizeof(mask)))
> -		goto out_free_pdev;
> -
>  	pin_mask = 0;
>  	if (mask & (1 << 0))
>  		pin_mask |= (1 << 28);
-- 
mvh
Hans-Christian Egtvedt
