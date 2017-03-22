From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v3 0/2] switch to atomic PWM
Date: Wed, 22 Mar 2017 15:29:33 +0200
Message-ID: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, cristian.birsan-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, andrei.pistirica-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Changes in v3:
- since v2 introduced per-IP register layout there is no need
to keep update_cdty and set_cprd_cdty members in atmel_pwm_data
data structure used in v2; doing in this way the atmel_pwm_data
data structure will remain with only one member, regs. To avoid
another level of indirection, the atmel_pwm_data has been removed
and only atmel_pwm_registers data structure has been keept. In
this way, "data" member of atmel_pwm_chip data structure was
replaced by "regs" member; due to these changes prototype of
atmel_pwm_get_driver_data() function was also changed;
also, driver private data variables were renamed in the following
format "atmel_pwm_regs_v*"
- there is no need for the following checks at the begining
of atmel_pwm_apply() which were present in v2:

	if (cstate.enabled &&
	    (cstate.polarity != state->polarity ||
	     cstate.period != state->period))
		pwm_reset = true;

it is enough to add:

	if (state->enabled) {
		if (cstate.enabled &&
		    cstate.polarity == state->polarity &&
		    cstate.period == state->period) {

inside "if (state->enabled)" block and also to check cstate.enabled
instead of checking pwm_reset variable introduced in v2:

		if (cstate.enabled) {
			atmel_pwm_disable(chip, pwm, false);
		} else {
			ret = clk_enable(atmel_pwm->clk);
			if (ret) {
				dev_err(chip->dev, "failed to enable clock\n");
				return ret;
			}
		}

Changes in v2:
- update only duty factor without disabling the PWM channel
- if PWM channel is enabled, period, as signal polarity, is
updated by disabling + enabling the PWM channel
- atmel_pwm_config_prepare() function has been removed and
added instead two functions, one to compute the CPRD+Prescaler
(atmel_pwm_calculate_cprd_and_pres()), one to compute CRDY
(atmel_pwm_calculate_cdty())
- atmel_pwm_config_set() body was directly moved to atmel_pwm_apply()
- add 3 new members to atmel_pwm_data: update_cdty, set_cprd_cdty and
regs:
	- update_cdty is called to configure duty factor without
	disabling PWM channel, when necessary
	- set_cprd_cdty is called to configure both period and
	duty factor parameters
	- regs keeps the period and duty registers and was added to
	have common functions for update_cdty and set_cprd_cdty
	members of atmel_pwm_data for all boards;
- add a new parameter to atmel_pwm_disable(); this will be used in
updating period + signal polarity by disabling + enabling the
PWM channel. In this case, there is no need to disable PWM clock
since new configuration will be imediately applied.
- adapted the other reviewer comments excepts the one regarding
"cdty = cprd - cycles;" from atmel_pwm_calculate_cdty() since
in atmel_pwm_apply(), selecting polarity in the other way arround
than is currently done in this commit will need the changing of DPOLI
bit from Channel Mode Register, in order to keep the initial
output level of PWM channel after disable operation; this works
for sama5d2 but not for sam9rl which hasn't document the DPOLI
bit in datasheet; sama5d3 also hasn't document the DPOLI bit in
datasheet; one option was to have different aproach for different
boards but the code becomes messy.

Claudiu Beznea (2):
  drivers: pwm: pwm-atmel: switch to atomic PWM
  drivers: pwm: pwm-atmel: enable PWM on sama5d2

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 276 ++++++++++-----------
 2 files changed, 133 insertions(+), 144 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
