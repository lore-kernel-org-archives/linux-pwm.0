Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:33923 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeDRPkL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Apr 2018 11:40:11 -0400
Received: by mail-ot0-f177.google.com with SMTP id i5-v6so2423333oth.1
        for <linux-pwm@vger.kernel.org>; Wed, 18 Apr 2018 08:40:10 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Doyle <wpdster@gmail.com>
Date: Wed, 18 Apr 2018 11:39:39 -0400
Message-ID: <CAF_dkJA6JdDA9CPmsqgVrRaMiJ4=Wjn_G4t9PETUFD2X7-qdcA@mail.gmail.com>
Subject: Augmenting sysfs interface for a PWM driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org

I would like to add some features to the Atmel(/Microchip) pwm-atmel
driver and would like to access those features via sysfs.

Back story -- I have the high and low PWM outputs on my Atmel SoC
connected to a TI motor driver chip, rather than directly to FETs as
the peripheral was intended to be used.  I can wiggle the HIGH side
output and hold the LOW side output low to make the motor spin
forward, and wiggle the LOW side output, keeping the HIGH side output
low, to make the motor spin backward.

So, I would like to add the ability to override the PWM outputs (which
the peripheral supports).

AFAIK, the only way for me to control the PWM peripheral from user
space is via sysfs.  Consequently, the only way I know to control the
override outputs is via sysfs.

So... how can I add entries to the sysfs for the PWM channel?

I can hack up the pwm subsystem to do this, but I feel like this might
be a pwm-atmel specific feature, and I don't want to burden all the
other drivers with this.  But I guess I could.

Anyway, this project opens up a whole bunch of questions for me that I
should probably seek the opinions of the PWM community at large before
proceeding much further.

Is this a bad idea from the start?
Is there an easy way for me to add sysfs entries for a PWM channel?
Is there a better way for me to do this?

Should I even be using the sysfs interface to control the PWM
peripheral from my user space application?  What else would I use?

I guess I could write a "motor control" driver, but that driver
wouldn't do much more than just pass its arguments to the pwm-atmel
driver.

Any thoughts, comments, snide remarks?

--wpd
