From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] FIXUP: CHROMIUM: fix transposed param settings
Date: Fri, 23 Jun 2017 13:23:15 -0700
Message-ID: <20170623202313.GA122611@google.com>
References: <20170622175439.81256-1-nvaccaro@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622175439.81256-1-nvaccaro@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Vaccaro <nvaccaro@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Nick,

When sending patches to kernel mailing lists, we don't use prefixes like
"CHROMIUM" -- those only apply to Chrome OS kernel trees, to indicate
patches that should be specific to the Chromium (OS) project and not
necessarily upstream Linux.

Here, you want to follow the patterns used by the subsystem. This is
sort of covered in the Documentation/process/ directory:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

Or you might look at 'git log drivers/pwm/ here.

i.e., this might have a subject:

[PATCH] pwm: cros-ec: fix transposed param settings

On Thu, Jun 22, 2017 at 10:54:39AM -0700, Nick Vaccaro wrote:
> The __cros_ec_pwm_get_duty() routine was transposing the insize and
> outsize fields when calling cros_ec_cmd_xfer_status().
> 
> The original code worked without error due to size of the two particular
> parameter blocks passed to cros_ec_cmd_xfer_status(), so this change is
> not fixing an actual runtime problem, just correcting the calling usage.
> 
> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> ---

Patch looks good:

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  drivers/pwm/pwm-cros-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 2e4ab20cfb83..de5b7c9860b6 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -75,8 +75,8 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
>  
>  	msg->version = 0;
>  	msg->command = EC_CMD_PWM_GET_DUTY;
> -	msg->insize = sizeof(*params);
> -	msg->outsize = sizeof(*resp);
> +	msg->insize = sizeof(*resp);
> +	msg->outsize = sizeof(*params);
>  
>  	params->pwm_type = EC_PWM_TYPE_GENERIC;
>  	params->index = index;
