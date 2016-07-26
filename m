From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pwm: cros_ec: add __packed to prevent padding
Date: Tue, 26 Jul 2016 12:03:02 -0700
Message-ID: <20160726190302.GA7388@dtor-ws>
References: <1469557333-9497-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469557333-9497-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Gwendal Grignou <gwendal@chromium.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jul 26, 2016 at 11:22:13AM -0700, Brian Norris wrote:
> While the particular usage in question is likely safe (struct
> cros_ec_command is 32-bit aligned, followed by <=32-bit fields), it's
> been suggested this is not a great pattern to follow for the general
> case -- for example, if we follow a 'struct cros_ec_command' (which is
> 32-bit- but not 64-bit-aligned) with a struct that starts with a 64-bit
> type (e.g., u64), the compiler may add padding.
> 
> Let's add __packed, to inform the compiler of our true intention -- to
> have no padding between these struct elements -- and to future proof for
> any refactorings that might occur.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Hi Thierry,
> 
> I don't know of any bugs directly resolved by this patch, so take it for
> v4.8/v4.9 at your discretion.
> 
>  drivers/pwm/pwm-cros-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 99b9acc1a420..f6ca4e8c6253 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -38,7 +38,7 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
>  	struct {
>  		struct cros_ec_command msg;
>  		struct ec_params_pwm_set_duty params;
> -	} buf;
> +	} __packed buf;
>  	struct ec_params_pwm_set_duty *params = &buf.params;
>  	struct cros_ec_command *msg = &buf.msg;
>  
> @@ -65,7 +65,7 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
>  			struct ec_params_pwm_get_duty params;
>  			struct ec_response_pwm_get_duty resp;
>  		};
> -	} buf;
> +	} __packed buf;
>  	struct ec_params_pwm_get_duty *params = &buf.params;
>  	struct ec_response_pwm_get_duty *resp = &buf.resp;
>  	struct cros_ec_command *msg = &buf.msg;
> -- 
> 2.8.0.rc3.226.g39d4020
> 

-- 
Dmitry
