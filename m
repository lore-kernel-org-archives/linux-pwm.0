From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] ARM: SAMSUNG: remove gpio flags in dev-backlight
Date: Thu, 10 Apr 2014 18:51:45 +0900
Message-ID: <000701cf54a2$7c1379c0$743a6d40$%han@samsung.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
 <1393480414-19473-2-git-send-email-acourbot@nvidia.com>
 <CAAVeFu+XUzZ7ozMOcp6A-gZJ9o8DZFrdh1j4LvCQtoTcu=PP1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAAVeFu+XUzZ7ozMOcp6A-gZJ9o8DZFrdh1j4LvCQtoTcu=PP1g@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Alexandre Courbot' <gnurou@gmail.com>, 'Alexandre Courbot' <acourbot@nvidia.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Ben Dooks' <ben-linux@fluff.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pwm@vger.kernel.org

On Thursday, April 10, 2014 1:17 PM, Alexandre Courbot wrote:
> 
> Ping, can I have the Samsung folks review and ,aybe even merge this
> patch? enable_gpio_flags is never used in any code, is replaced by
> gpiod, and we would like to remove it altogether from pwm_bl. Thanks!

OK, I see. It looks good.

As far as I know, 'enable_gpio_flags' has not been being used
for Samsung platform. So, there will be no side effect,
if 'enable_gpio_flags' is removed from 'arch/arm/plat-samsung'
directory.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> Alex.
> 
> On Thu, Feb 27, 2014 at 2:53 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> > The pwm-backlight driver is moving to use the gpiod interface,
> > which has its own mapping mechanism for platform data GPIOs.
> > These mappings carry GPIO properties like active low so they don't have
> > to be explicitly handled by GPIO consumers.
> >
> > Because of this change, the enable_gpio_flags member of
> > platform_pwm_backlight_data is going away. dev-backlight was passing
> > this member, but had no user making use of it, so it can safely be
> > removed. Further GPIOs used by pwm-backlight are expected to be
> > defined using the mechanisms provided by the gpiod API.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> >  arch/arm/plat-samsung/dev-backlight.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
> > index be4ad0b21c08..2157c5b539e6 100644
> > --- a/arch/arm/plat-samsung/dev-backlight.c
> > +++ b/arch/arm/plat-samsung/dev-backlight.c
> > @@ -124,8 +124,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
> >                 samsung_bl_data->pwm_period_ns = bl_data->pwm_period_ns;
> >         if (bl_data->enable_gpio >= 0)
> >                 samsung_bl_data->enable_gpio = bl_data->enable_gpio;
> > -       if (bl_data->enable_gpio_flags)
> > -               samsung_bl_data->enable_gpio_flags = bl_data->enable_gpio_flags;
> >         if (bl_data->init)
> >                 samsung_bl_data->init = bl_data->init;
> >         if (bl_data->notify)
> > --
> > 1.9.0
