From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] backlight: add PWM dependencies
Date: Thu, 06 Feb 2014 15:49:33 +0900
Message-ID: <000101cf2307$97a3c770$c6eb5650$%han@samsung.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <000401cf222f$43263b20$c972b160$%han@samsung.com>
 <CACRpkdbB8LFM0Vu8VRo4niqxwxUdS-c5gmmWaxbUTbnLCLZbMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CACRpkdbB8LFM0Vu8VRo4niqxwxUdS-c5gmmWaxbUTbnLCLZbMA@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Linus Walleij' <linus.walleij@linaro.org>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Eric Miao' <eric.y.miao@gmail.com>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pwm@vger.kernel.org

On Wednesday, February 05, 2014 5:58 PM, Linus Walleij wrote:
> On Wed, Feb 5, 2014 at 6:01 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Tuesday, February 04, 2014 9:57 PM, Linus Walleij wrote:
> >>
> >> In some compilations the LM3630A and LP855X backlight drivers
> >> fail like this:
> >>
> >> drivers/built-in.o: In function `lm3630a_pwm_ctrl':
> >> drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
> >> drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
> >> drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
> >> drivers/built-in.o: In function `lp855x_pwm_ctrl':
> >> drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
> >> drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
> >> drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'
> >>
> >> This is because both drivers depend on the PWM framework, so
> >> add this dependency to their Kconfig entries.
> >
> > However, even though, when CONFIG_PWM is not enabled, the problem
> > should not happen. pwm_config(),pwm_disable(), and pwm_enable()
> > are already defined for CONFIG_PWM=n case as below.
> 
> So you may think but it does happen :-)
> 
> I reproduced this with the defconfig for ARM pxa255-idp and enabling
> all boards for that platform, then enabling all available backlight drivers
> as compiled-in objects (y).

However, I cannot reproduce it with mainline kernel 3.14-rc1.

1. make pxa255-idp_defconfig
2. Enabling all boards
   (System Type -> Intel PXA2xx/PXA3xx Implementations -> ...)
3. Enabling all available backlight drivers as compiled-in objects (y)

In this case, the LM3630A and LP855X backlight drivers are compiled
properly as below:

  drivers/video/backlight/lm3630a_bl.o
  drivers/video/backlight/lp855x_bl.o

Would you check it with mainline kernel 3.14-rc1?
If the errors happen, please attach the .config file.

Best regards,
Jingoo Han

> 
> > ./include/linux/pwm.h
> > #if IS_ENABLED(CONFIG_PWM) || IS_ENABLED(CONFIG_HAVE_PWM)
> >         .....
> > #else
> 
> Hm PXA that I am using defines CONFIG_HAVE_PWM, but doesn't
> provide the required signatures (pwm_config/pwm_disable/pwm_enable).
> 
> One of two things is wrong:
> 
> - Either the PXA platform is breaking the CONFIG_HAVE_PWM
>   contract by not providing pwm_config/pwm_disable/pwm_enable
>   functions. Then HAVE_PWM should be removed from the PXA
>   Kconfig selects.
> 
> Or:
> 
> - There is no such contract that these functions must exist if
>   CONFIG_HAVE_PWM is defined, and the
>   #if IS_ENABLED(CONFIG_HAVE_PWM)
>   should be removed from <linux/pwm.h>
> 
> Does anyone know which one it is?
> 
> PWM subsystem maintainer? :-)
> 
> Yours,
> Linus Walleij
