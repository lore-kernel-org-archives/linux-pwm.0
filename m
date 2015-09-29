From: Olliver Schinagl <oliver+list@schinagl.nl>
Subject: [RFC] pwm: core: unsigned or signed ints for pwm_config
Date: Tue, 29 Sep 2015 09:19:27 +0200
Message-ID: <560A3B7F.30803@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:52322 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499AbbI2HTb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 29 Sep 2015 03:19:31 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hey Thierry, list

I'm going over the pwm core and notice that in the pwm header, duty_ns 
and period_ns is internally stored as an unsigned int.

struct pwm_device {
     const char *label;
     unsigned long flags;
     unsigned int hwpwm;
     unsigned int pwm;
     struct pwm_chip *chip;
     void *chip_data;

     unsigned int period;
     unsigned int duty_cycle;
     enum pwm_polarity polarity;
};

However, pwm_config takes signed ints
int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);

So digging a little deeper in the PWM core, I see that pwm_config 
dissallows negative ints, so having them unsigned has no benefit (and 
technically is illegal)
     if (!pwm  || duty_ns < 0|| period_ns= 0 || duty_ns > period_ns)
         return -EINVAL;

and because (after the check) we cram the signed int into an unsigned one:

     pwm->duty_cycle = duty_ns;
     pwm->period = period_ns;

This could end up badly when using any unsigned int larger then INT_MAX 
and thus ending up with a negative duty/period. I haven't checked deeper 
if this is accounted for later, but would it be worth my time to convert 
all ints to unsigned ints? Since negative period and duty cycles are 
really not possible anyway?

Olliver
