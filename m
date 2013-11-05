Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1383620560-3567-1-git-send-email-sangjung.woo@samsung.com>
References: <1383620560-3567-1-git-send-email-sangjung.woo@samsung.com>
Date: Tue, 5 Nov 2013 09:17:24 +0530
Message-ID: <CAK9yfHye0PNxVmuANymK9qE9rqejZh7hy-PANFYV1_O7dqp93g@mail.gmail.com>
Subject: Re: [PATCH] pwm: samsung: memory leak bugfix in pwm_samsung_free
From: Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Sangjung Woo <sangjung.woo@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Tomasz Figa <t.figa@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>

Hi Sangjung,

On 5 November 2013 08:32, Sangjung Woo <sangjung.woo@samsung.com> wrote:
> There is certainly a kind of memory leak since allocated data (i.e.
> chip_data) is set NULL before freeing it by calling devm_kfree(). This
> patch fixes the memory leak bug by modifying its call order.
>
> Signed-off-by: Sangjung Woo <sangjung.woo@samsung.com>
> Reviewed-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index fcc8b9a..07b2d9d 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -224,8 +224,8 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
>
>  static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -       pwm_set_chip_data(pwm, NULL);
>         devm_kfree(chip->dev, pwm_get_chip_data(pwm));
> +       pwm_set_chip_data(pwm, NULL);
>  }

Similar patch has already been applied by Thierry.

-- 
With warm regards,
Sachin
