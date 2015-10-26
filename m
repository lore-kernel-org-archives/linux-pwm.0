From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
Date: Tue, 27 Oct 2015 07:06:24 +0800
Message-ID: <201510270750.ajpxgYw1%fengguang.wu@intel.com>
References: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: kbuild-all@01.org, Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Olliver,

[auto build test WARNING on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/pwm-lpc18xx_pwm-use-pwm_set_chip_data/20151027-053853
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/clk-pwm.c:89:25: sparse: not enough arguments for function pwm_config
   drivers/clk/clk-pwm.c: In function 'clk_pwm_probe':
   drivers/clk/clk-pwm.c:89:8: error: too few arguments to function 'pwm_config'
     ret = pwm_config(pwm, (pwm->period + 1) >> 1, pwm->period);
           ^
   In file included from drivers/clk/clk-pwm.c:15:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/gpu/drm/i915/intel_panel.c:652:19: sparse: not enough arguments for function pwm_config
   drivers/gpu/drm/i915/intel_panel.c:797:19: sparse: not enough arguments for function pwm_config
   drivers/gpu/drm/i915/intel_panel.c:1442:28: sparse: not enough arguments for function pwm_config
   drivers/gpu/drm/i915/intel_panel.c: In function 'pwm_set_backlight':
   drivers/gpu/drm/i915/intel_panel.c:652:2: error: too few arguments to function 'pwm_config'
     pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
     ^
   In file included from drivers/gpu/drm/i915/intel_panel.c:35:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/gpu/drm/i915/intel_panel.c: In function 'pwm_disable_backlight':
   drivers/gpu/drm/i915/intel_panel.c:797:2: error: too few arguments to function 'pwm_config'
     pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
     ^
   In file included from drivers/gpu/drm/i915/intel_panel.c:35:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/gpu/drm/i915/intel_panel.c: In function 'pwm_setup_backlight':
   drivers/gpu/drm/i915/intel_panel.c:1442:11: error: too few arguments to function 'pwm_config'
     retval = pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERIOD_NS,
              ^
   In file included from drivers/gpu/drm/i915/intel_panel.c:35:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/hwmon/pwm-fan.c:51:25: sparse: not enough arguments for function pwm_config
   drivers/hwmon/pwm-fan.c:240:25: sparse: not enough arguments for function pwm_config
   drivers/hwmon/pwm-fan.c:313:25: sparse: not enough arguments for function pwm_config
   drivers/hwmon/pwm-fan.c: In function '__set_pwm':
   drivers/hwmon/pwm-fan.c:51:8: error: too few arguments to function 'pwm_config'
     ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
           ^
   In file included from drivers/hwmon/pwm-fan.c:25:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/hwmon/pwm-fan.c: In function 'pwm_fan_probe':
   drivers/hwmon/pwm-fan.c:240:8: error: too few arguments to function 'pwm_config'
     ret = pwm_config(ctx->pwm, duty_cycle, ctx->pwm->period);
           ^
   In file included from drivers/hwmon/pwm-fan.c:25:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/hwmon/pwm-fan.c: In function 'pwm_fan_resume':
   drivers/hwmon/pwm-fan.c:313:8: error: too few arguments to function 'pwm_config'
     ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
           ^
   In file included from drivers/hwmon/pwm-fan.c:25:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/input/misc/pwm-beeper.c:56:33: sparse: not enough arguments for function pwm_config
   drivers/input/misc/pwm-beeper.c:161:27: sparse: not enough arguments for function pwm_config
   drivers/input/misc/pwm-beeper.c: In function 'pwm_beeper_event':
   drivers/input/misc/pwm-beeper.c:56:9: error: too few arguments to function 'pwm_config'
      ret = pwm_config(beeper->pwm, period / 2, period);
            ^
   In file included from drivers/input/misc/pwm-beeper.c:21:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/input/misc/pwm-beeper.c: In function 'pwm_beeper_resume':
   drivers/input/misc/pwm-beeper.c:161:3: error: too few arguments to function 'pwm_config'
      pwm_config(beeper->pwm, beeper->period / 2, beeper->period);
      ^
   In file included from drivers/input/misc/pwm-beeper.c:21:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/leds/leds-pwm.c:46:19: sparse: not enough arguments for function pwm_config
   drivers/leds/leds-pwm.c: In function '__led_pwm_set':
   drivers/leds/leds-pwm.c:46:2: error: too few arguments to function 'pwm_config'
     pwm_config(led_dat->pwm, new_duty, led_dat->period);
     ^
   In file included from drivers/leds/leds-pwm.c:22:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/regulator/pwm-regulator.c:64:25: sparse: not enough arguments for function pwm_config
   drivers/regulator/pwm-regulator.c:123:25: sparse: not enough arguments for function pwm_config
   drivers/regulator/pwm-regulator.c: In function 'pwm_regulator_set_voltage_sel':
   drivers/regulator/pwm-regulator.c:64:8: error: too few arguments to function 'pwm_config'
     ret = pwm_config(drvdata->pwm, dutycycle, pwm_reg_period);
           ^
   In file included from drivers/regulator/pwm-regulator.c:22:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/regulator/pwm-regulator.c: In function 'pwm_regulator_set_voltage':
   drivers/regulator/pwm-regulator.c:123:8: error: too few arguments to function 'pwm_config'
     ret = pwm_config(drvdata->pwm, (period / 100) * duty_cycle, period);
           ^
   In file included from drivers/regulator/pwm-regulator.c:22:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/video/backlight/lm3630a_bl.c:168:19: sparse: not enough arguments for function pwm_config
   drivers/video/backlight/lm3630a_bl.c: In function 'lm3630a_pwm_ctrl':
   drivers/video/backlight/lm3630a_bl.c:168:2: error: too few arguments to function 'pwm_config'
     pwm_config(pchip->pwmd, duty, period);
     ^
   In file included from drivers/video/backlight/lm3630a_bl.c:19:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/video/backlight/lp855x_bl.c:251:19: sparse: not enough arguments for function pwm_config
   drivers/video/backlight/lp855x_bl.c: In function 'lp855x_pwm_ctrl':
   drivers/video/backlight/lp855x_bl.c:251:2: error: too few arguments to function 'pwm_config'
     pwm_config(lp->pwm, duty, period);
     ^
   In file included from drivers/video/backlight/lp855x_bl.c:19:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
>> drivers/video/backlight/pwm_bl.c:69:19: sparse: not enough arguments for function pwm_config
   drivers/video/backlight/pwm_bl.c:108:27: sparse: not enough arguments for function pwm_config
   drivers/video/backlight/pwm_bl.c: In function 'pwm_backlight_power_off':
   drivers/video/backlight/pwm_bl.c:69:2: error: too few arguments to function 'pwm_config'
     pwm_config(pb->pwm, 0, pb->period);
     ^
   In file included from drivers/video/backlight/pwm_bl.c:22:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
   drivers/video/backlight/pwm_bl.c: In function 'pwm_backlight_update_status':
   drivers/video/backlight/pwm_bl.c:108:3: error: too few arguments to function 'pwm_config'
      pwm_config(pb->pwm, duty_cycle, pb->period);
      ^
   In file included from drivers/video/backlight/pwm_bl.c:22:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
   drivers/video/fbdev/ssd1307fb.c:150:29: sparse: incorrect type in initializer (different address spaces)
   drivers/video/fbdev/ssd1307fb.c:150:29:    expected unsigned char [usertype] *vmem
   drivers/video/fbdev/ssd1307fb.c:150:29:    got char [noderef] <asn:2>*screen_base
   drivers/video/fbdev/ssd1307fb.c:226:13: sparse: incorrect type in assignment (different address spaces)
   drivers/video/fbdev/ssd1307fb.c:226:13:    expected unsigned char [noderef] [usertype] <asn:2>*dst
   drivers/video/fbdev/ssd1307fb.c:226:13:    got void *<noident>
   drivers/video/fbdev/ssd1307fb.c:228:28: sparse: incorrect type in argument 1 (different address spaces)
   drivers/video/fbdev/ssd1307fb.c:228:28:    expected void *to
   drivers/video/fbdev/ssd1307fb.c:228:28:    got unsigned char [noderef] [usertype] <asn:2>*dst
>> drivers/video/fbdev/ssd1307fb.c:299:27: sparse: not enough arguments for function pwm_config
   drivers/video/fbdev/ssd1307fb.c: In function 'ssd1307fb_init':
   drivers/video/fbdev/ssd1307fb.c:299:3: error: too few arguments to function 'pwm_config'
      pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
      ^
   In file included from drivers/video/fbdev/ssd1307fb.c:17:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^

vim +89 drivers/clk/clk-pwm.c

9a74ccdb Philipp Zabel 2015-02-13  73  
9a74ccdb Philipp Zabel 2015-02-13  74  	if (!pwm->period) {
9a74ccdb Philipp Zabel 2015-02-13  75  		dev_err(&pdev->dev, "invalid PWM period\n");
9a74ccdb Philipp Zabel 2015-02-13  76  		return -EINVAL;
9a74ccdb Philipp Zabel 2015-02-13  77  	}
9a74ccdb Philipp Zabel 2015-02-13  78  
9a74ccdb Philipp Zabel 2015-02-13  79  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
9a74ccdb Philipp Zabel 2015-02-13  80  		clk_pwm->fixed_rate = NSEC_PER_SEC / pwm->period;
9a74ccdb Philipp Zabel 2015-02-13  81  
9a74ccdb Philipp Zabel 2015-02-13  82  	if (pwm->period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
9a74ccdb Philipp Zabel 2015-02-13  83  	    pwm->period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
9a74ccdb Philipp Zabel 2015-02-13  84  		dev_err(&pdev->dev,
9a74ccdb Philipp Zabel 2015-02-13  85  			"clock-frequency does not match PWM period\n");
9a74ccdb Philipp Zabel 2015-02-13  86  		return -EINVAL;
9a74ccdb Philipp Zabel 2015-02-13  87  	}
9a74ccdb Philipp Zabel 2015-02-13  88  
9a74ccdb Philipp Zabel 2015-02-13 @89  	ret = pwm_config(pwm, (pwm->period + 1) >> 1, pwm->period);
9a74ccdb Philipp Zabel 2015-02-13  90  	if (ret < 0)
9a74ccdb Philipp Zabel 2015-02-13  91  		return ret;
9a74ccdb Philipp Zabel 2015-02-13  92  
9a74ccdb Philipp Zabel 2015-02-13  93  	clk_name = node->name;
9a74ccdb Philipp Zabel 2015-02-13  94  	of_property_read_string(node, "clock-output-names", &clk_name);
9a74ccdb Philipp Zabel 2015-02-13  95  
9a74ccdb Philipp Zabel 2015-02-13  96  	init.name = clk_name;
9a74ccdb Philipp Zabel 2015-02-13  97  	init.ops = &clk_pwm_ops;

:::::: The code at line 89 was first introduced by commit
:::::: 9a74ccdbbb8fa6302ae1ba606f2ef0c03d3242ab clk: Add PWM clock driver

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Michael Turquette <mturquette@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
