From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] pwm: ftm: use flat regmap cache
Date: Thu, 07 Apr 2016 13:11:20 -0700
Message-ID: <8ff78a1435de405578e77451658dac77@agner.ch>
References: <1453344982-4529-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:32768 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbcDGUOj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Apr 2016 16:14:39 -0400
In-Reply-To: <1453344982-4529-1-git-send-email-stefan@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: Xiubo.Lee@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>

Hi Thierry,

This seems not to have made it into 4.6-rc1, any chance to get it still
into 4.6?

It seems also to resolve an issue when using cat on the debug file:
# cat /sys/kernel/debug/regmap/40039000.pwm/registers 

[  326.707319] Unhandled fault: external abort on non-linefetch (0x1008)
at 0x9083e01c
[  326.715097] pgd = 8de50000
[  326.717848] [9083e01c] *pgd=8f805811, *pte=40039653, *ppte=40039453
[  326.724222] Internal error: : 1008 [#3] ARM
[  326.728445] Modules linked in:
[  326.731556] CPU: 0 PID: 19407 Comm: cat Tainted: G      D 4.6.0-rc1
#359

This is gone when using REGCACHE_FLAT...

--
Stefan


On 2016-01-20 18:56, Stefan Agner wrote:
> Use flat regmap cache to avoid lockdep warning at probe:
> [    0.697285] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2755
> lockdep_trace_alloc+0x15c/0x160()
> [    0.697449] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> 
> The RB-tree regmap cache needs to allocate new space on first
> writes. However, allocations in an atomic context (e.g. when a
> spinlock is held) are not allowed. The function regmap_write
> calls map->lock, which acquires a spinlock in the fast_io case.
> Since the pwm-fsl-ftm driver uses MMIO, the regmap bus of type
> regmap_mmio is being used which has fast_io set to true.
> 
> The MMIO space of the pwm-fsl-ftm driver is reasonable condense,
> hence using the much faster flat regmap cache is anyway the better
> choice.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index f9dfc8b..ed39e8e 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -414,7 +414,7 @@ static const struct regmap_config fsl_pwm_regmap_config = {
>  
>  	.max_register = FTM_PWMLOAD,
>  	.volatile_reg = fsl_pwm_volatile_reg,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_FLAT,
>  };
>  
>  static int fsl_pwm_probe(struct platform_device *pdev)
