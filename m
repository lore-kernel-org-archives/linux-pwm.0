From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a GPIO
Date: Sun, 23 Oct 2016 12:23:03 +0200
Message-ID: <CACRpkdYsD76ZN9jLZWXKiW40vPcxz9+OvKc7sQzKhAurpR0_Ew@mail.gmail.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com> <20161020104541.GA25598@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34010 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbcJWKXE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Oct 2016 06:23:04 -0400
Received: by mail-qt0-f178.google.com with SMTP id q7so113261951qtq.1
        for <linux-pwm@vger.kernel.org>; Sun, 23 Oct 2016 03:23:04 -0700 (PDT)
In-Reply-To: <20161020104541.GA25598@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Thu, Oct 20, 2016 at 12:45 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> It seems to me like maybe pinmux would be a better framework to handle
> this kind of use case. The full on/off bit sounds like it's a mux that
> selects between GPIO and PWM functionality.

Muxing is mostly selecting between two or more hardware blocks to be
routed to one and the same pin. Like if there was a GPIO block and a PWM
block and either could be routed to the pin.

So selecting between two physical drivers behind the pin.

What you are describing seems more like muxing two different usecases
on the same PWM hardware, I don't think that is appropriate for pin
multiplexing.

I would more say that if the PWM is used as GPIO then it is a neat hack
with a PWM set to duty cycle 100% or 0% and as such should be a
GPIO driver on top of the PWM. Supported in the core as described
in the other responses.

Yours,
Linus Walleij
