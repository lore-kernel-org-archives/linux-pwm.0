From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v7 08/13] pwm: sifive: Use 64-bit division macros for period and duty cycle
Date: Thu, 26 Mar 2020 09:37:43 -0700 (PDT)
Message-ID: <mhng-29ba8348-64c8-4113-ac65-1e81c0a1da70@palmerdabbelt-glaptop1>
References: <4212f82b8711b2b33f0e71142526d5a7575564e9.1583782035.git.gurus@codeaurora.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4212f82b8711b2b33f0e71142526d5a7575564e9.1583782035.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, uwe@kleine-koenig.org, subbaram@codeaurora.org, linux-kernel@vger.kernel.org, gurus@codeaurora.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, yash.shah@sifive.com, Atish Patra <Atish.Patra@wdc.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 09 Mar 2020 12:35:11 PDT (-0700), gurus@codeaurora.org wrote:
> Because period and duty cycle are defined in the PWM framework structs
> as ints with units of nanoseconds, the maximum time duration that can be
> set is limited to ~2.147 seconds. Redefining them as u64 values will
> enable larger time durations to be set.
>
> As a first step, prepare drivers to handle the switch to u64 period and
> duty_cycle by replacing division operations involving pwm period and duty cycle
> with their 64-bit equivalents as appropriate. The actual switch to u64 period
> and duty_cycle follows as a separate patch.
>
> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
> macros:
> - DIV_ROUND_UP_ULL
> - DIV_ROUND_CLOSEST_ULL
> - div_u64
>
> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
> DIV64_* macros:
> - DIV64_U64_ROUND_CLOSEST
> - div64_u64
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: Yash Shah <yash.shah@sifive.com>
> Cc: Atish Patra <atish.patra@wdc.com>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-sifive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index cc63f9b..62de0bb 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -181,7 +181,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * consecutively
>  	 */
>  	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> -	frac = DIV_ROUND_CLOSEST_ULL(num, state->period);
> +	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
>  	/* The hardware cannot generate a 100% duty cycle */
>  	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
