From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] clk: Add PWM clock driver
Date: Wed, 10 Sep 2014 22:05:17 +0200
Message-ID: <5410AEFD.5030302@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:64353 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752438AbaIJUFN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Sep 2014 16:05:13 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Mike Turquette <mturquette@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

Hi,

http://patchwork.ozlabs.org/patch/359069/
https://lkml.org/lkml/2014/6/12/186

Will the patch ever included to linux-next?

pwm_config()  API could be extended to support
not only period [ns] and duty [ns] time
but also frequency [Hz] and duty cycle fraction [1/1000?]
(instead of time in ns) as parameters.
Then  ns (rounded by pwm) to freq. conversion problem
inclk_pwm_recalc_rate() usingpwm_get_period()
could be avoided.
To extend the API pwm_config() can support
new flags forduty_ns and period_ns,
eg. PWM_DUTY_PERCENT and PWM_PERIOD_HZ.


best regards
Janusz

