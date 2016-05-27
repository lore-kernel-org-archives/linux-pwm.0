From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] pwm: don't allow duty cycle higher than period
Date: Fri, 27 May 2016 09:34:39 +0200
Message-ID: <20160527093439.5ad237c5@bbrezillon>
References: <1464296730-121773-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48089 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751451AbcE0Hem (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 May 2016 03:34:42 -0400
In-Reply-To: <1464296730-121773-1-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>

Hi Brian,

On Thu, 26 May 2016 14:05:30 -0700
Brian Norris <briannorris@chromium.org> wrote:

> It doesn't make sense to allow the duty cycle to be larger than the
> period. I can see this behavior by, e.g.:
> 
>   # echo 1 > /sys/class/pwm/pwmchip0/export
>   # cat /sys/class/pwm/pwmchip0/pwm1/period
>   100
>   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>   [... driver may or may not reject the value, or trigger some logic bug ...]
> 
> It's better to see:
> 
>   # echo 1 > /sys/class/pwm/pwmchip0/export
>   # cat /sys/class/pwm/pwmchip0/pwm1/period
>   100
>   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>   -bash: echo: write error: Invalid argument
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/pwm/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dba3843c53b8..9246b60f894a 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -463,6 +463,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
>  		return 0;
>  
> +	if (state->duty_cycle > state->period)
> +		return -EINVAL;
> +

Argh, I forgot to move the pwm_config() checks [1] into
pwm_apply_state() :-/.

I think we should check all the corner cases (see this diff [2]),
once done you can add my

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thierry, can you include that in your material for 4.7-rc1?

Thanks,

Boris

[1]http://lxr.free-electrons.com/source/drivers/pwm/core.c#L443
[2]http://code.bulix.org/wtqja4-99473
-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
