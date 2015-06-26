From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
 control
Date: Fri, 26 Jun 2015 18:31:37 +0200
Message-ID: <20150626163137.GB30960@phenom.ffwll.local>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Linus Walleij <linus.walleij@linaro.org>, varkabhadram@gmail.com, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 26, 2015 at 02:32:03PM +0530, Shobhit Kumar wrote:
> Hi,
> Next update of the series reviewed at 
> https://lkml.org/lkml/2015/6/22/155
> 
> Major changes are few review comments from Varka and Ville being addressed. Also except
> for intel-gfx patches, all patches reviesion history is moved out of commit message.
> 
> Hope this series finally finds its mark.
> 
> Regards
> Shobhit
> 
> Shobhit Kumar (7):
>   gpiolib: Add support for removing registered consumer lookup table
>   mfd: intel_soc_pmic_core: Add lookup table for Panel Control as GPIO
>     signal
>   mfd: intel_soc_pmic_crc: Add PWM cell device for Crystalcove PMIC
>   mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC based PWM
>   pwm: crc: Add Crystalcove (CRC) PWM driver
>   drm/i915: Use the CRC gpio for panel enable/disable
>   drm/i915: Backlight control using CRC PMIC based PWM driver

I think we have r-b/acks on all the patches now. Ok if I pull this in
through drm-intel.git for 4.3? Or should I make a topic branch with tag
and then send out pull requests to everyone? Or will each maintainer merge
on their own since it's all only coupled at runtime anyway? Any of these
would suit me.

Thanks, Daniel

> 
>  drivers/gpio/gpiolib.c             |  13 ++++
>  drivers/gpu/drm/i915/intel_bios.h  |   7 ++
>  drivers/gpu/drm/i915/intel_drv.h   |   4 ++
>  drivers/gpu/drm/i915/intel_dsi.c   |  37 +++++++++-
>  drivers/gpu/drm/i915/intel_dsi.h   |   3 +
>  drivers/gpu/drm/i915/intel_panel.c |  94 ++++++++++++++++++++++--
>  drivers/mfd/intel_soc_pmic_core.c  |  29 ++++++++
>  drivers/mfd/intel_soc_pmic_crc.c   |   3 +
>  drivers/pwm/Kconfig                |   7 ++
>  drivers/pwm/Makefile               |   1 +
>  drivers/pwm/pwm-crc.c              | 143 +++++++++++++++++++++++++++++++++++++
>  include/linux/gpio/machine.h       |   1 +
>  12 files changed, 335 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/pwm/pwm-crc.c
> 
> -- 
> 1.9.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
