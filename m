From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Fri, 27 May 2016 18:54:29 +0200
Message-ID: <20160527185429.70f6821d@bbrezillon>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34139 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755559AbcE0Qyc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 May 2016 12:54:32 -0400
In-Reply-To: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>

On Fri, 27 May 2016 09:45:49 -0700
Brian Norris <briannorris@chromium.org> wrote:

> It seems like in the process of refactoring pwm_config() to utilize the
> newly-introduced pwm_apply_state() API, some args/bounds checking was
> dropped.
> 
> In particular, I noted that we are now allowing invalid period
> selections. e.g.:
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
> This patch reintroduces some bounds checks in both pwm_config() (for its
> signed parameters; we don't want to convert negative values into large
> unsigned values) and in pwm_apply_state() (which fix the above described
> behavior, as well as other potential API misuses).
> 
> Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks,

Boris

> ---
> v2:
>  * changed subject, as this covers more scope now
>  * add Fixes tag, as this is a v4.7-rc regression
>  * add more bounds/args checks in pwm_apply_state() and pwm_config()
> 
>  drivers/pwm/core.c  | 3 ++-
>  include/linux/pwm.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dba3843c53b8..ed337a8c34ab 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  {
>  	int err;
>  
> -	if (!pwm)
> +	if (!pwm || !state || !state->period ||
> +	    state->duty_cycle > state->period)
>  		return -EINVAL;
>  
>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 17018f3c066e..908b67c847cd 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -235,6 +235,9 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
>  	if (!pwm)
>  		return -EINVAL;
>  
> +	if (duty_ns < 0 || period_ns < 0)
> +		return -EINVAL;
> +
>  	pwm_get_state(pwm, &state);
>  	if (state.duty_cycle == duty_ns && state.period == period_ns)
>  		return 0;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
