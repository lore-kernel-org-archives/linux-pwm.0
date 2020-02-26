From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date: Wed, 26 Feb 2020 16:10:34 +0100
Message-ID: <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60929 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBZPKg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 10:10:36 -0500
Content-Disposition: inline
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Matthias,

as you seem to have this hardware on your desk, it would be great if you
could answer the following questions:

 - Does the hardware complete the currently running period before
   applying a new setting?
 - Is this racy somehow (i.e. can it happen that when going from
   duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000 the
   output is 1000/10000 (or 4000/5000) for one cycle)?
 - Does the hardware complete the currently running period before
   .enabled = false is configured?
 - How does the output pin behave on a disabled PWM. (Usual candidates
   are: freeze where is just happens to be, constant inactive and
   High-Z).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
