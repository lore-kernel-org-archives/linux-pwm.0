From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
Date: Thu, 7 Mar 2019 16:23:29 -0800
Message-ID: <CAKwvOdkrDcfOnf8gevj4-83Kk2o-hyX56A-cpJMf-hnWJe5hXg@mail.gmail.com>
References: <20190307223628.21270-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307223628.21270-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 7, 2019 at 2:36 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
>
> The final else if functions as an else; make that explicit so that Clang
> understands that timebase cannot be used uninitialized.

A welcome simplification! Thank you.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/400
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 815f5333bb8f..1cc5fbe1e1d3 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         } else if (mul <= max_timebase * 512) {
>                 div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
>                 timebase = DIV_ROUND_UP(mul, 512);
> -       } else if (mul > max_timebase * 512) {
> +       } else {
>                 dev_err(chip->dev,
>                         "failed to configure timebase steps/divider value\n");
>                 return -EINVAL;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
