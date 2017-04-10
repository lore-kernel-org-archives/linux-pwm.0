From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: fix gpio-only operation.
Date: Mon, 10 Apr 2017 12:08:05 -0400
Message-ID: <CAGngYiXK0R4+CkVnPuBUp9sKzg3Fng306o8SiPJEf9uVABScYQ@mail.gmail.com>
References: <1491754284-3870-1-git-send-email-svenv@arcx.com>
 <1491754284-3870-2-git-send-email-svenv@arcx.com> <20170410103320.GG2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34530 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbdDJQIR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2017 12:08:17 -0400
In-Reply-To: <20170410103320.GG2957@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, andriy.shevchenko@linux.intel.com

Thanks for the feedback Mika, I really appreciate it.

> How about implementing a real runtime PM in the driver? Then when the
> device is idle regardless of whether it is GPIO or PWM, the SLEEP bit is
> set and cleared accordingly.

The current code will keep driving pwms/leds even when these are
currently not exported in sysfs. Until the last export disappears.
That behaviour feels counter-intuitive to me.

Example:
1. export pwm1 and pwm2
    echo 1 > export
    echo 2 > export
2. configure/enable pwm1 and pwm2
3. enjoy the blinkenlights on your board
4. unexport pwm1
    echo 1 > unexport
    both pwms are still driven !
5. unexport pwm2
    echo 2 > unexport
    both pwms shut down !
6. export pwm1
echo 1 > export
both pwms come back on !

Do we want to get rid of this behaviour? I see two intuitive alternatives:

a) keep SLEEP off all the time, so LEDs are still driven even when no
pwms/gpios are exported.

Pro: simple, predictable
Con: not power efficient

b) when a pwm/gpio is unexported, turn off the LED. when all pwms/gpios
are unexported, set the SLEEP bit.

Pro: power efficient
Con: output turns off when gpio/pwm is unexported, this may surprise users

Sven
