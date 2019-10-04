From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 6/6] pwm: update comment on struct pwm_ops::apply
Date: Fri, 4 Oct 2019 16:09:14 +0200
Message-ID: <20191004140914.paljfpruoob5y54x@pengutronix.de>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
 <20191004133207.6663-7-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004133207.6663-7-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Oct 04, 2019 at 03:32:07PM +0200, Rasmus Villemoes wrote:
> Commit 71523d1812ac (pwm: Ensure pwm_apply_state() doesn't modify the
> state argument) updated the kernel-doc for pwm_apply_state(), but not
> for the ->apply callback in the pwm_ops struct.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/pwm.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b2c9c460947d..0ef808d925bb 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -243,10 +243,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
>   * @request: optional hook for requesting a PWM
>   * @free: optional hook for freeing a PWM
>   * @capture: capture and report PWM signal
> - * @apply: atomically apply a new PWM config. The state argument
> - *	   should be adjusted with the real hardware config (if the
> - *	   approximate the period or duty_cycle value, state should
> - *	   reflect it)
> + * @apply: atomically apply a new PWM config

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
