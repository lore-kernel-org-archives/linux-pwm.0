From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Configuring multiple PWM channels in one step
Date: Fri, 21 Oct 2016 19:30:19 +0200
Message-ID: <20161021173019.GA24301@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:25189 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbcJURaY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Oct 2016 13:30:24 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Hi,

we control flow valves through PCA9685 PWM chips and the duty cycle
values are changing continuously.
With the current PWM API, every duty cycle change is sent out
individually to the I2C bus.

What do you think about a config_multiple feature to atomically set the
duty cycles of several channels in one step?
(Somewhat similar to the set_multiple function in struct gpio_chip)

Some pwm chips have special registers to configure subsets of outputs at
once. But even if that's not available, sending the values for multiple
channels in one step is an improvement, especially on a slow bus.

One possibility would be to add a new structure to atomically configure
all outputs of a pwm chip:

I'd only make the duty cycle (and maybe the enabled state) individually
configurable. Period and polarity should be set for all, because on many
chips, these are chip-wide settings.

struct pwm_chip_state {
	unsigned int period;
	unsigned int *duty_cycles;
	enum pwm_polarity polarity;
	unsigned int enabled_mask;
};

Then adding a pwm_chip_apply_state function which takes a pointer to the
struct pwm_chip and the struct pwm_chip_state.

For the drivers we would need a .config_multiple function in pwm_ops.
Maybe something like:
int (*config_multiple)(struct pwm_chip *chip, unsigned int change_mask,
unsigned int *duty_cycles_ns, unsigned int enabled_mask,
unsigned int period_ns, enum pwm_polarity polarity);
And if there is no implementation, a fallback to configure it
sequentially.

--

Or am I going in the wrong direction here, with this idea?

Thanks,
Clemens
