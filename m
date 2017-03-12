From: Michael Zoran <mzoran@crowfest.net>
Subject: bcm2835-analog-audio: Is my driver PWM, ALSA or neither
Date: Sun, 12 Mar 2017 03:37:01 -0700
Message-ID: <1489315021.23529.3.camel@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gw.crowfest.net ([52.42.241.221]:56004 "EHLO gw.crowfest.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755672AbdCLKhD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 12 Mar 2017 06:37:03 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org
Cc: eric@anholt.net, stefan.wahren@i2se.com

I have submitted to ALSA a driver that uses the PWM hardware of the
Raspbery PI(bcm2835) as an audio driver.

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/118652.
html

The driver is currently mutually exclusive with the standard PWM
driver, mostly because the standard PWM interface is not adequate to
have an audio driver written on top of it.  

But as I think more, I see no reason the user needs to chose at boot
time if they want traditional PWM or AUDIO. So I'm thinking of some how
combining the two drivers.

My question:
1. Is my driver a PWM driver that exposes an ALSA interface in additon
to PWM?
2. Is my driver a ALSA driver that also exposes PWM.
3. Could my driver potentially go under misc or something new and
expose both a PWM and ALSA interface.
4. Perhaps I should have both a PWM driver and a ALSA driver that both
talk through a totally new but very small driver that controls access
to the PWM hardware.  How would the function drivers get loaded in this
case?

And the $10,000 question of the day is who should I be e-mailing the
driver to and which topic branches should the driver be merged through?
