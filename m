From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [Intel-gfx] [PATCH 6/8] drivers/pwm: Add Crystalcove (CRC) PWM
 driver
Date: Thu, 18 Jun 2015 20:41:56 +0200
Message-ID: <1434652916.2385.124.camel@x220>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
	 <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
	 <1430428322.2187.24.camel@x220>
	 <CAAbrOmc-71MO2N9sezbOONPAf8_XSCOtHBSGD9AS9hOk0vsE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAbrOmc-71MO2N9sezbOONPAf8_XSCOtHBSGD9AS9hOk0vsE=A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <kumar@shobhit.info>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hi Shobhit,

On Thu, 2015-06-18 at 23:24 +0530, Shobhit Kumar wrote:
> On Fri, May 1, 2015 at 2:42 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > On Wed, 2015-04-29 at 19:30 +0530, Shobhit Kumar wrote:
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >
> >> +config PWM_CRC
> >> +     bool "Intel Crystalcove (CRC) PWM support"
> >> +     depends on X86 && INTEL_SOC_PMIC
> >> +     help
> >> +       Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
> >> +       control.
> >
> >> --- a/drivers/pwm/Makefile
> >> +++ b/drivers/pwm/Makefile
> >
> >> +obj-$(CONFIG_PWM_CRC)                += pwm-crc.o
> >
> > PWM_CRC is a bool symbol. So pwm-crc.o can never be part of a module.
> 
> I actually started this as a module but later decided to make it as
> bool because INTEL_SOC_PMIC on which this depends is itself a bool as
> well.

As does GPIO_CRYSTAL_COVE and that's a tristate. So?

> Still it is good to keep the module based initialization.
> Firstly because it causes no harm

If I got a dime for every time people used an argument like that I ... I
could treat myself to an ice cream. A really big ice cream. Hmm, that
doesn't sound too impressive. But still, "causes no harm" is below the
bar for kernel code. Kernel code needs to add value.

> and even though some of the macros
> are pre-processed out, gives info about the driver.

None of which can't be gotten elsewhere (ie, the commit message, or the
file these macro reside in).

> Secondly there
> were discussion on why INTEL_SOC_PMIC is bool (note this driver also
> has module based initialization even when bool).

Yes, there's copy and paste going on even in kernel development.

> I am guessing because
> of some tricky module load order dependencies. If ever that becomes a
> module, this can mostly be unchanged to be loaded as a module.

You put in a macro, or any other bit of code, when it's needed, not
beforehand, "just in case". That's silly.

Thanks,


Paul Bolle

