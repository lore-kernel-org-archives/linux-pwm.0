From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] backlight: add PWM dependencies
Date: Thu, 06 Feb 2014 16:23:48 +0900
Message-ID: <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <000401cf222f$43263b20$c972b160$%han@samsung.com>
 <CACRpkdbB8LFM0Vu8VRo4niqxwxUdS-c5gmmWaxbUTbnLCLZbMA@mail.gmail.com>
 <000101cf2307$97a3c770$c6eb5650$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <000101cf2307$97a3c770$c6eb5650$%han@samsung.com>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Linus Walleij' <linus.walleij@linaro.org>, 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Eric Miao' <eric.y.miao@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Jingoo Han' <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Thursday, February 06, 2014 3:50 PM, Jingoo Han wrote:
> On Wednesday, February 05, 2014 5:58 PM, Linus Walleij wrote:
> > On Wed, Feb 5, 2014 at 6:01 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> > > On Tuesday, February 04, 2014 9:57 PM, Linus Walleij wrote:
> > >>
> > >> In some compilations the LM3630A and LP855X backlight drivers
> > >> fail like this:
> > >>
> > >> drivers/built-in.o: In function `lm3630a_pwm_ctrl':
> > >> drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
> > >> drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
> > >> drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
> > >> drivers/built-in.o: In function `lp855x_pwm_ctrl':
> > >> drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
> > >> drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
> > >> drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'
> > >>
> > >> This is because both drivers depend on the PWM framework, so
> > >> add this dependency to their Kconfig entries.
> > >
> > > However, even though, when CONFIG_PWM is not enabled, the problem
> > > should not happen. pwm_config(),pwm_disable(), and pwm_enable()
> > > are already defined for CONFIG_PWM=n case as below.
> >
> > So you may think but it does happen :-)
> >
> > I reproduced this with the defconfig for ARM pxa255-idp and enabling
> > all boards for that platform, then enabling all available backlight drivers
> > as compiled-in objects (y).
> 
> However, I cannot reproduce it with mainline kernel 3.14-rc1.
> 
> 1. make pxa255-idp_defconfig
> 2. Enabling all boards
>    (System Type -> Intel PXA2xx/PXA3xx Implementations -> ...)
> 3. Enabling all available backlight drivers as compiled-in objects (y)
> 
> In this case, the LM3630A and LP855X backlight drivers are compiled
> properly as below:
> 
>   drivers/video/backlight/lm3630a_bl.o
>   drivers/video/backlight/lp855x_bl.o
> 
> Would you check it with mainline kernel 3.14-rc1?
> If the errors happen, please attach the .config file.

(+cc Arnd Bergmann)

Oh, sorry. There was my mistake.
I tested this with linux-next tree.

With linux 3.14-rc1, it makes the problem as below.

drivers/built-in.o: In function `lm3630a_pwm_ctrl':
drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
drivers/built-in.o: In function `lp855x_pwm_ctrl':
drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'

> 
> >
> > > ./include/linux/pwm.h
> > > #if IS_ENABLED(CONFIG_PWM) || IS_ENABLED(CONFIG_HAVE_PWM)
> > >         .....
> > > #else
> >
> > Hm PXA that I am using defines CONFIG_HAVE_PWM, but doesn't
> > provide the required signatures (pwm_config/pwm_disable/pwm_enable).
> >
> > One of two things is wrong:
> >
> > - Either the PXA platform is breaking the CONFIG_HAVE_PWM
> >   contract by not providing pwm_config/pwm_disable/pwm_enable
> >   functions. Then HAVE_PWM should be removed from the PXA
> >   Kconfig selects.
> >
> > Or:
> >
> > - There is no such contract that these functions must exist if
> >   CONFIG_HAVE_PWM is defined, and the
> >   #if IS_ENABLED(CONFIG_HAVE_PWM)
> >   should be removed from <linux/pwm.h>
> >
> > Does anyone know which one it is?
> >
> > PWM subsystem maintainer? :-)

Thierry Reding,
Would you confirm this?

In the case of "CONFIG_HAVE_PWM=y && CONFIG_PWM=n", it makes
the problem.

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. PXA looks to
use the generic PWM framework. Then, how about removing
"select HAVE_PWM" from PXA as below?

--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -7,7 +7,6 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 config MACH_PXA3XX_DT
        bool "Support PXA3xx platforms from device tree"
        select CPU_PXA300
-       select HAVE_PWM
        select POWER_SUPPLY
        select PXA3xx
        select USE_OF
@@ -23,12 +22,10 @@ config ARCH_LUBBOCK

 config MACH_MAINSTONE
        bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
-       select HAVE_PWM
        select PXA27x

 config MACH_ZYLONITE
        bool
-       select HAVE_PWM
        select PXA3xx
.....


Best regards,
Jingoo Han
