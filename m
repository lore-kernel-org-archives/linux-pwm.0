Return-path: <mgross@linux.intel.com>
Date: Thu, 17 Sep 2020 13:59:42 -0700
From: mark gross <mgross@linux.intel.com>
Message-ID: <20200917205942.GE4535@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
Subject: Re: [PATCH v7 0/2] Add PWM support for Intel Keem Bay SoC
To: vijayakannan.ayyathurai@intel.com
Cc: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
List-ID: <linux-pwm.vger.kernel.org>

Have I reviewed this yet?
are you waiting on feedback?
--mark

On Thu, Sep 10, 2020 at 12:27:17AM +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> Hi,
> 
> This patch set enables support for PWM on the Intel Keem Bay SoC.
> Keem Bay is an ARM based SoC, and the GPIO module allows
> configuration of 6 PWM outputs.
> 
> Patch 1 adds the PWM driver and Patch 2 is for the required
> Device Tree bindings documentation.
> 
> This driver was tested on the Keem Bay evaluation module board.
> 
> Thank you.
> 
> Regards,
> Vijay
> 
> Changes since v6:
> - Add reviewed-by tag
> 
> Changes since v5:
> -Reorder symbols/Kconfig in drivers/pwm/Kconfig and drivers/pwm/Makefile
> -Use "Limitations" for consistency
> -Add clk_prepare_enable()
> -Reorder keembay_pwm_get_state() function call
> -Rework if conditional for channel disablement in .apply()
> -Remove channel disabling from .probe(), and clear LEADIN register bits
> in .apply instead
> -Update commit message for Patch 1
> 
> Changes since v4:
> -Add co-developed-by tag
> -Include mod_devicetable.h and remove of.h
> -Update comment with correct calulation for high/low time
> -Fix missing return from dev_err_probe
> 
> Changes since v3:
> -Removed variable for address and calculate in place instead
> -Utilized u32_replace_bits() when updating KMB_PWM_LEADIN_OFFSET
> -Utilized dev_err_probe() for error reporting
> -Updated comments to use physical units
> -Updated error check for pwmchip_add()
> 
> Changes since v2:
> -Include documentation about HW limitation/behaviour
> -Use hex values for KMB_PWM_COUNT_MAX
> -Redefine register macros
> -Utilize FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and
> pwm_count
> -Round up duty cycle/period values
> -Get current hardware state in .apply instead of cached values
> -Do a polarity check before .enabled
> -Round high time/low time to closest value
> -Set enable bit in KMB_PWM_LEADIN_OFFSET to 0 in probe
> -Correct the naming for MODULE_ALIAS
> -Add additionalProperties: false in DT bindings
> 
> Changes since v1:
> -Updated licensing info, "clocks" property and example in DT bindings
> -Updated name of DT bindings document to match compatible string
> -Removed 1 patch for addition of new sysfs attribute "count"
> -Added support for COMPILE_TEST in Kconfig
> -Updated naming of defines and regmap attribute
> -Updated calculation of waveform high time and low time
> -Added range checking for waveform high/low time
> -Implemented .get_state
> -Removed register writes for lead-in and count values (left to default)
> -Updated register access to single-access
> -Folded keembay_pwm_enable/disable_channel,
> keembay_pwm_config_period/duty_cycle,
>  and keembay_pwm_config into keembay_pwm_apply
> -Updated error messages/error codes
> -Removed pwm_disable from keembay_pwm_remove
> -Removed clk_prepare/clk_enable/clk_disable from driver
> 
> Lai, Poey Seng (1):
>   pwm: Add PWM driver for Intel Keem Bay
> 
> Vineetha G. Jaya Kumaran (1):
>   dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
> 
> .../bindings/pwm/intel,keembay-pwm.yaml       |  47 ++++
>  drivers/pwm/Kconfig                           |   9 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-keembay.c                     | 232 ++++++++++++++++++
>  4 files changed, 289 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-keembay.c
> 
> -- 
> 2.17.1
> 
