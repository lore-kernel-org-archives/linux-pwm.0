From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: bcm2835-analog-audio: Is my driver PWM, ALSA or neither
Date: Sun, 12 Mar 2017 18:36:38 +0100 (CET)
Message-ID: <2077895555.313298.1489340198772@email.1und1.de>
References: <1489315021.23529.3.camel@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934617AbdCLRhX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Mar 2017 13:37:23 -0400
In-Reply-To: <1489315021.23529.3.camel@crowfest.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Zoran <mzoran@crowfest.net>
Cc: alsa-devel@alsa-project.org, eric@anholt.net, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org


> Michael Zoran <mzoran@crowfest.net> hat am 12. März 2017 um 11:37 geschrieben:
> 
> 
> I have submitted to ALSA a driver that uses the PWM hardware of the
> Raspbery PI(bcm2835) as an audio driver.
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/118652.
> html
> 
> The driver is currently mutually exclusive with the standard PWM
> driver, mostly because the standard PWM interface is not adequate to
> have an audio driver written on top of it.  
> 
> But as I think more, I see no reason the user needs to chose at boot
> time if they want traditional PWM or AUDIO. So I'm thinking of some how
> combining the two drivers.
> 
> My question:
> 1. Is my driver a PWM driver that exposes an ALSA interface in additon
> to PWM?
> 2. Is my driver a ALSA driver that also exposes PWM.
> 3. Could my driver potentially go under misc or something new and
> expose both a PWM and ALSA interface.
> 4. Perhaps I should have both a PWM driver and a ALSA driver that both
> talk through a totally new but very small driver that controls access
> to the PWM hardware.  How would the function drivers get loaded in this
> case?

Sorry, i'm not a sound expert. But this sounds like a multi-function device driver (mfd) to me.

AFAIK this doesn't provide solution for your dynamic usage problem.
