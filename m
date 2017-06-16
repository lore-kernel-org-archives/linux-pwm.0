From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: change compatible string for PWM support
Date: Fri, 16 Jun 2017 11:13:40 +0200
Message-ID: <CACRpkdZErh0PKy6+D7a23Js5d9n+eN_HVXhuatOFHGJRfObogA@mail.gmail.com>
References: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
 <CACRpkdY7yy=U1DgFHXGd06UXg0hh5eC7mBKHLr7hq01hR__q8g@mail.gmail.com> <CACQ1gAht7kPysPofvyykYrfcRgJ_i_FFC8NqyN+J2L9WXwHfcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38177 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdFPJNm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Jun 2017 05:13:42 -0400
Received: by mail-it0-f47.google.com with SMTP id b205so10009224itg.1
        for <linux-pwm@vger.kernel.org>; Fri, 16 Jun 2017 02:13:42 -0700 (PDT)
In-Reply-To: <CACQ1gAht7kPysPofvyykYrfcRgJ_i_FFC8NqyN+J2L9WXwHfcg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Ralph Sennhauser <ralph.sennhauser@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 9, 2017 at 9:45 AM, Richard Genoud <richard.genoud@gmail.com> wrote:
> 2017-06-09 9:42 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Thu, Jun 1, 2017 at 10:08 PM, Ralph Sennhauser
>> <ralph.sennhauser@gmail.com> wrote:
>>
>>> As it turns out more than just Armada 370 and XP support using GPIO
>>> lines as PWM lines. For example the Armada 38x family has the same
>>> hardware support. As such "marvell,armada-370-xp-gpio" for the
>>> compatible string is a misnomer.
>>>
>>> Change the compatible string to "marvell,armada-370-gpio" before the
>>> driver makes it out of the -rc stage. This also follows the practice of
>>> using only the first device family supported as part of the name.
>>>
>>> Also update the documentation and comments in the code accordingly.
>>>
>>> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
>>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>>
>> Patch applied for next with the tags.
> You mean for fixes right ?
> The goal was to correct "marvell,armada-370-xp-gpio" before 4.12 is out.

OK I moved it to fixes.

Yours,
Linus Walleij
