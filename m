From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Wed, 22 Jun 2016 12:16:59 -0700
Message-ID: <20160622191658.GA106497@google.com>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
 <CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
 <20160621183730.GA130978@google.com>
 <20160622100422.5c34f975@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160622100422.5c34f975@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jun 22, 2016 at 10:04:22AM +0200, Boris Brezillon wrote:
> From 0610f7e24976e176054bce20445ff42d8aea9513 Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Wed, 22 Jun 2016 09:25:14 +0200
> Subject: [PATCH] pwm: Fix pwm_apply_args()
> 
> Commit 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic
> updates"), implemented pwm_disable() as a wrapper around
> pwm_apply_state(), and then, commit ef2bf4997f7d ("pwm: Improve args
> checking in pwm_apply_state()") added missing checks on the ->period
> value in pwm_apply_state() to ensure we were not passing inappropriate
> values to the ->config() or ->apply() methods.
> 
> The conjunction of these 2 commits led to a case where pwm_disable()
> was no longer succeeding, thus preventing the polarity setting done
> in pwm_apply_args().
> 
> Set a valid period in pwm_apply_args() to ensure polarity setting
> won't be rejected.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")
> ---
>  include/linux/pwm.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 908b67c847cd..c038ae36b10e 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -464,6 +464,8 @@ static inline bool pwm_can_sleep(struct pwm_device *pwm)
>  
>  static inline void pwm_apply_args(struct pwm_device *pwm)
>  {
> +	struct pwm_state state = { };
> +
>  	/*
>  	 * PWM users calling pwm_apply_args() expect to have a fresh config
>  	 * where the polarity and period are set according to pwm_args info.
> @@ -476,18 +478,20 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
>  	 * at startup (even if they are actually enabled), thus authorizing
>  	 * polarity setting.
>  	 *
> -	 * Instead of setting ->enabled to false, we call pwm_disable()
> -	 * before pwm_set_polarity() to ensure that everything is configured
> -	 * as expected, and the PWM is really disabled when the user request
> -	 * it.

I was confused by this original text when reading it the first time. I
like the replacement text and implementation, as it seems to make more
sense.

> +	 * To fulfill this requirement, we apply a new state which disables
> +	 * the PWM device and set the reference period and polarity config.
>  	 *
>  	 * Note that PWM users requiring a smooth handover between the
>  	 * bootloader and the kernel (like critical regulators controlled by
>  	 * PWM devices) will have to switch to the atomic API and avoid calling
>  	 * pwm_apply_args().
>  	 */
> -	pwm_disable(pwm);
> -	pwm_set_polarity(pwm, pwm->args.polarity);

Notably, you're dropping the 'if (!pwm) { }' safety checks that are part
of pwm_disable() and pwm_set_polarity(). But I don't think there should
be any users relying on that.

> +
> +	state.enabled = false;
> +	state.polarity = pwm->args.polarity;
> +	state.period = pwm->args.period;
> +
> +	pwm_apply_state(pwm, &state);
>  }
>  
>  struct pwm_lookup {

Reviewed-by: Brian Norris <briannorris@chromium.org>
