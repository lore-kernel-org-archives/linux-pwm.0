From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 6/6] pwm: update comment on struct pwm_ops::apply
Date: Sun, 6 Oct 2019 22:00:19 -0700
Message-ID: <CAOCOHw7TXj2zr7qoown0rM=W0dns4n1o+9gOHr_8=vebzH=bMw@mail.gmail.com>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk> <20191004133207.6663-7-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004133207.6663-7-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Oct 4, 2019 at 6:33 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Commit 71523d1812ac (pwm: Ensure pwm_apply_state() doesn't modify the
> state argument) updated the kernel-doc for pwm_apply_state(), but not
> for the ->apply callback in the pwm_ops struct.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

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
> - *        should be adjusted with the real hardware config (if the
> - *        approximate the period or duty_cycle value, state should
> - *        reflect it)
> + * @apply: atomically apply a new PWM config
>   * @get_state: get the current PWM state. This function is only
>   *            called once per PWM device when the PWM chip is
>   *            registered.
> --
> 2.20.1
>
